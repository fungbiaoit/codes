package com.demo.service.impl;

import com.demo.dao.UserDao;
import com.demo.model.User;
import com.demo.model.UserType;
import com.demo.service.UserService;
import com.demo.utils.PasswordUtil;
import com.demo.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;


    /**
     * 验证用户登录
     * @param username
     * @param password
     * @return
     */
    @Override
    public User login(String username, String password) {
        //调用根据用户名查询用户信息的方法
        User user = userDao.findUserByUsername(username);
        if(user!=null){
            //密码加密
            String newPassword = PasswordUtil.md5(password, username, 5);
            //比较密码是否一致
            if(user.getPassword().equals(newPassword))
                return user;
        }
        return null;
    }

    @Override
    public List<User> findAll(UserVo userVo) {
        return userDao.findAll(userVo);
    }

    @Override
    public List<UserType> findAllUserType() {
        return userDao.findAllUserType();
    }

    @Override
    public int addUser(User user) {
        return userDao.addUser(user);
    }

    @Override
    public int updateUser(User user) {
        return userDao.updateUser(user);
    }

    @Override
    public int deleteUserById(Integer id) {
        return userDao.deleteUserById(id);
    }

}
