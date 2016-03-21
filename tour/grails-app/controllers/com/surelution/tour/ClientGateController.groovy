package com.surelution.tour

import java.text.SimpleDateFormat;

import groovy.xml.MarkupBuilder;

class ClientGateController {

	public static final String FOUND_WAND = "FOUND-WAND"
	public static final String NO_SUCH_WAND = "NO-SUCH-WAND"
	
	def clockPatrolStrategyService
	def dayPatrolStrategyService

    def index = { }
	
	def patrolItemUpload = {
		Date now = new Date()
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss")
		def writer = new StringWriter()
		def xml = new MarkupBuilder(writer)
		//record format:remoteId,wandSn,poiSn,clientSn,patrolTime
		String record = params.record
		String dropping = params.dropping
		
		if(dropping) {
			dropping.splitEachLine("\n") {drop->
				String[] words = drop[0].split(",")
				String remoteId = words[0]
				String wandSn = words[1]
				String dropTime = words[2]
				def wand = Wand.findBySn(wandSn)
				if(wand) {
					def u = wand.user
					WandDropping wd = new WandDropping()
					wd.remoteId = remoteId
					wd.wandSn = wandSn
					wd.user = u
					wd.date = sdf.parse(dropTime)
					wd.reportDate = new Date()
					wd.save(flush:true)
				}
			}
		}
		
		xml.results() {
			record.splitEachLine("\n") {line->
				String[] words = line[0].split(",")
				if(words != null && words.length == 5) {
					String remoteId = words[0]
					String wandSn = words[1].toLowerCase();
					String poiSn = words[2]
					String clientSn = words[3]
					String patrolTime = words[4]
					PatrolItem item = new PatrolItem()
					
					println wandSn
					
					def wand = Wand.findBySn(wandSn)
					if(wand) {
						def u = Wand.findBySn(wandSn).user
						def p = Poi.findBySn(poiSn)
						
						item.remoteId = remoteId
						item.addressCardSn = poiSn
						item.wandSn = wandSn
						item.patrolTime = sdf.parse(patrolTime)
						item.reportTime = now
						item.user = u
						item.poi = p
						
						if(item.patrolTime < new Date()) {
							if(PatrolType.BY_DAY.equals(u.patrolType.code))
								dayPatrolStrategyService.save(item)
							else if(PatrolType.BY_CLOCK.equals(u.patrolType.code))
								clockPatrolStrategyService.save(item)
						}
					}

					result(
						remoteId:remoteId,
						wandSn:wandSn,
						poiSn:poiSn,
						clientSn:clientSn,
						patrolTime:patrolTime
					)
					
				}
			}
		}
		println(writer.toString())
		render(text:writer.toString(),contentType:"text/xml")
	}
	
	def shakeHands = {
		def wandSn = params.wandSn
		println wandSn
		def terminalTime = params.terminalTime
		def stationTime = params.stationTime
		def wand = Wand.findBySn(wandSn)
		def sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
		
		response.addHeader("Cache-Control", "no-cache")
		
		withFormat {
			xml {
				render(contentType:"text/xml") {
					result() {
						if(wand) {
							code(FOUND_WAND)
							sn(wand.sn)
							timeOK(true)
							serverTime(sdf.format(new Date()))
							user(wand.user.username)
							descirption(wand.description)
						} else {
							code(NO_SUCH_WAND)
						}
					}
				}
			}
		}
	}
	
	def systemInfo = {
		def ds = Department.list()
		def ps = PoiName.list()
		
		def sysInfo = servletContext["system-info"]
		
		response.addHeader("Cache-Control", "no-cache")
		withFormat {
			xml {
				render(contentType:"text/xml") {
					system() {
						departments() {
							if(ds) {
								ds.each {d -> 
									department(id:d.id, name:d.name)
								}
							}
						}
						pois() {
							sysInfo.poisSn.each {
								poi(name:it)
							}
						}
						poiNames() {
							if(ps) {
								ps.each {pname->
									poiName(name:pname.name)
								}
							}
						}
					}
				}
			}
		}
	}
	
	private boolean timeDiff(String remoteTime) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss")
		
		true
	}
}
