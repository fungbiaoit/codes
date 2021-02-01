<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
<body>
<!-- 标题 -->
<h1 align="center">帐单列表</h1>

<%--搜索--%>
<div style="width: 80%;margin-left: 100px;text-align: center">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>搜索条件</legend>
    </fieldset>
    <form class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户类型</label>
                <div class="layui-input-inline">
                    <select name="typeId" class="layui-input">
                        <option value="">请选择用户类型</option>
                    </select>
                </div>
                <button class="layui-btn" lay-submit lay-filter="doSearch">搜索</button>
            </div>
        </div>
    </form>
</div>

<%--数据表格开始--%>
<div>
    <%--表格--%>
    <table id="userTable" lay-filter="userTable" class="layui-table"></table>

    <%--头部工具栏--%>
    <script type="text/html" id="userToolbar">
        <div class="layui-btn-containern">
            <button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon icon layui-icon-add-circle">添加用户</i></button>
            <button class="layui-btn layui-btn-sm btn layui-btn-danger" lay-event="batchDelete"><i class="layui-icon icon layui-icon-delete">批量删除</i></button>
        </div>
    </script>

    <%--行工具栏--%>
    <script type="text/html" id="userRowbar">
        <div class="layui-btn-containern">
            <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
            <button class="layui-btn layui-btn-sm btn layui-btn-danger" lay-event="delete">删除</button>
        </div>
    </script>
</div>
<%--数据表格结束--%>

<!-- 添加和修改用户的弹出层开始 -->
<div id="addOrUpdateBillDiv" style="display: none;margin: 10px">
    <form id="dataFrm" method="post" class="layui-form  layui-form-pane" lay-filter="dataFrm">
        <!-- 隐藏域，保存当前用户的ID -->
        <input type="hidden" name="id">
        <div class="layui-form-item">
            <label class="layui-form-label">用户类型</label>
            <div class="layui-input-block" id="billTypeDiv">
                <select name="typeId" class="layui-input" lay-verify="required" lay-reqText="请选择账单类型">
                    <option value="">请选择用户类型</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="username" placeholder="请输入用户名" lay-verify="required" lay-reqText="请输入用户名"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="男" title="男" checked autocomplete="off" class="layui-input">
                <input type="radio" name="sex" value="女" title="女" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">年龄</label>
            <div class="layui-input-inline">
                <input type="number" name="age" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">城市</label>
            <div class="layui-input-block">
                <input type="text" placeholder="请输入城市" name="city" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">生日</label>
            <div class="layui-input-block">
                <input type="text" id="birthday" name="birthday" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit">提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </form>
</div>
<!-- 添加和修改账单的弹出层结束-->


