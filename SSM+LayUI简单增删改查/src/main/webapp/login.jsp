<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
</head>
<body class="login-bg">

<div class="login layui-anim layui-anim-up">
    <div class="message">登录管理</div>
    <div id="darkbannerwrap"></div>
    <form class="layui-form">
        <input name="username" placeholder="用户名" type="text" lay-verify="required" class="layui-input">
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码" type="password" class="layui-input">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" type="button">
        <hr class="hr20">
    </form>
</div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    layui.use(['form','jquery','layer'],function () {
        var form = layui.form;
        var $ = layui.jquery;
        var layer = layui.layer;

        //监听表单提交事件
        form.on("submit(login)",function (data) {
            $.post("user/login.do",data.field,function (result) {
                //判断是否成功
                if(result.success){
                    location.href="index.do";
                }else{
                    layer.msg("用户名或密码错误，登录失败");
                }
            },"json");
            //禁止页面跳转
            return false;
        })
    })
</script>
</body>
</html>
