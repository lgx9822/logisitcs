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
<button type="button" onclick="getCheckOptions()">获取选中的</button>
<ul id="permissionTree" class="ztree"></ul>
<script type="text/javascript">
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
       console.log(permissionIdsArr.toString());
   }
   
</script>
</body>


</html>