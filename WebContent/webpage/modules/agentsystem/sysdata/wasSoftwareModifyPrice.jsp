
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 版本修改价 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style type="text/css">
#price-error,#inlineFormCustomSelect-error{
margin-left: 141px;
color:red;
}
</style>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<!-- Nav tabs -->
			
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">
						 <shiro:hasPermission name="sysdata:wasSoftwareModifyPrice:add">
						 <button style="margin-bottom:16.35px;" type="button" class="btn btn-info" onclick="addshow(this)">
						<i class="fa fa-plus-circle"></i> 添加
						</button>				
						</shiro:hasPermission>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered">
						<thead>
							<tr>
								<th class="tableControl">软件分类</th>
								<th class="tableControl">价格/元</th>
								<th class="tableControl">添加时间</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						
						<tbody id="tbody">
							<c:forEach items="${modifyPriceList}" var="modifyPrice">
								<tr>
									<td class="tableControl">${modifyPrice.classify eq true ? "小程序" : "公众号"}</td>
									<td class="tableControl">${modifyPrice.price}</td>
									<td class="tableControl"><fmt:formatDate value="${modifyPrice.createDate}" type="both" /></td>
									<td class="tableControl">
										<shiro:hasPermission name="sysdata:wasSoftwareModifyPrice:edit">
											<button type="button" data-toggle="tooltip" onclick="editShow(${modifyPrice.modifypriceId},this)" data-original-title="编辑" class="btn btn-info btn-circle btn-xs">
												<i class="fa fa-edit"></i>
											</button>
										</shiro:hasPermission> 
										<shiro:hasPermission name="sysdata:wasSoftwareModifyPrice:del">
											<button type="button" data-toggle="tooltip" onclick="deleteModifyPrice(${modifyPrice.modifypriceId})" data-original-title="删除" class="btn btn-danger btn-circle btn-xs ">
												<i class="fa fa-times"></i>
											</button>
										</shiro:hasPermission>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 分页代码 -->
					<c:if test="${page.count gt 10}">
						<table:page page="${page}"></table:page>
					</c:if>
				</div>
				
			</div>
		</div>
	</div>

	<!-- 模态框 -->
	<div class="modal fade" id="modal" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content" style="margin-top:225px" >
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
						<h6 id="title" class="modal-title">添加</h6>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="inputForm">
					<input type="hidden" id="modifypriceId" name="modifypriceId" />
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><span style="color:red">*&nbsp;</span>软件分类：</label>
							<div class="col-8">
								<select name="classify" style="cursor:pointer;color:#495057 !important" class="custom-select col-12 height-control"
									id="inlineFormCustomSelect">
									<option selected value="">请选择</option>
									<option value="0">公众号</option>
									<option value="1">小程序</option>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><span style="color:red">*&nbsp;</span>修改价格：</label>
							<div class="col-8 controls input-group">
								<input autocomplete="off" maxlength="9" type="text" id="price" name="price" class="form-control height-control rightAngle" required data-validation-required-message="这是必填项"> 
								<span style="border-left:0px;" class="input-group-addon height-control leftAngle" id="basic-addon1">元</span>
							</div>
						</div>
						<input type="text" style="display:none"> 
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="save()">保存</button>						
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
		//添加弹框显示
		function addshow(ob) {
			$(ob).blur();
			$("#title").html("添加");
			$("#modifypriceId").val("");
			var ac=$("#tbody tr").length;
			if(ac>=2){
				layer.msg("只能添加两条数据哦！",{icon : 7,time:1000});
				return;
			} 
			//下拉选可选择
			document.getElementById('inlineFormCustomSelect').disabled=false;
			$("#inlineFormCustomSelect").val("");
			$("#price").val("");
			$("#inputForm").data("validator").resetForm();
			$("#modal").modal("show");
		}
		//编辑展示
		function editShow(id,ob){
			$(ob).blur();
			$("#title").html("编辑");
			var index = layer.load(1, {shade: [0.1,'#fff']});
			$.ajax({
				url :"${ctx}/agentSystem/wasSoftwareModifyPrice/findEntiy",
				dataType : "json",
				type : "post",
				data : {"modifypriceId":id},
				success : function(data){
					layer.close(index);
					var classify=data.classify==true ? "1": "0";
					$("#price").val(data.price);
					$("#modifypriceId").val(data.modifypriceId);
					$("#inlineFormCustomSelect").val(classify);
					document.getElementById('inlineFormCustomSelect').disabled="disabled";
					$("#modal").modal("show");
					$("#inputForm").data("validator").resetForm();
				},
			});
		}
		//日期范围选择
		jQuery('#date-range').datepicker({
			toggleActive : true,
			autoclose: true,
			format : "yyyy-mm-dd"
		});
		//保存
		function save(){
			var classify=$("#inlineFormCustomSelect").val();
			var price=$("#price").val();
			var modifypriceId=$("#modifypriceId").val();
			var menuId=$("#btnId",parent.document).val();
			var isValid = $("#inputForm").valid();
			var lock=true;
			 if(isValid){
			 layer.confirm('是否确认保存？', { closeBtn : 0,icon : 3 ,
				 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
					 if(lock){
						 lock=false;
					 $("#modal").modal("hide");
					 var index = layer.load(1, {shade: [0.1,'#fff']});
					 $.ajax({
							url : "${ctx}/agentSystem/wasSoftwareModifyPrice/save",
							dataType : "json",
							type : "post",
							data : {"menuId":menuId,"classify":classify,"price":price,"modifypriceId":modifypriceId},
							success : function(result) {
								if (result >0) {
									layer.close(index);
									layer.msg("保存成功",{icon:1,time:1000},function(){
										location.href="${ctx}/agentSystem/wasSoftwareModifyPrice/list";
									});
								}
							},error : function(){
								layer.close(index);
								layer.msg("保存失败",{icon:2,time:1000},function(){
									location.href="${ctx}/agentSystem/wasSoftwareModifyPrice/list";
								});
							}
						});  
					 }
				 });
			} 
		}
		//删除
		function deleteModifyPrice(id){
			var menuId=$("#btnId",parent.document).val();
			layer.confirm("确认要彻底删除数据吗?",{closeBtn:0,skin : "layui-layer-molv",btn : [ "确认","取消" ],icon:3},
					function() {
				var index = layer.load(1, {shade: [0.1,'#fff']});
				$.ajax({
					url :"${ctx}/agentSystem/wasSoftwareModifyPrice/delete",
					dataType : "json",
					Type : "post",
					data : {"modifypriceId":id,"menuId":menuId},
					success : function(result){
						if(result>0){
							layer.close(index);
							layer.msg("删除成功",{icon:1,time:1000},function(){
								location.href="${ctx}/agentSystem/wasSoftwareModifyPrice/list";
							});
						}
					},
					error : function(){
						layer.close(index);
						layer.msg("删除失败",{icon:2,time:1000},function(){
							location.href="${ctx}/agentSystem/wasSoftwareModifyPrice/list";
						});
					}
				});
			});
			
		}
		
		//checkbox监听
		$('#ischange').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
			$('.check').iCheck('check');
		});
		$('#ischange').on('ifUnchecked', function(event){ //ifUnchecked 事件应该在插件初始化之前绑定 
			$('.check').iCheck('uncheck');
		});
		
		
		$.validator.addMethod("minNumber",function(value, element) {
			   var returnVal = true;
	           inputZ=value;
	           var ArrMen= inputZ.split(".");    //截取字符串
	           if(ArrMen.length==2){
	               if(ArrMen[1].length>2){    //判断小数点后面的字符串长度
	                   returnVal = false;
	                   return false;
	               }
	           }
	           return returnVal;
		},"最多支持两位小数");
		jQuery.validator.addMethod("positiveNumber", function(value, element) { 
	         var returnVal = true;
	         if(value<=0){
	        	 return false;
	         }
	         return returnVal;
	    }, "请输入正数");
		$("#inputForm").validate({
			rules : {
				price : {
					required : true,
					number : true,
					positiveNumber : true,
					max : 999999.99,
					minNumber : true
				},
				classify : {
					required : true,
					min : 0,
					 remote:{
						   url:"${ctx}/agentSystem/wasSoftwareModifyPrice/validate",
						   type:"post",
						  data :{
							 classify:function(){
					          return $("#inlineFormCustomSelect").val();
					          }
			          		} 
						}
				},
				},messages : {
					price : {
						required : "请输入修改价格",
						number :"请输入正数",
						max : "修改价格不可大于999999.99"
					},
					classify : {
						required : "请选择软件分类",
						min : "请选择软件分类",
						remote: "所选软件分类已经存在,不可重复!", 
					},
				},errorPlacement : function(error, element) {
					error.insertAfter(element.parent());
				}
			
		});
		
		
		
		
	</script>

</body>
</html>