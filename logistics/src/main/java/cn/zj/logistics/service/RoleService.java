package cn.zj.logistics.service;

import cn.zj.logistics.pojo.Role;
import cn.zj.logistics.pojo.RoleExample;

import java.util.List;

public interface RoleService {
	
	int deleteByArray(String[] roleIdsArr);
	
    int deleteByPrimaryKey(Long roleId);

    int insert(Role record);

    List<Role> selectByExample(RoleExample example);

    Role selectByPrimaryKey(Long roleId);

    int updateByPrimaryKeySelective(Role record);
}
