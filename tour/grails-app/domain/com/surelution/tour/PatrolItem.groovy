package com.surelution.tour

class PatrolItem implements Comparable<PatrolItem> {

    static constraints = {
		patrol(nullable:true)
    }
	
	String addressCardSn
	Poi poi
	Date patrolTime
	
	/**
	 * record the sn not Wand, because some times the wand changes its information
	 */
	String wandSn
	
	User user
	
	Patrol patrol
	Date reportTime
	
	String remoteId

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("PatrolItem [addressCardSn=")
		
//		String ret = "PatrolItem [addressCardSn=" + addressCardSn + ", poi=" + poi + ", patrolTime=" + patrolTime + ", wandSn=" + wandSn
//				+ ", user=" + user + ", patrol=" + patrol + ", reportTime="
//				+ reportTime + ", remoteId=" 
//				+ remoteId + "]";
		return sb.toString();
	}	
	/* (non-Javadoc)
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo(PatrolItem o) {
		if(o == null) {
			return -1;
		} else 
			return -o.patrolTime.compareTo(reportTime);
	}
	
}
