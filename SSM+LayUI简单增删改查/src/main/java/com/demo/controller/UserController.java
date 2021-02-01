package com.demo.controller;

import com.demo.model.User;
import com.demo.model.UserType;
import com.demo.service.UserService;
import com.demo.utils.DataGridViewResult;
import com.demo.vo.UserVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;


    /**
     * 登录
     * @param username
     * @param password
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/login.do")
    public Map<String,Object> login(String username, String password, HttpSession session){
        //创建map集合保存信息
        Map<String,Object> map = new HashMap<>();
        //调用登录的方法
        User user = userService.login(username,password);
        //判断对象是否为空
        if(user!=null){
            //保存会话
            session.setAttribute("user",user);
            map.put("success",true);
        }else{
            map.put("success",false);
        }
        return map;
    }

    /**
     * 查询所有用户信息
     * @param userVo
     * @return
     */
    @ResponseBody
    @RequestMapping("/list.do")
    public DataGridViewResult list(UserVo userVo){
        //设置分页信息（当前页面，每页显示数量）
        PageHelper.startPage(userVo.getPage(),userVo.getLimit());
        List<User> userList = userService.findAll(userVo);
        //创建分页对象
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        //返回数据
        return new DataGridViewResult(pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 查询用户角色信息
     * @return
     */
    @ResponseBody
    @RequestMapping("rolelist.do")
    public List<UserType> rolelist(){
        return userService.findAllUserType();
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping("addUser.do")
    public Map<String,Object> addUser(User user){
        Map<String,Object> map = new HashMap<>();
        if(userService.addUser(user)>0){
            map.put("success",true);
            map.put("msg","添加成功");
        }else{
            map.put("success",false);
            map.put("msg","添加失败");
        }
        return map;
    }

    /**
     * 修改用户
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping("updateUser.do")
    public Map<String,Object> updateUser(User user){
        Map<String,Object> map = new HashMap<>();
        if(userService.updateUser(user)>0){
            map.put("success",true);
            map.put("msg","修改成功");
        }else{
            map.put("success",false);
            map.put("msg","修改失败");
        }
        return map;
    }

    /**
     * 删除用户
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("deleteUser.do")
    public Map<String,Object> deleteUserById(Integer id){
        Map<String,Object> map = new HashMap<>();
        if(userService.deleteUserById(id)>0){
            map.put("success",true);
            map.put("msg","删除成功");
        }else{
            map.put("success",false);
            map.put("msg","删除失败");
        }
        return map;
    }

    /**
     * 批量删除用户
     * @param ids 用@RequestParam是因为后台不能直接获取ajax传来的数组
     * @return
     */
    @ResponseBody
    @RequestMapping("batchDelete.do")
    public Map<String,Object> batchDelete(@RequestParam("ids[]")Integer[] ids){
        Map<String,Object> map = new HashMap<>();
        int count=0;
        for(int i = 0;i<ids.length;i++){
            count = userService.deleteUserById(ids[i]);
            if(count>0){
                map.put("success",true);
                map.put("msg","删除成功");
            }
        }
        //判断受影响行数是否为0
        if(count<=0){
            map.put("success",false);
            map.put("msg","删除失败");
        }
        return map;
    }

}
