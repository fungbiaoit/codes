package com.demo.vo;

import com.demo.model.User;

/**
 * 自定义查询条件类
 */
public class UserVo extends User {

    //注意：page和limit属性要与Layui的数据表格参数一致

    private Integer page;//当前页码
    private Integer limit;//每页显示数量

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }
}