<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
layui.use(['form','jquery','table','layer','laydate'],function () {
    var form = layui.form;
    var $ = layui.jquery;
    var table = layui.table;
    var layer = layui.layer;
    var laydate = layui.laydate;
    var slider = layui.slider;

    //渲染日历组件
    laydate.render({elem: "#birthday"})

    //渲染表格组件
    var tableIns = table.render({
        elem: "#userTable",
        url: "user/list.do",
        page: true  //开启分页
        ,toolbar: "#userToolbar"
        ,cols: [[ //表头
        {type:'checkbox', fixed: 'left'},
        {field: 'id', title: 'ID', width:80, sort: true,align:"center"}
        ,{field: 'username', title: '用户名', width:80,align:"center"}
        ,{field: 'sex', title: '性别', width:80, sort: true,align:"center"}
        ,{field: 'age', title: '年龄', width:80,sort: true,align:"center"}
        ,{field: 'city', title: '城市', width:80,edit:true,align:"center"}
        ,{field: 'birthday', title: '生日',edit:true,align:"center"}
        ,{field: 'typeName', title: '角色',edit:true,align:"center"}
        ,{title: '操作', toolbar: "#userRowbar",align:"center"}
    ]]
    });

    //发送ajax请求查询账单类型
    $.get("user/rolelist.do",function (result) {
        var html = "";
        //循环遍历集合
        for (let i=0; i<result.length; i++) {
            html += "<option value='" + result[i].id + "'>" + result[i].name + "</option>";
        }
        //将网页代码追加到下拉列表中
        $("[name='typeId']").append(html);
        //更新渲染select下拉框
        form.render("select");
    })

    //监听搜索按钮提交事件
    form.on("submit(doSearch)",function (data) {
        tableIns.reload({
            where: data.field, //查询条件
            page: {
                curr: 1
            }
        });
        return false;   //禁止刷新
    })

    //监听表格头部工具栏事件
    table.on("toolbar(userTable)",function (obj) {
        switch (obj.event) {
            //添加
            case 'add':
                openAddWindow();
                break;
            //批量删除
            case 'batchDelete':
                batchDelete();
                break;
        }
    });

    //监听表格行工具栏事件
    table.on("tool(userTable)",function (obj) {
        switch (obj.event) {
            //编辑
            case 'edit':
                openUpdateWindow(obj.data); //将数据回显过去
                break;
            case 'delete':
                deleteById(obj.data);
                break;
        }
    })

    var url;    //提交地址
    var mainIndex;  //窗口索引

    /**
     * 打开添加窗口
     */
    function openAddWindow() {
        mainIndex = layer.open({
            type: 1,    //弹出层的类型
            title: "添加用户",
            area: ['800px','600px'],
            content: $("#addOrUpdateBillDiv"),
            success: function () {
                //用的同一个弹窗需要改变url去指定controller
                url = "user/addUser.do";
                //下次输入和使用完修改后再次打开弹窗时清空内容
                $("#dataFrm")[0].reset();   //javascript中的方法
            }
        });

    }

    /**
     * 打开编辑窗口
     */
    function openUpdateWindow(data) {
        mainIndex = layer.open({
            type: 1,    //弹出层的类型
            title: "修改用户",
            area: ['800px','600px'],
            content: $("#addOrUpdateBillDiv"),
            success: function () {
                //表单数据回显
                form.val("dataFrm",data)
                //修改请求路径
                url = "user/updateUser.do";
            }
        });

    }

    //监听表单提交事件
    form.on("submit(doSubmit)",function (data) {
        $.post(url,data.field,function (result) {
            if(result.success){
                layer.msg(result.msg,{icon:1})
                //关闭窗口
                layer.close(mainIndex);
                //刷新表格
                tableIns.reload();
            }else{
                layer.msg(result.msg,{icon:2})
            }
        })
        return false;
    })

    /**
     * 删除用户
     * @param data 当前行数据
     */
    function deleteById(data) {
        //提示用户确认是否删除
        layer.confirm("确定要删除[<font color='red'>"+data.username+"</font>]吗？",{icon:3,title:"提示"},function (index) {
            //发送ajax请求
            $.post("user/deleteUser.do",{"id":data.id},function (result) {
                if(result.success){
                    layer.msg(result.msg,{icon:1});
                    //刷新数据表格
                    tableIns.reload();
                }else{
                    layer.msg(result.msg,{icon:2});
                }
            })
            //关闭提示框
            layer.close(index);
        });
    }

    /**
     * 批量删除
     */
    function batchDelete() {
        var checkStatus = table.checkStatus("userTable");   //table提供的针对复选框的函数
        //判断是否有选中行
        if(checkStatus.data.length>0){
            //定义数据，保存选中的ID
            var idArr = [];
            //循环遍历选中行（目的是获取选中行的ID值）
            for(let i=0;i<checkStatus.data.length;i++){
                idArr.push(checkStatus.data[i].id);
            }
            //提示用户是否删除
            layer.confirm("确定要删除这<font color='red'>"+checkStatus.data.length+"</font>条数据吗？",{icon:3,title:"提示"},function (index){
                //发送ajax请求
                $.post("user/batchDelete.do",{"ids":idArr},function (result) {
                    if(result.success){
                        layer.msg(result.msg,{icon:1});
                        //刷新数据表格
                        tableIns.reload();
                    }else{
                        layer.msg(result.msg,{icon:2});
                    }
                })
                //关闭提示框
                layer.close(index);
            });
        }else{
            layer.msg("请选择要删除的数据！");
        }
    }
})
</script>
</body>
</html>
