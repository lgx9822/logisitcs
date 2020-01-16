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
		   },
		   data:{
			   simpleData:{
				   enable:true
			   }
		   }
		   
   };
   var zNodes =[
       { id:1, pId:0, name:"pNode 1", open:true},
       { id:11, pId:1, name:"pNode 11"},
       { id:111, pId:11, name:"leaf node 111"},
       { id:112, pId:11, name:"leaf node 112"},
       { id:113, pId:11, name:"leaf node 113"},
       { id:114, pId:11, name:"leaf node 114"},
       { id:12, pId:1, name:"pNode 12"},
       { id:121, pId:12, name:"leaf node 121"},
       { id:122, pId:12, name:"leaf node 122"},
       { id:123, pId:12, name:"leaf node 123"},
       { id:124, pId:12, name:"leaf node 124"},
       { id:13, pId:1, name:"pNode 13 - no child", isParent:true},
       { id:2, pId:0, name:"pNode 2"},
       { id:21, pId:2, name:"pNode 21", open:true},
       { id:211, pId:21, name:"leaf node 211"},
       { id:212, pId:21, name:"leaf node 212"},
       { id:213, pId:21, name:"leaf node 213"},
       { id:214, pId:21, name:"leaf node 214"},
       { id:22, pId:2, name:"pNode 22"},
       { id:221, pId:22, name:"leaf node 221"},
       { id:222, pId:22, name:"leaf node 222"},
       { id:223, pId:22, name:"leaf node 223"},
       { id:224, pId:22, name:"leaf node 224"},
       { id:23, pId:2, name:"pNode 23"},
       { id:231, pId:23, name:"leaf node 231"},
       { id:232, pId:23, name:"leaf node 232"},
       { id:233, pId:23, name:"leaf node 233"},
       { id:234, pId:23, name:"leaf node 234"},
       { id:3, pId:0, name:"pNode 3 - no child", isParent:true}
   ];

   $(document).ready(function(){
       $.fn.zTree.init($("#permissionTree"), setting, zNodes);
   });
</script>
</body>


</html>