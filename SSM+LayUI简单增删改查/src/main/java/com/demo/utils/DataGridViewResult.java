package com.demo.utils;

/**
 * 此类封装LayUI数据表格中返回的数据格式
 */
public class DataGridViewResult {

    private Integer code = 0;
    private String msg = "";
    private Long count;
    private Object data;

    /**
     * 封装数据表格
     * @param count
     * @param data
     */
    public DataGridViewResult(Long count, Object data) {
        this.count = count;
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
