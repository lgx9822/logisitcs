package cn.zj.logistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.zj.logistics.pojo.User;
import cn.zj.logistics.pojo.UserExample;

public interface UserMapper {
	
	int deleteByArray(@Param("userIdsArr") String[] userIdsArr);
	
    int deleteByPrimaryKey(Long userId);

    int insert(User record);

    List<User> selectByExample(UserExample example);

    User selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(User record);

}