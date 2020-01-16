<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 引入z-tree的css -->
<link rel="stylesheet" type="text/css" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" />
<!-- 引入jquery -->
<script type="text/javascript" src="lib/jquery-1.11.3/jquery.min.js"></script>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
</head>
<body>
<ul id="permissionTree" class="ztree"></ul>
<script type="text/javascript">
   var setting = {
		   check:{
			   enable:true
		   }
		   
   };
   var zNodes = [
       {
       name:"管理员管理里",open:true,
       children:[
           {name:"角色管理"},
           {name:"权限管理"},
           {name:"管理员列表"}
        ]
       },{
           name:"物流管理",open:true,
           children:[
               {name:"快递订单"},
               {name:"删除订单"},
               {name:"接收订单"}
           ]
       }
   ];
   $(document).ready(function(){
       $.fn.zTree.init($("#permissionTree"), setting, zNodes);
   });
</script>
</body>


</html>