package com.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * WEB-INF目录下面的jsp页面不能被直接访问，
 * 此类用于WEB—INF下的页面跳转
 */
@Controller
public class PageController {

    @RequestMapping("/index.do")
    public String toIndex(){
        return "index";
    }

}
