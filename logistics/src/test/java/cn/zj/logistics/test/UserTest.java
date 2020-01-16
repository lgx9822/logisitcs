package cn.zj.logistics.test;


import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.zj.logistics.pojo.User;
import cn.zj.logistics.pojo.UserExample;
import cn.zj.logistics.pojo.UserExample.Criteria;
import cn.zj.logistics.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class UserTest {

    @Autowired
    private UserService userService;

    @Test
    public void testSelectByPrimaryKey(){
        User user = userService.selectByPrimaryKey(1L);
        System.out.println(user);
    }
    
    @Test
    public void testSelectByExample(){
    	String keywork = "哥";
    	
    	int pageNum = 1;
		int pageSize = 10;
		//mybatis的分页插件的使用,开启分页
    	PageHelper.startPage(pageNum, pageSize);
    	
    	UserExample example = new UserExample();
    	Criteria criteria = example.createCriteria();
    	
		criteria.andUsernameLike("%"+keywork +"%");
		Criteria criteria2 = example.createCriteria();
		criteria2.andRealnameLike("%"+keywork+"%");
		example.or(criteria2);
		
		
		List<User> users = userService.selectByExample(example);
		
		/*
		 * 创建分页对象来接收分页后的数据
		 * 
		 */
		PageInfo<User> pageInfo = new PageInfo<User>();
		System.out.println(pageInfo);
		
    }
    public void testDeleteByPrimaryKey(){}

    public void testInsert(){}

   

    public void testUpdateByPrimaryKeySelective(){}
}
