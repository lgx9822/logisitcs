package cn.zj.logistics.mapper;

import cn.zj.logistics.pojo.Permission;
import cn.zj.logistics.pojo.PermissionExample;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface PermissionMapper {
	
	int deleteByArray(@Param("permissionIdsArr") String[] permissionIdsArr);
	
    int deleteByPrimaryKey(Long permissionId);

    int insert(Permission record);

    int insertSelective(Permission record);

    List<Permission> selectByExample(PermissionExample example);

    Permission selectByPrimaryKey(Long permissionId);

    int updateByPrimaryKeySelective(Permission record);

    int updateByPrimaryKey(Permission record);
}