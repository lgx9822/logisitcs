package cn.zj.logistics.service;

import cn.zj.logistics.pojo.User;
import cn.zj.logistics.pojo.UserExample;

import java.util.List;

public interface UserService {
    int deleteByPrimaryKey(Long userId);

    int insert(User record);

    List<User> selectByExample(UserExample example);

    User selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(User record);
}
