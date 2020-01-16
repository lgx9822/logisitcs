package cn.zj.logistics.service;

import cn.zj.logistics.pojo.Permission;
import cn.zj.logistics.pojo.PermissionExample;

import java.util.List;

public interface PermissionService {
	
	int deleteByArray(String[] permissionIdsArr);
	
    int deleteByPrimaryKey(Long permissionId);

    int insert(Permission record);

    List<Permission> selectByExample(PermissionExample example);

    Permission selectByPrimaryKey(Long permissionId);

    int updateByPrimaryKeySelective(Permission record);
}
