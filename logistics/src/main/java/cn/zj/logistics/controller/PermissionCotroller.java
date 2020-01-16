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
import cn.zj.logistics.pojo.Permission;
import cn.zj.logistics.pojo.PermissionExample;
import cn.zj.logistics.pojo.PermissionExample.Criteria;
import cn.zj.logistics.service.PermissionService;
import cn.zj.logistics.service.RoleService;

@Controller
@RequestMapping("/permission")
public class PermissionCotroller {

	@Autowired
	private PermissionService permissionService;

	@RequestMapping("/permissionPage")
	public String permissionPage() {
		return "permissionPage";
	}

	//获取所有的权限信息作为z-tree显示
	@RequestMapping("/getAllPerrmission")
	@ResponseBody
	public List<Permission> getAllPermission() {
		PermissionExample example = new PermissionExample();
		List<Permission> permissions = permissionService.selectByExample(example);
		return permissions;
	}
	
	//权限查询列表
	@RequestMapping("/list")
	@ResponseBody
	public PageInfo list(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "10") int pageSize,
			String keyword) {

		// mybatis的分页插件的使用,开启分页
		PageHelper.startPage(pageNum, pageSize);

		PermissionExample example = new PermissionExample();
		// 判断keywork是否为空，使用commons-lang对原有的Java类型增强的操作
		if (StringUtils.isNotBlank(keyword)) {
			Criteria criteria = example.createCriteria();
			criteria.andNameLike("%"+keyword+"%");
		}
		List<Permission> permissions = permissionService.selectByExample(example);

		/*
		 * 创建分页对象来接收分页后的数据
		 * 
		 */
		PageInfo<Permission> pageInfo = new PageInfo<Permission>(permissions);

		return pageInfo;
	}

	//权限删除功能
	@RequestMapping("/delete")
	@ResponseBody
	public MessageObject delete(Long permissionId) {
		System.out.println("permissionId:"+permissionId);
		MessageObject mo = MessageObject.createMessageObject(0, "删除数据失败，此权限是子权限！");
		//查看是否还有父权限
		PermissionExample example = new PermissionExample();
		Criteria criteria = example.createCriteria();
		criteria.andParentIdEqualTo(permissionId);
		List<Permission> parents = permissionService.selectByExample(example);
		//null表示没有
		if(parents.size() == 0) {
			int row = permissionService.deleteByPrimaryKey(permissionId);
			if (row == 1) {
				mo = MessageObject.createMessageObject(1, "删除成功");
			}else {
				mo = MessageObject.createMessageObject(0, "删除数据失败，请联系管理员");
			}
		}
		return mo;
	}
	
	//检查用户名是否重复
	@RequestMapping("/checkPermissionname")
	@ResponseBody
	public Boolean checkPermissionname(String permissionname) {
		
		PermissionExample example = new PermissionExample();
		Criteria criteria = example.createCriteria();
		criteria.andNameEqualTo(permissionname);
		List<Permission> permissions = permissionService.selectByExample(example);
		
		return permissions.size() == 0 ? true : false;
	}
	
	// 新增功能和修改功能的跳转
	@RequestMapping("/permissionEdit")
	public String permissionEdit(Model m,Long permissionId) {
		
		//修改时的数据回显
		if(permissionId != null) {
			Permission permission = permissionService.selectByPrimaryKey(permissionId);
			m.addAttribute("permission", permission);
		}
		
		
		//只有菜单权限才能显示
		PermissionExample example = new PermissionExample();
		Criteria criteria = example.createCriteria();
		criteria.andTypeEqualTo("menu");
		List<Permission> parents = permissionService.selectByExample(example);
		
		m.addAttribute("parents", parents);
		
		return "permissionEdit";
	}
	
	//权限新增功能
	@RequestMapping("/insert")
	@ResponseBody
	public MessageObject insert(Permission permission) {
		MessageObject mo = MessageObject.createMessageObject(0, "新增失败，请联系管理员");
		int row = permissionService.insert(permission);
		if(row > 0) {
			mo = MessageObject.createMessageObject(1, "新增成功");
		}
		return mo;
	}
	
	//权限修改功能
	@RequestMapping("/update")
	@ResponseBody
	public MessageObject update(Permission permission) {
		MessageObject mo = MessageObject.createMessageObject(0, "修改失败，请联系管理员");
		int row = permissionService.updateByPrimaryKeySelective(permission);
		if(row > 0) {
			mo = MessageObject.createMessageObject(1, "修改成功");
		}
		return mo;
	}
	
	//批量删除
	@RequestMapping("/deleteChecked")
	@ResponseBody
	public MessageObject deleteChecked(String permissionIds) {
		MessageObject mo = MessageObject.createMessageObject(0, "删除数据失败，批量选中含有子权限！");
		String[] permissionIdsArr = permissionIds.split(",");
		List<Permission> parents = null;
		for(int i = 0; i< permissionIdsArr.length; i++) {
			//查看是否还有父权限
			PermissionExample example = new PermissionExample();
			Criteria criteria = example.createCriteria();
			criteria.andParentIdEqualTo(Long.parseLong(permissionIdsArr[i]));
			parents = permissionService.selectByExample(example);
		}
		if(parents.size() == 0) {
			int row = permissionService.deleteByArray(permissionIdsArr);
			if(row > 0 ) {
				mo = MessageObject.createMessageObject(1, "批量删除成功");
			}else {
				mo = MessageObject.createMessageObject(0, "批量删除失败，请联系管理员");
			}
		}
		return mo;
	}
}
