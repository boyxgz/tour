package com.surelution.tour

import javax.persistence.Transient;

class PatrolLogItem implements Comparable<PatrolLogItem> {
	
	public static final HashMap answersMap = [1:"未检查", 2:"正常", 3:"不正常"]

	static transients = ["answerChar"]
	
	PatrolLog patrolLog
	PatrolLogTopic topic
	int answer
	String description
	
	String getAnswerChar() {
		def a = answersMap[answer]
		if(!a) {
			a = ""
		}
		a
	}

	/* (non-Javadoc)
	 * @see java.lang.Comparable#compareTo(java.lang.Object)
	 */
	@Override
	public int compareTo(PatrolLogItem o) {
		if(o) {
			int i = topic.index.compareTo(o.topic.index)
			if(i == 0) {
				i = topic.id.compareTo(o.topic.id)
			}
			return i
		}
		return -1;
	}	
	
}
