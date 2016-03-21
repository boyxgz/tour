package com.surelution.tour

/**
 * 这个类型有些难以理解，是因为：<br/>
 * 回罐油的概念在最初始时是认为油品凡是回到油罐里的情况就都是回罐油，但是，经过深入的理解，不是这么回事，
 * 有的油品不一定会回到油罐，更加确切的说法是非销售性质的油品流出，比如校枪，维修等，甚至站内发电机要用油。
 * 最初始并没有sumary这个类型，只有GasRecircling，后期添加进来这个类型，但是，系统已有了一部分数据，
 * 只好两个类型中有部分数据宂余
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
class GasRecirclingSummary {

    static constraints = {
    }
	
	Department department
	GasRecirclingType type
	Date time
	User user
}
