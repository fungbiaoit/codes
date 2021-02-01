package com.demo.service;


import com.demo.model.User;
import com.demo.model.UserType;
import com.demo.vo.UserVo;

import java.util.List;

public interface UserService {

    /**
     * 用户登录验证
     * @param username
     * @param password
     * @return
     */
    User login(String username,String password);

    /**
     * 查询所有用户，当传入id等参数不为空时，以id等参数为条件查找
     * @param userVo
     * @return
     */
    List<User> findAll(UserVo userVo);

    /**
     * 查询所有用户类型
     */
    List<UserType> findAllUserType();

    /**
     * 添加用户
     * @param user
     */
    int addUser(User user);

    /**
     * 修改用户
     * @param user
     * @return
     */
    int updateUser(User user);

    /**
     * 删除用户
     * @param id
     * @return
     */
    int deleteUserById(Integer id);
}
