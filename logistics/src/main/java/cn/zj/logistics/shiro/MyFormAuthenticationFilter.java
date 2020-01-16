package cn.zj.logistics.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

import cn.zj.logistics.pojo.User;

public class MyFormAuthenticationFilter extends FormAuthenticationFilter{
	
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
		System.out.println("-------------------");
		//获取主体对象
		Subject subject = getSubject(request, response);
		//获取session
		Session session = subject.getSession();
		if(!subject.isAuthenticated() && subject.isRemembered()) {
			User user = (User) subject.getPrincipal();
			session.setAttribute("loginUser", user);
		}
		
		return subject.isAuthenticated() || subject.isRemembered();
		
	}
}
