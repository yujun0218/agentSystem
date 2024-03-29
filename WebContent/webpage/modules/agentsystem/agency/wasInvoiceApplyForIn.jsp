
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 开票的已申请列表 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<style>
.space{
white-space: pre-wrap;
}
</style>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">						
					</div>
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentSystem/wasInvoiceApplyForIn/list" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>

							<input autocomplete="off" type="text" class="form-control height-control col-3" id="keywordOne" placeholder="请输入发票内容关键字" autocomplete="off" value="${body}" style="float: right;"/> 
								<input type="hidden" id="keyword" value="${fn:escapeXml(body)}"  name="body" />
								<input id="timeStartOne" value="<fmt:formatDate value="${wasInvoiceApplication.beginDate}" pattern="yyyy-MM-dd  HH:mm:ss"/>" type="hidden" name="beginDate"/>
								<input id="timeEndOne" value="<fmt:formatDate value="${wasInvoiceApplication.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="hidden" name="endDate"/>
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top: 8px;">申请时间范围：&nbsp;&nbsp;</div>
									<input id="timeStart" value="<fmt:formatDate value="${wasInvoiceApplication.beginDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" autocomplete="off" style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
									<input id="timeEnd" value="<fmt:formatDate value="${wasInvoiceApplication.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间" autocomplete="off" style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable"
						class="display nowrap table table-hover table-striped table-bordered">
						<thead>
							<tr>

								<th class="tableControl">发票申请号</th>
								<th class="tableControl">发票内容</th>
								<th class="tableControl">开票金额/元</th>
								<th class="tableControl">申请时间</th>
								<th class="tableControl">状态</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="log">
								<tr>
									
										<td class="tableControl space">${log.invoiceNo}</td>
										<td class="tableControl space">${fn:escapeXml(log.body)}</td>
										<td class="tableControl">${log.money}</td>
										<td class="tableControl"><fmt:formatDate
												value="${log.applyDate}" type="both" /></td>
										<c:if test="${log.sendState == 0}"> 
										<td class="tableControl">申请中</td>
										</c:if>
										<c:if test="${log.sendState == 1}"> 
										<td class="tableControl">已发货</td>
										</c:if>
										<c:if test="${log.sendState == 3}"> 
										<td class="tableControl">已驳回</td>
										</c:if>
										<td class="tableControl">
										<c:if test="${log.sendState != 1}"> 
										<shiro:hasPermission name="agentsystem:wasInvoiceApplication:lookInform">
											<button type="button" data-toggle="tooltip"
												data-original-title="查看"
												class="btn btn-info btn-circle btn-xs"
												onclick="lookInform('${log.invoiceNo}');">
												<i class="fa fa-search-plus"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:expressInform">
											<button type="button" disabled="disabled"
												data-toggle="tooltip" data-original-title="物流"
												class="btn btn-info btn-circle btn-xs"
												onclick="express('${fn:escapeXml(log.expressCoding)}','${fn:escapeXml(log.expressNumber)}',this)">
												<i class="iconf icon-tubiao"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:confirmState">
											<button type="button" disabled="disabled"
												data-toggle="tooltip" data-original-title="确认"
												class="btn btn-info btn-circle btn-xs"
												onclick="confirm('${log.invoiceId}')">
												<i class="iconf icon-queren-"></i>
											</button>	
											</shiro:hasPermission>
										</c:if>
										<c:if test="${log.sendState ==1}">
										<shiro:hasPermission name="agentsystem:wasInvoiceApplication:lookInform">
											<button type="button" data-toggle="tooltip"
												data-original-title="查看"
												class="btn btn-info btn-circle btn-xs"
												onclick="lookInform('${log.invoiceNo}');">
												<i class="fa fa-search-plus"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:expressInform">
											<button type="button" 
												data-toggle="tooltip" data-original-title="物流"
												class="btn btn-info btn-circle btn-xs"
												onclick="express('${fn:escapeXml(log.expressCoding)}','${fn:escapeXml(log.expressNumber)}',this)">
												<i class="iconf icon-tubiao"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:confirmState">
											<button type="button" 
												data-toggle="tooltip" data-original-title="确认"
												class="btn btn-info btn-circle btn-xs"
												onclick="confirm('${log.invoiceId}')">
												<i class="iconf icon-queren-"></i>
											</button>
											</shiro:hasPermission>	
										</c:if>								
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
	<form  id="lookJump" hidden="hidden" action="${ctx}/agentSystem/wasInvoiceApplication/lookInform" method="post">
		<input name="sendFlag" value="3" />
		<input id="invoiceNoL" name="invoiceNo" value="" />
	</form>
		<!-- 物流的模态框 -->
	<div class="modal fade" id="logisticsModal" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span style="font-size: 14px">物流</span><button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body logisticsClass" style="max-height:600px; overflow:scroll;">
					<div class="content">
						<div class="wrapper">
							<div class="main">
								<div class="year">
									<div class="list">
										<ul id="logisticsInfo">
											
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">	
	//点击回车搜索
	$('#keywordOne').bind('keypress', function(event) {
		if (event.keyCode == "13") {
			search();
		}
	});	
	
	//物流的显示
	function express(expressCoding,expressNumber,obj){	
		var index = layer.load(1, {shade: [0.1,'#fff']});
		$.ajax({
			url:'${ctx}/agentSystem/wasInvoiceApplication/expressInform',
			type:'POST',
			data:{
				expressCoding : expressCoding,
				expressNumber : expressNumber,
			},
			dataType: 'json',
			 success:function(result){
				 layer.close(index);
				 if(result.Success){
					 var insertHtml = "";
				    	var len = result.Traces.length;
				    	if(len > 0){
				    		for (var i=len-1; i>=0; i--) {
					    		insertHtml = insertHtml + '<li class="cls">'
									+ '<p class="version">&nbsp;</p>'
									+ '<div class="more">'
									+ '<p class="pcon">'+ result.Traces[i].AcceptStation +'</p>'
									+ '<p class="pcon">'+ result.Traces[i].AcceptTime +'</p>'
						 			+ '</div></li>'
					    	}
				    	}else{				    		
					    		insertHtml = '<li class="cls">'
								+ '<p class="version">&nbsp;</p>'
								+ '<div class="more">'
								+ '<p class="pcon">'+ result.Reason +'</p>'
								+ '<p class="pcon"></p>'
					 			+ '</div></li>'					    	
				    	}	
				 }else{
					 insertHtml = '<li class="cls">'
							+ '<p class="version">&nbsp;</p>'
							+ '<div class="more">'
							+ '<p class="pcon">'+ result.Reason +'</p>'
							+ '<p class="pcon"></p>'
				 			+ '</div></li>' 
				 }			    		
			    	$("#logisticsInfo").html(insertHtml);
			    	$("#logisticsInfo").children("li:first-child").addClass("highlight");
			    	$("#logisticsModal").modal("show");
			    	$(obj).blur();
			    },
			    error:function(xhr,textStatus){
			    	layer.close(index);
			    	layer.msg('查看失败！', { icon : 2 });
			    },				
		});			
		
	}
	//确认收货
	function confirm(invoiceId) {
		
		layer.confirm("是否已收到发票？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']}, 
				function(){
					var index = layer.load(1, {shade: [0.1,'#fff']});
					$.ajax({
					    url:'${ctx}/agentSystem/wasInvoiceApplication/confirmState',
					    type:'POST',
					    data:{
					    	invoiceId:invoiceId,
					    },
					    dataType:'json',
					    success:function(result){
					    	layer.close(index);
					    	var countSum = ${page.count};
					    	var countSize = ${page.pageSize};
					    	if(result > 0){
					    		var last = '${isLast}';//$("#isLast").val();
				    			if(last == '1'){
				    				var number = Number(countSum)%Number(countSize);
				    				if(number == 1){
				    					$("#pageNo").val($("#pageNo").val()-1);
				    					$("#pageSize").val($("#pageSize").val());
				    					layer.msg("操作成功！",{icon:1,time:1000},function(){
				    						$("#searchForm").submit();
										});					    				
				    				}else{
				    					layer.msg("操作成功！",{icon:1,time:1000},function(){
				    						$("#searchForm").submit();
										});	
				    				}			    				
				    			}else{
				    				layer.msg("操作成功！",{icon:1,time:1000},function(){
			    						$("#searchForm").submit();
									});	
				    			}	
					    		/* layer.msg("确认成功！",{icon:1,time:1000},function(){
					    			$("#searchForm").submit();
								});	 */
					    	}
					    },
					    error:function(xhr,textStatus){
					    	layer.close(index);
					    	layer.msg('确认失败！', { icon : 2 });
					    },
					})
				});
	}
     //查看的页面跳转	
		function lookInform(invoiceNo){		
			$("#invoiceNoL").val(invoiceNo)
			$("#lookJump").submit();
		}		
		
		
		//日期范围选择
		jQuery('#date-range').datepicker({
			toggleActive : true,
			autoclose: true,
			format : "yyyy-mm-dd"
		});
		//分页方法
		function page(n,s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			$("span.page-size").text(s);
		}
		//查询方法
		function search(){//查询，页码清零
			$("#keyword").val($("#keywordOne").val());
			$("#timeStartOne").val($("#timeStart").val());			
			$("#timeEndOne").val($("#timeEnd").val()+' 23:59:59');
			$("#pageNo").val(0);
			$("#searchForm").submit();
		}
		//checkbox监听
		$('#ischange').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
			$('.check').iCheck('check');
		});
		$('#ischange').on('ifUnchecked', function(event){ //ifUnchecked 事件应该在插件初始化之前绑定 
			$('.check').iCheck('uncheck');
		});		
	</script>

</body>
</html>