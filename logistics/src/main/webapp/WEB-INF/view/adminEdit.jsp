<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<!-- 设置页面的 基本路径，页面所有资源引入和页面的跳转全部基于 base路径 -->
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
<title>添加管理员 - 管理员管理 - H-ui.admin v3.1</title>
<meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<article class="page-container">
    ${roles[0].rolename }
    <form class="form form-horizontal" id="adminEdit">
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>管理员：</label>
        <div class="formControls col-xs-8 col-sm-9">
            <input type="text" class="input-text" value="" placeholder="请输入用户名" id="username" name="username">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>真实姓名：</label>
        <div class="formControls col-xs-8 col-sm-9">
            <input type="text" class="input-text" value="" placeholder="请输入真实姓名" id="realname" name="realname">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>初始密码：</label>
        <div class="formControls col-xs-8 col-sm-9">
            <input type="password" class="input-text" autocomplete="off" value="" placeholder="密码" id="password" name="password">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认密码：</label>
        <div class="formControls col-xs-8 col-sm-9">
            <input type="password" class="input-text" autocomplete="off"  placeholder="确认新密码" id="password2" name="password2">
        </div>
    </div>
    <!-- <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>性别：</label>
        <div class="formControls col-xs-8 col-sm-9 skin-minimal">
            <div class="radio-box">
                <input name="sex" type="radio" id="sex-1" checked>
                <label for="sex-1">男</label>
            </div>
            <div class="radio-box">
                <input type="radio" id="sex-2" name="sex">
                <label for="sex-2">女</label>
            </div>
        </div>
    </div> -->
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3">角色：</label>
        <div class="formControls col-xs-8 col-sm-9"> <span class="select-box" style="width:150px;">
            <select class="select" name="adminRole" size="1">
                <option value="0">--请选择--</option>
                <c:forEach items="${roles }" var="role">
                    <option value="${role.roleId }">${role.rolename }</option>
                </c:forEach>
            </select>
            </span> </div>
    </div>
    <div class="row cl">
        <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
            <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
        </div>
    </div>
    </form>
</article>

<!--_footer 作为公共模版分离出去--> 
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/validate-methods.js"></script> 
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script> 
<script type="text/javascript">
$().ready(function(){
	$("#adminEdit").validate({
		//定义校验规则
		rules:{
			username:{
				required:true,
				rangelength:[3,10]
			},
			realname:{
				required:true,
				isChinese:true,
				rangelength:[2,10]
			},
			password:{
				required:true,
				rangelength:[3,10]
			},
			password2:{
				equalTo:"#password"
			}
		},
		//校验失败的信息提示
		messages:{
			 username:{
	                required:"用户名不能为空",
	                rangelength:"用户名的长度3~10"
	            },
	            realname:{
	                required:"真实姓名不能为空",
	                isChinese:"真实姓名必须是汉字",
	                rangelength:"真实姓名2~10个汉字"
	            },
	            password:{
	                required:"密码不能为空",
	                rangelength:"密码长度3~10"
	            },
	            password2:"两次密码不一致"
		},
		//校验成功的回调
		submitHandler:function(form){
			
		}
	});
});

</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>