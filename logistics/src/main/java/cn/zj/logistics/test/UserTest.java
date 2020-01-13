package cn.zj.logistics.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.zj.logistics.pojo.User;
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

    public void testDeleteByPrimaryKey(){}

    public void testInsert(){}

    public void testSelectByExample(){}

    public void testUpdateByPrimaryKeySelective(){}
}
