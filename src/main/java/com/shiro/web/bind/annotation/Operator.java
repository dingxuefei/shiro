package com.shiro.web.bind.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


/**
 * @ClassName Operator.java
 * @Description 标记操作记录
 *
 * @author 1904
 * @version V1.0 
 * @Date 2015年7月25日 下午12:30:54
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD,ElementType.METHOD,ElementType.TYPE})  
public @interface Operator {

	public String story() default "";//执行方法故事
	public String name() default "";//类名
	public boolean operatorClass() default true;//是否是标记日志类
}
