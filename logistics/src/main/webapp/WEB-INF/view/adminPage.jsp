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
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="Bookmark" href="/favicon.ico">
<link rel="Shortcut Icon" href="/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css"
	href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css"
	href="lib/bootstrap-3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="lib/bootstrap-table/bootstrap-table.min.css" />



<title>管理员列表</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		管理员管理 <span class="c-gray en">&gt;</span> 管理员列表
	</nav>
	<div class="page-container">
		<div id="boolbar">
			<span class="l"><a href="javascript:;" onclick="admin_delCheck()" id="del"
				class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>
					批量删除</a> <a href="javascript:;" onclick="admin_add()"
				class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>
					添加管理员</a></span>
		</div>

		<table id="adminTable"
			class="table table-border table-bordered table-bg">
		</table>

	</div>
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript" src="lib/jquery-1.11.3/jquery.min.js"></script>
	<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
	<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript"
		src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
	<script type="text/javascript"
		src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript"
		src="lib/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="lib/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript"
		src="lib/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>

	<script type="text/javascript">
		$(function() {
			$('#adminTable').bootstrapTable({
				url : 'admin/list.do',
				responseHandler : function(res) {
					/*/后台的返回数据跟前端插件所需要的数据名字不同，需改成相同名字
					res.list结果集
					res.total:总记录数
					 */
					var data = {
						rows : res.list,
						total : res.total
					};
					return data;
				},
				pagination : true,
                search : true,
				toolbar : "#boolbar",//顶部的工具条
				//条件搜索的时候ajax请求给后台数据的数据类型（条件搜索post提交必须设置）
				contentType : 'application/x-www-form-urlencoded',
				pageNumber : 1,//默认是第一页
				pageSize : 10,//默认是10条记录
				pageList : [ 10, 25, 50, 100 ],//每页显示多少条数据
				sidePagination: "server",//是否是服务器分页，每次请求都是对应的10条数据，下一页发送ajax请求
				paginationHAlign : "right",//分页显示在右边
				//showToggle:true,//显示详情跟视图切换
				//cardView:false,//是否显示详情
				//showColumns:true,//是否是显示所有列
				showRefresh : true,//是否是显示刷新
				columns : [ {//显示多选框
					checkbox : true
				}, {
					field : 'userId',
					title : '编号'
				}, {
					field : 'username',
					title : '用户名'
				}, {
					field : 'realname',
					title : '真实姓名'
				}, {
					field : 'status',
					title : '状态'
				}, {
					field : 'createDate',
					title : '创建日期'
				}, {
					field : 'rolename',
					title : '职位'
				}, {
					field : 'userId',
					title : '操作',
					align : 'center',
					formatter : operationformatter
				//格式化函数
				} ],
				queryParams : function(params) {
					return {
						pageNum : params.offset / params.limit + 1,
						pageSize : params.limit,
						keyword : params.search
					}
				}
			})
		});

		//查看当前的记录,如何删除的是最后一条数据，就调用此函数
		//function admin_previous(){
		function admin_adds(){
			var options = $("#adminTable").bootstrapTable('getOptions');
			var data = $("#adminTable").bootstrapTable('getData');
			
			console.log(options);
			console.log(options.pageNumber);
			console.log(options.pageSize);
			console.log(options.searchText);
			console.log(data);
			var pageNum = options.pageNumber-1;
			var pageSize = options.pageSize;
			var keyword = options.searchText;
			$.ajax({
			    url:"admin/list.do",
			    data:{pageNum:pageNum,pageSize:pageSize,keyword:keyword},
			    dataType:"json",
			    success:function(data){
	                console.log(data);
	             }
			});
			options.pageNumber = options.pageNumber-1;
			/* $.get("admin/list.do",{pageNum:pageNum,pageSize:pageSize,keyword:keyword},function(data){
				console.log("data:"+data);
			 },dataType:"json"); */
		}
		
		
		
		//格式化 ：参数必须是(属性值，当前行的值，索引位置)
		function operationformatter(value, row, index) {
			//console.log(value,row,index);
			var html = "<span onclick='admin_delete("
					+ value
					+ ");'style='color:red;cursor:pointer;' class='glyphicon glyphicon-trash'></span>&nbsp;&nbsp;";
			html += "<span onclick='admin_edit("
					+ value
					+ ");'style='color:gray;cursor:pointer;' class='glyphicon glyphicon-pencil'></span>";
			return html;
		}
		//删除数据
		function admin_delete(userId) {
			var getData = $("#adminTable").bootstrapTable('getData');
			layer.confirm('你确定要删除此数据吗？', function() {
				$.get("admin/delete.do?userId=" + userId, function(data) {
					layer.msg(data.msg, {
						time : 1500,
						icon : data.code,
						shade:0.2
					});
					if (data.code == 1) {
						if(getData.length == 1){
							$("#adminTable").bootstrapTable('prevPage');
						}
						refreshTable();
						}
				})
			});
		}
		//刷新当前页
		function refreshTable() {
			$("#adminTable").bootstrapTable("refresh");
		}
		
		//修改数据
		function admin_edit(userId){
			//调用h-ui.admin.js中的一个方法，也是异步请求，对layer的open方法进行增强
			layer_show("编辑管理员","admin/adminEdit.do?userId="+userId);
		}
		//编辑或新增一条数据
		function admin_add() {
			//在这里面输入任何合法的js语句
			layer.open({
				type : 2 //Page层类型
				,
				area : [ '800px', '500px' ],
				title : '新增管理员',
				shade : 0.6 //遮罩透明度
				,
				maxmin : true //允许全屏最小化
				,
				anim : 4 //0-6的动画形式，-1不开启
				,
				content : 'admin/adminEdit.do'
			});
		}
		//管理员批量删除
		function admin_delCheck(){
				var selections = $("#adminTable").bootstrapTable('getSelections');
	            var userIdsArr = [];
	            for(var i = 0; i < selections.length; i++){
	                var user =  selections[i];
	                userIdsArr.push(user.userId);
	            }
	            var userIds = userIdsArr.join(",");
	            //console.log("userIds:"+userIds);
	            if("" != userIds){
	            	layer.confirm("你确定要删除这些数据吗？",function(){
	            		//发送ajax同步请求
		                $.ajax({
		                    url:'admin/deleteChecked.do',
		                    type:'post',
		                    async:false,
		                    data:{userIds:userIds},
		                    dataType:'json',
		                    success:function(data){
		                        layer.msg(data.msg,{time:1500,icon:data.code,shade:0.2},function(){
		                            var getData = $("#adminTable").bootstrapTable('getData');
		                            if(data.code == 1){
		                            	//console.log(getData);
		                            	//console.log("getData");
		                            	//console.log(getData.length);
		                            	//console.log("getData");
		                            	//console.log(userIdsArr.length);
		                            	
		                            	if(getData.length == userIdsArr.length){
		                                    $("#adminTable").bootstrapTable('prevPage');
		                                }
		                                refreshTable();
		                            }
		                        });
		                    }
		                });
	            	});
	           }else{
	                layer.msg("请选择一个再删除",{time:1500,icon:0,shade:0.2});
	          }
		}
	</script>
</body>
</html>