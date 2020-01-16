package cn.zj.logistics.mapper;

import cn.zj.logistics.pojo.Role;
import cn.zj.logistics.pojo.RoleExample;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface RoleMapper {
	
	int deleteByArray(@Param("roleIdsArr") String[] roleIdsArr);
	
    int deleteByPrimaryKey(Long roleId);

    int insert(Role record);

    int insertSelective(Role record);

    List<Role> selectByExample(RoleExample example);

    Role selectByPrimaryKey(Long roleId);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

	
}