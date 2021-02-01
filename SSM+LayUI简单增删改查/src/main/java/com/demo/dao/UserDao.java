package com.demo.dao;

import com.demo.model.User;
import com.demo.model.UserType;
import com.demo.vo.UserVo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {

    /**
     * 根据登录名查询用户信息
     * @param username
     * @return
     */
    @Select("select * from user where username=#{username}")
    User findUserByUsername(String username);

    /**
     * 查询所有用户
     * @param userVo
     * @return
     */
    List<User> findAll(UserVo userVo);

    /**
     * 查询所有用户类型
     * @return
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
    @Delete("delete from user where id=#{id}")
    int deleteUserById(Integer id);
}
