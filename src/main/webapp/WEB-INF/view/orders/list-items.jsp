<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	pageContext.setAttribute("PATH", request.getContextPath());
%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>匠心衣橱后台</title>
<!-- Styles -->
<link
	href="${PATH}/static/assets/fontAwesome/css/fontawesome-all.min.css"
	rel="stylesheet">
<link href="${PATH}/static/assets/css/lib/themify-icons.css"
	rel="stylesheet">
<link href="${PATH}/static/assets/css/lib/mmc-chat.css" rel="stylesheet" />
<link href="${PATH}/static/assets/css/lib/sidebar.css" rel="stylesheet">
<link href="${PATH}/static/assets/css/lib/bootstrap.min.css"
	rel="stylesheet">
<link href="${PATH}/static/assets/css/lib/nixon.css" rel="stylesheet">
<link href="${PATH}/static/assets/lib/lobipanel/css/lobipanel.min.css"
	rel="stylesheet">
<link href="${PATH}/static/assets/css/style.css" rel="stylesheet">
<link href="${PATH}/static/layui/css/layui.css" rel="stylesheet">
<script src="${PATH}/static/vue/vue.min.js"></script>
<script src="${PATH}/static/vue/vue-resource.min.js"></script>
</head>
<style>
.range-label{
	margin-right: 30px
}

input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

