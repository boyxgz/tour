package com.surelution.tour

class UserPageEntry {

    static constraints = {
    }
	
	static belongsTo = [user:User, entry:PageEntry]
	
	static List<PageEntry> loadAllByUser(User user) {
		def userPageEntries = UserPageEntry.findAllByUser(user)
		def menus = new HashSet()
		userPageEntries.each {
			menus.add(it.entry.parent)
		}
		
		def authPages = userPageEntries.collect {
			it.entry
		}
		
		menus.each {entry->
			entry.children.each {child->
				def show = authPages.collect {it.id}.contains(entry.id)
				entry.metaClass.getShow {show}
			}
		}
		
		menus.sort {
			it.positionSeq
		}
	}
}
