/**
 * 
 */
package com.surelution.tour.core;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">Guangzong</a>
 *
 */
public class MathUtil {

	public static double round(double value, int max) {
		int factor = (int)Math.pow(10, max);
		double d = value * factor;
		d = Math.round(d);
		return d / factor;
	}
	
	public static void main(String[] args) {
		System.out.println(round(123.45678,2));
	}
}
