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
<!-- 引入z-tree的css -->
<link rel="stylesheet" type="text/css" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" />

<title>角色管理</title>
<meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<article class="page-container">
    <form class="form form-horizontal" id="roleEdit" action="${role==null ? 'role/insert.do':'role/update.do' }" method="post">
    <!-- 隐藏域，用于携带id -->
    <input type="hidden" name="roleId" value="${role.roleId }"/>
    <!-- 隐藏域，用于携带z-tree的选中值 -->
    <input type="hidden" name="permissionIds" id="permissionIds"/>
    
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>角色名：</label>
        <div class="formControls col-xs-8 col-sm-9">
            <input type="text" class="input-text"  value="${role.rolename }" placeholder="请输入角色名" id="rolename" name="rolename">
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>备注：</label>
        <div class="formControls col-xs-8 col-sm-9">
            <textarea name="remark"  class="textarea"  placeholder="角色说明"  >${role.remark}</textarea>
        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-xs-4 col-sm-3">权限：</label>
        <div class="formControls col-xs-8 col-sm-9">
            <ul id="permissionTree" class="ztree"></ul>
        </div>
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
<!-- 引入z-tree的js -->
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
$().ready(function(){
	$("#roleEdit").validate({
		//定义校验规则
		rules:{
			rolename:{
				required:true
			},
			remark:{
				required:true,
				maxlength:30
			}
		},
		//校验失败的信息提示
		messages:{
			 rolename:{
	                required:"角色名不能为空",
	            },
	            remark:{
	                required:"角色说明不能为空",
	                maxlength:"角色说明不能超过30个字"
	            }
		},
		//校验成功的回调
		submitHandler:function(form){
			//在请求时，获取选中的
			getCheckOptions();
			//转jq对象
			$(form).ajaxSubmit(function(data){
				layer.msg(data.msg,{time:1500,icon:data.code,shade:0.2},function(){
					if(data.code == 1){
						//刷新页面
						parent.refreshTable();
						//关闭所有layer弹框
						parent.layer.closeAll();
					}
				});
				
			});
		}
	});
	//========================z-tree的使用===============================
	var setting = {
	           //开启多选框
	           check:{
	               enable:true
	           },
	           //json数据的显示
	           data:{
	               simpleData:{
	                   enable:true,
	                   idKey:"permissionId",
	                   pIdKey:"parentId"
	               }
	           },
	           
	           async:{
	               enable:true,//开启async请求
	               url:"permission/getAllPerrmission.do",
	               dataFilter: filter,//在渲染前对数据进行过滤
	           }
	   };

	   $(document).ready(function(){
	       $.fn.zTree.init($("#permissionTree"), setting);
	   });
	   
	   //改造json数据
	   function filter(treeId, parentNode, childNodes){
	       for(var i = 0; i < childNodes.length; i++){
	           childNodes[i].open = true;
	       }
	       return childNodes;
	   }
	   //获取选中的多选框
	   function getCheckOptions(){
	       //获取到tree对象
	       var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
	       //获取选中的函数
	       var nodes = treeObj.getCheckedNodes(true);
	       console.log(nodes);
	       var permissionIdsArr = [];
	       for(var i = 0; i < nodes.length; i++){
	    	   permissionIdsArr.push(nodes[i].permissionId);
	       }
	       $("#permissionIds").val(permissionIdsArr.toString());
	   }
	//========================z-tree的使用===============================
});

</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>