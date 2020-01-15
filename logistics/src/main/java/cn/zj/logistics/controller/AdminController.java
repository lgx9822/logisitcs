package cn.zj.logistics.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.zj.logistics.mo.MessageObject;
import cn.zj.logistics.pojo.Role;
import cn.zj.logistics.pojo.RoleExample;
import cn.zj.logistics.pojo.User;
import cn.zj.logistics.pojo.UserExample;
import cn.zj.logistics.pojo.UserExample.Criteria;
import cn.zj.logistics.service.RoleService;
import cn.zj.logistics.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;

	@RequestMapping("/adminPage")
	public String adminPage() {
		return "adminPage";
	}
	//查询列表
	@RequestMapping("/list")
	@ResponseBody
	public PageInfo list(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "10") int pageSize,String keyword) {
		
		
		// mybatis的分页插件的使用,开启分页
		PageHelper.startPage(pageNum, pageSize);

		UserExample example = new UserExample();
		//判断keywork是否为空，使用commons-lang对原有的Java类型增强的操作
		if(StringUtils.isNotBlank(keyword)) {
		Criteria criteria = example.createCriteria();

		criteria.andUsernameLike("%" + keyword + "%");
		Criteria criteria2 = example.createCriteria();
		criteria2.andRealnameLike("%" + keyword + "%");
		example.or(criteria2);
		}
		List<User> users = userService.selectByExample(example);

		/*
		 * 创建分页对象来接收分页后的数据
		 * 
		 */
		PageInfo<User> pageInfo = new PageInfo<User>(users);
		
		return pageInfo;
	}
	
	//删除功能
	@RequestMapping("/delete")
	@ResponseBody
	public MessageObject delete(Long userId) {
		MessageObject mo = MessageObject.createMessageObject(0, "删除数据失败，请联系管理员");
		int row = userService.deleteByPrimaryKey(userId);
		if(row == 1) {
			mo = MessageObject.createMessageObject(1, "删除成功");
		}
		return mo;
	}
	//新增功能和修改功能的跳转
	@RequestMapping("/adminEdit")
	public String adminEdit(Model m,Long userId) {
		//如果用户id不等于空，说明是修改操作，查询用户对象共享过去，以供回显
		if(userId !=null) {
			User user = userService.selectByPrimaryKey(userId);
			m.addAttribute("user", user);
		}
		
		//查询出所有的角色
		RoleExample example = new RoleExample();
		List<Role> roles = roleService.selectByExample(example );
		
		m.addAttribute("roles", roles);
		boolean b = m.containsAttribute("roles");
		System.out.println("是否有roles:"+b);
		return "adminEdit";
	}
}