input[type="number"] {
	-moz-appearance: textfield;
}
</style>
<body>
	<!-- 左侧导航 -->
	<%@ include file="/WEB-INF/view/common/leftNav.jsp"%>
	<!-- /# sidebar -->
	<%@ include file="/WEB-INF/view/common/header.jsp"%>

	<!-- END chat Sidebar-->
	<div class="content-wrap">
		<div class="main">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-8 p-0">
						<div class="page-header">
							<div class="page-title">
								<h1>导航</h1>
							</div>
						</div>
					</div>
					<!-- /# column -->
					<div class="col-lg-4 p-0">
						<div class="page-header">
							<div class="page-title">
								<ol class="breadcrumb text-right">
									<li><a href="#">导航</a></li>
									<li class="active">所有条目</li>
								</ol>
							</div>
						</div>
					</div>
					<!-- /# column -->
				</div>
				<!-- /# row -->
				<div class="main-content">
					<div class="row">
						<div class="card">
							<form class="layui-form" id="kwItemsForm">
								<div class="col-lg-6">
									<div class="layui-form-item">
										<label class="layui-form-label range-label">关键字</label>
										<div class="layui-input-block">
											<input name="kwText" placeholder="请输入" class="layui-input"></input>
										</div>
									</div>
									
									<div class="layui-form-item">
										<label class="layui-form-label range-label">积分</label>
										<div class="layui-input-inline">
											<input type="number" placeholder="请输入" name="min_integral"
												autocomplete="off" class="layui-input">
										</div>
										<div class="layui-form-mid">-</div>
										<div class="layui-input-inline">
											<input type="number" placeholder="请输入" name="max_integral"
												autocomplete="off" class="layui-input">
										</div>
									</div>
								</div>
								<div class="col-lg-6">
									<div class="layui-form-item">
										<label class="layui-form-label range-label">日期</label>
										<div class="layui-input-inline">
											<input type="text" id="start_date" placeholder="请选择" name="start_date"
												autocomplete="off" class="layui-input">
										</div>
										<div class="layui-form-mid">-</div>
										<div class="layui-input-inline">
											<input type="text" id="end_date" placeholder="请选择" name="end_date"
												autocomplete="off" class="layui-input">
										</div>
									</div>
									<div class="layui-form-item">
									    <label class="layui-form-label">状态</label>
									    <div class="layui-input-block">
									      <select name="itemState" lay-verify="required">
									        <option value="0">---请选择---</option>
									        <option value="展示">展示</option>
									        <option value="隐藏">隐藏</option>
									      </select>
									    </div>
									  </div>
									<div class="layui-form-item">
									    <label class="layui-form-label">分类</label>
									    <div class="layui-input-block">
									      <select name="itemSort" lay-verify="required">
									        <option value="0">---请选择---</option>
									        <option value="单次">单次</option>
									        <option value="包月">包月</option>
									      </select>
									    </div>
									  </div>
									
								</div>
								
								
								<div class="layui-form-item">
									<div class="layui-input-block">
										<button class="layui-btn" type="button" id="kwFormBtn">筛选</button>
										<button type="reset" class="layui-btn layui-btn-primary">重置</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="card">
								<div class="card-header">
									<h2>条目列表</h2><br>
									<button class="layui-btn layui-btn-danger" type="button" id="delByIds">选中删除</button>
								</div>
								<div class="card-body">
									<table id="itemsListTb"
										class="table table-responsive table-hover"
										lay-filter="itemsListTbFilter">

									</table>
								</div>
							</div>
						</div>
					</div>


					<!-- /# row -->
					<!-- /# row -->
				</div>
			</div>
			<!-- /# container-fluid -->
		</div>
		<!-- /# main -->
	</div>
	<!-- /# content wrap -->
	<!-- 查看模态框 -->
	<div style="display: none;" id="editItemsModal">
			<fieldset class="layui-elem-field layui-field-title">
			  <legend>条目</legend>
			  <div class="layui-field-box">
			  		<form class="layui-form">
			  		    <input type="hidden" id="itemIdModal" name="itemId">
						<div class="col-lg-6">
							<div class="layui-form-item">
								<label class="layui-form-label">名称</label>
								<div class="layui-input-block">
									<input type="text" name="itemName" id="itemNameModal" required
										lay-verify="required" placeholder="请输入"
										autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">价格</label>
								<div class="layui-input-block">
									<input type="number" name="itemPrice" id="itemPriceModal" required
										lay-verify="required" placeholder="请输入(积分制)"
										autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
							    <label class="layui-form-label">状态</label>
							    <div class="layui-input-block">
							      <select name="itemState" id="itemStateModal" lay-verify="required">
							        <option value="0">---请选择---</option>
							        <option value="展示">展示</option>
							        <option value="隐藏">隐藏</option>
							      </select>
							    </div>
							  </div>
							<div class="layui-form-item">
							    <label class="layui-form-label">分类</label>
							    <div class="layui-input-block">
							      <select name="itemSort" id="itemSortModal"  lay-verify="required">
							        <option value="0">---请选择---</option>
							        <option value="单次">单次</option>
							        <option value="包月">包月</option>
							      </select>
							    </div>
							  </div>
							  
						</div>
						<div class="col-lg-6 ">
							<div class="layui-form-item">
								<label class="layui-form-label">描述1</label>
								<div class="layui-input-block">
									<input type="text" name="desc1" id="itemDesc1Modal" required
										lay-verify="required" placeholder="请输入"
										autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">描述2</label>
								<div class="layui-input-block">
									<input type="text" name="desc2" id="itemDesc2Modal"  placeholder="请输入"
										autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">描述3</label>
								<div class="layui-input-block">
									<input type="text" name="desc3" id="itemDesc3Modal" placeholder="请输入"
										autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">描述4</label>
								<div class="layui-input-block">
									<input type="text" name="desc4" id="itemDesc4Modal" placeholder="请输入"
										autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">描述5</label>
								<div class="layui-input-block">
									<input type="text" name="desc5" id="itemDesc5Modal"  placeholder="请输入"
										autocomplete="off" class="layui-input">
								</div>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-input-block">
								<button class="layui-btn" lay-submit lay-filter="*">修改</button>
								<button type="reset" id="resetFormModal"
									class="layui-btn layui-btn-primary">重置</button>
							</div>
						</div>
					</form>
			  
			  </div>
			</fieldset>
	</div>
	

	<script src="${PATH}/static/assets/js/lib/jquery.min.js"></script>
	<!-- jquery vendor -->
	<script src="${PATH}/static/assets/js/lib/jquery.nanoscroller.min.js"></script>
	<!-- nano scroller -->
	<script src="${PATH}/static/assets/js/lib/sidebar.js"></script>
	<!-- sidebar -->
	<script src="${PATH}/static/assets/js/lib/bootstrap.min.js"></script>
	<!-- bootstrap -->
	<script src="${PATH}/static/assets/js/lib/mmc-common.js"></script>
	<script src="${PATH}/static/assets/js/scripts.js"></script>
	<script src="${PATH}/static/layui/layui.all.js"></script>

	<!-- scripit init-->
	<script>
		$(function() {
			renderTb();
		});
		function renderTb() {
			var data = $("#kwItemsForm").serializeArray();
			layui.use(['table','util'], function() {
				var table = layui.table
				,util = layui.util;
				//第一个实例
				table.render({
					elem : '#itemsListTb',
					height : 312,
					url : '${PATH}/orderItem/getItemsList',
					text : {
						none : '未找到条目'
					},
					id:"itemsListTbId",
					skin : 'line' ,
					size : 'lg',
					contentType: "application/json",//必须指定，否则会报415错误
				    dataType : 'json',
					method:"POST",
					page : true //开启分页
					,
					where : {
						kwdata : data
					},
					cols : [ [ //表头
					{
						field : 'itemId',
						title : '#',
						rowspan:2,
						type:"checkbox",
						align : "center"
					}, {
						field : 'itemName',
						title : '名称',
						rowspan:2,
						align : "center"
					},{
						field : 'itemPrice',
						title : '价格',
						rowspan:2,
						sort:true,
						style:"color: orange;",
						align : "center"
					},{
						field : 'itemState',
						title : '状态',
						rowspan:2,
						style:"color: blue;",
						align : "center"
					},{
						field : 'itemSort',
						title : '分类',
						rowspan:2,
						style:"color: red;",
						align : "center"
					},{
						title : '描述',
						colspan:5,
						align : "center"
					},{
						fixed : 'right',
						title : '操作',
						rowspan:2,
						toolbar : '#barDemo',
						align : "center"
					}],[
						{
							field : 'descOne',
							title : '描述1',
							align : "center"
						},{
							field : 'descTwo',
							title : '描述2',
							align : "center"
						},{
							field : 'descThree',
							title : '描述3',
							align : "center"
						},{
							field : 'descFour',
							title : '描述4',
							align : "center"
						},{
							field : 'descFive',
							title : '描述5',
							align : "center"
						}
						
					]],
					parseData : function(res) { //res 即为原始返回的数据
						console.log(res)
						return {
							"code" : res.status, //解析接口状态
							"msg" : res.message, //解析提示文本
							"count" : res.total, //解析数据长度
							"data" : res.data
						//解析数据列表
						};
					}
				});
				table.on('tool(itemsListTbFilter)', function(obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
					var data = obj.data; //获得当前行数据
					var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
					if (layEvent === 'detail') { //查看
						var state = data.itemState
						var id = data.itemId
						if(state=="展示"){
							$.ajax({
								url:"${PATH}/orderItem/changeState/隐藏/"+id,
								method:"get",
								success:function(res){
									if(res.code==100){
										layui.layer.msg(res.extend.msg,{icon:6},function(){
											renderTb();
										});
									}else{
										layui.layer.msg(res.extend.msg,{icon:5});
									}
								},error:function(){
									layui.layer.msg("系统错误！",{icon:5});
								}
							});
						}else{
							$.ajax({
								url:"${PATH}/orderItem/changeState/展示/"+id,
								method:"get",
								success:function(res){
									if(res.code==100){
										layui.layer.msg(res.extend.msg,{icon:6},function(){
											renderTb();
										});
									}else{
										layui.layer.msg(res.extend.msg,{icon:5});
									}
								},error:function(){
									layui.layer.msg("系统错误！",{icon:5});
								}
							});
						}
					} else if (layEvent === 'edit') { //编辑
						$("#resetFormModal").click();
						$("#itemIdModal").val(data.itemId)
						$("#itemNameModal").val(data.itemName)
						$("#itemPriceModal").val(data.itemPrice)
						$("#itemDesc1Modal").val(data.descOne)
						$("#itemDesc2Modal").val(data.descTwo)
						$("#itemDesc3Modal").val(data.descThree)
						$("#itemDesc4Modal").val(data.descFour)
						$("#itemDesc5Modal").val(data.descFive)
						$("#itemSortModal> option").each(function(){
							var va = $(this).val()
							if (va == data.itemSort) {
								$(this).attr("selected", "selected")
							}
							
						});
						$("#itemStateModal> option").each(function(){
							var va = $(this).val()
							if (va == data.itemState) {
								$(this).attr("selected", "selected")
							}
							
						});
						layui.form.render('select');
						var index = layer.open({
							title : '修改条目',
							fix : true,
							resize : false,
							move : false,
							area : [ "800px", "500px" ],
							zIndex : 500,
							shadeClose : true,
							shade : 0.4,
							type : 1,
							anim:1,
							content : $('#editItemsModal')
						});

					} else if (layEvent === 'LAYTABLE_TIPS') {
						layer.alert('Hi，头部工具栏扩展的右侧图标。');
					}
				});
			});
		}
		layui.use('laydate', function(){
			  var laydate = layui.laydate;
			  //执行一个laydate实例
			  laydate.render({
			    elem: '#start_date' //指定元素,
			    ,eventElem: '#start_date'
			    ,trigger: 'click'
			  });
			  laydate.render({
			    elem: '#end_date' //指定元素,
			    ,eventElem: '#end_date'
			    ,trigger: 'click'
			  });
			});
		//筛选
		$("#kwFormBtn").click(function(){
			renderTb();
		});
		//批量删除
		$("#delByIds").click(function(){
			layui.use(['table','layer'], function() {
				var table = layui.table
				,layer = layui.layer;
				layer.confirm('真的删除行么', function(index){
					var checkStatus = table.checkStatus('itemsListTbId');
					var datas = checkStatus.data
					var ids = new Array();
					$(datas).each(function(){
						ids.push($(this)[0].itemId);
					})
					console.log(ids)
					$.ajax({
						url:"${PATH}/orderItem/delItemsByIds",
						method:"POST",
						contentType: "application/json",//必须指定，否则会报415错误
					    dataType : 'json',
						data:JSON.stringify(ids),
						success:function(res){
							console.log(res)
							if(res.code == 100){
								layer.msg(res.extend.msg,{icon:6},function(){
									renderTb();
								});
							}else{
								layer.msg(res.extend.msg,{icon:5},function(){
									renderTb();
								});
							}
						},error:function(){
							layer.msg("系统错误！",{icon:5},function(){
								renderTb();
							});
						}
					});	
				  layer.close(index);
				});
			});
		})
		
		layui.use(['layer', 'form'], function(){
			  var layer = layui.layer
			  ,form = layui.form;
			  form.on('submit(*)', function(data){
				  $.ajax({
					  url:"${PATH}/orderItem/editItem",
					  method:"POST",
					  contentType: "application/json",//必须指定，否则会报415错误
				      dataType : 'json',
				      data : JSON.stringify(data.field),//序列化复杂对象
					  success:function(res){
						  console.log(res)
						  if(res.code == 100 ){
							  layer.msg(res.extend.msg,{icon:6},function(){
								  layer.closeAll()
								  renderTb();
							  })
						  }else{
							  layer.msg(res.extend.msg,{icon:5})
						  }
					  },error:function(){
						  layer.msg("系统错误！",{icon:5},function(){
							  layer.closeAll()
							  renderTb();
						  })
					  }
				  });
				  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
				});
			});
		
		
	</script>
	<script type="text/html" id="barDemo">
<div align="center">
<button type="button" class="btn btn-info btn-xs btn-outline" lay-event="detail">修改状态</button>
<button type="button" class="btn btn-warning btn-xs btn-outline" lay-event="edit">修改</button>
</div>
</script>
</body>

</html>