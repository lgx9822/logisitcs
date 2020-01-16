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
import cn.zj.logistics.pojo.RoleExample.Criteria;
import cn.zj.logistics.pojo.User;
import cn.zj.logistics.pojo.UserExample;
import cn.zj.logistics.service.RoleService;
import cn.zj.logistics.service.UserService;

@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private RoleService roleService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/rolePage")
	public String rolePage() {
		return "rolePage";
	}

	//角色查询列表
	@RequestMapping("/list")
	@ResponseBody
	public PageInfo list(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "10") int pageSize,
			String keyword) {

		// mybatis的分页插件的使用,开启分页
		PageHelper.startPage(pageNum, pageSize);

		RoleExample example = new RoleExample();
		// 判断keywork是否为空，使用commons-lang对原有的Java类型增强的操作
		if (StringUtils.isNotBlank(keyword)) {
			Criteria criteria = example.createCriteria();
			criteria.andRolenameLike("%"+keyword+"%");
		}
		List<Role> roles = roleService.selectByExample(example);

		/*
		 * 创建分页对象来接收分页后的数据
		 * 
		 */
		PageInfo<Role> pageInfo = new PageInfo<Role>(roles);

		return pageInfo;
	}

	//角色删除功能
	@RequestMapping("/delete")
	@ResponseBody
	public MessageObject delete(Long roleId) {
		MessageObject mo = MessageObject.createMessageObject(0, "删除数据失败，此角色还有管理员！");
		//查看是否还有管理员
		UserExample example = new UserExample();
		cn.zj.logistics.pojo.UserExample.Criteria criteria = example.createCriteria();
		criteria.andRoleIdEqualTo(roleId);
		List<User> users = userService.selectByExample(example);
		
		//null表示没有
		if(users.size() == 0) {
			int row = roleService.deleteByPrimaryKey(roleId);
			if (row == 1) {
				mo = MessageObject.createMessageObject(1, "删除成功");
			}else {
				mo = MessageObject.createMessageObject(0, "删除数据失败，请联系管理员");
			}
		}
		return mo;
	}
	
	//检查用户名是否重复
	@RequestMapping("/checkRolename")
	@ResponseBody
	public Boolean checkRolename(String rolename) {
		
		RoleExample example = new RoleExample();
		Criteria criteria = example.createCriteria();
		criteria.andRolenameEqualTo(rolename);
		List<Role> roles = roleService.selectByExample(example);
		
		return roles.size() == 0 ? true : false;
	}
	
	// 新增功能和修改功能的跳转
	@RequestMapping("/roleEdit")
	public String roleEdit(Model m,Long roleId) {
		
		//修改时的数据回显
		if(roleId != null) {
			Role role = roleService.selectByPrimaryKey(roleId);
			m.addAttribute("role", role);
		}
		
		//只有菜单角色才能显示
		RoleExample example = new RoleExample();
		List<Role> roles = roleService.selectByExample(example);
		m.addAttribute("roles", roles);
		
		return "roleEdit";
	}
	
	//角色新增功能
	@RequestMapping("/insert")
	@ResponseBody
	public MessageObject insert(Role role) {
		MessageObject mo = MessageObject.createMessageObject(0, "新增失败，请联系管理员");
		int row = roleService.insert(role);
		if(row > 0) {
			mo = MessageObject.createMessageObject(1, "新增成功");
		}
		return mo;
	}
	
	//角色修改功能
	@RequestMapping("/update")
	@ResponseBody
	public MessageObject update(Role role) {
		MessageObject mo = MessageObject.createMessageObject(0, "修改失败，请联系管理员");
		int row = roleService.updateByPrimaryKeySelective(role);
		if(row > 0) {
			mo = MessageObject.createMessageObject(1, "修改成功");
		}
		return mo;
	}
	
	//批量删除
	@RequestMapping("/deleteChecked")
	@ResponseBody
	public MessageObject deleteChecked(String roleIds) {
		MessageObject mo = MessageObject.createMessageObject(0, "删除数据失败，批量选中还有管理员！");
		String[] roleIdsArr = roleIds.split(",");
		List<User> users = null;
		for(int i = 0; i< roleIdsArr.length; i++) {
			//查看是否还有管理员在使用
			UserExample example = new UserExample();
			cn.zj.logistics.pojo.UserExample.Criteria criteria = example.createCriteria();
			criteria.andRoleIdEqualTo(Long.parseLong(roleIdsArr[i]));
			users = userService.selectByExample(example);
		}
		if(users.size() == 0) {
			int row = roleService.deleteByArray(roleIdsArr);
			if(row > 0 ) {
				mo = MessageObject.createMessageObject(1, "批量删除成功");
			}else {
				mo = MessageObject.createMessageObject(0, "批量删除失败，请联系管理员");
			}
		}
		return mo;
	}
}
