<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 终端列表 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style>
		.error{
			color:red
		}
		.iconfont{
			font-size:25px
		}
</style>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">
					</div>
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentSystem/terminal/wasTerminalUser/list" method="post" style="width: 100%" id="searchForm"> 
							<input name="parentId" type="hidden" value="1" /> 
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
							<input id="companyNameA" name="companyName" type="hidden"    value="${fn:escapeXml(wasTerminalUser.companyName)}" />
							<input id="beginDateA" name="beginDate" type="hidden" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd  HH:mm:ss"/>" />
							<input id="endDateA" name="endDate" type="hidden"  value="<fmt:formatDate value="${wasTerminalUser.endDate}" pattern="yyyy-MM-dd  HH:mm:ss"/>" />
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>
							<input id="companyNameB" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入公司名称"  value="${fn:escapeXml(wasTerminalUser.companyName)}" style="float: right;">
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top: 8px;">录入时间范围：&nbsp;&nbsp;</div>
									<input id="beginDateB" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd "/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl leftAngle rightAngle">至</span>
									<input id="endDateB" value="<fmt:formatDate value="${wasTerminalUser.endDate}" pattern="yyyy-MM-dd "/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间"  style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<!-- <th class="tableControl"><input type="checkbox" class="check" id="ischange" data-checkbox="icheckbox_square-blue"></th> -->
								<th class="tableControl">公司名称</th>
								<th class="tableControl">负责人</th>
								<th class="tableControl">联系方式</th>
								<th class="tableControl">地区</th>
								<th class="tableControl">详细地址</th>
								<th class="tableControl">账号</th>
								<th class="tableControl">录入时间</th>
								<th class="tableControl">状态</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="wasTerminalUser">
								<tr>
									<%-- <td class="tableControl"><input type="checkbox" class="check" id="${wasTerminalUser.terminalUserId}" data-checkbox="icheckbox_square-blue"></td> --%>
									<td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${fn:escapeXml(wasTerminalUser.companyName)}</td>
									<td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${fn:escapeXml(wasTerminalUser.name)}</td>
									<td class="tableControl">${wasTerminalUser.phone}</td>
									<td class="tableControl">${wasTerminalUser.province}-${wasTerminalUser.city}-${wasTerminalUser.county}</td>
									<td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${fn:escapeXml(wasTerminalUser.address)}</td>
									<td class="tableControl">${fn:escapeXml(wasTerminalUser.loginName)}</td>
									<td class="tableControl"><fmt:formatDate value="${wasTerminalUser.createDate}" pattern="yyyy-MM-dd"/></td>
									<td class="tableControl">${(wasTerminalUser.state eq 0)?"正常":"冻结"}</td>
									<td class="tableControl">
										<c:if test="${wasTerminalUser.state eq 0}">
											<shiro:hasPermission name="terminal:wasTerminalUser:freeze">
												<button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="冻结" class="btn btn-info btn-circle btn-xs" onclick="freeze( ${wasTerminalUser.terminalUserId})">
													<i style="font-size:15px;color:white;" class="iconfont  icon-dongjie"></i>
												</button> 
											</shiro:hasPermission>
										</c:if>
										<c:if test="${wasTerminalUser.state eq 1}">
											<shiro:hasPermission name="terminal:wasTerminalUser:thaw">
												<button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="解冻" class="btn btn-info btn-circle btn-xs" onclick="thaw(${wasTerminalUser.terminalUserId})">
													<i style="font-size:15px;color:white;" class="iconfont icon-jiechudongjie"></i>
												</button> 
											</shiro:hasPermission>
										</c:if> 
											<shiro:hasPermission name="terminal:wasTerminalUser:edit">
												<button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="编辑" class="btn btn-info btn-circle btn-xs" onclick="edit('${wasTerminalUser.terminalUserId}')">
													<i class="fa fa-edit"></i>
												</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="terminal:wasTerminalUser:delete">
												<button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="删除" class="btn btn-danger btn-circle btn-xs " onclick="deleteTerminalUser(${wasTerminalUser.terminalUserId})">
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
	<div class="modal fade" id="freezeModal" data-backdrop="static" style="margin-top: 170px;">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->
				<div class="modal-header" style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">					
					<label class="modal-title" id="" style="font-size: 14px">冻结</label>
					<button type="button" class="close" data-dismiss="modal"  aria-hidden="true" >×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="freezeInput">
						<div class="form-group row">
                                  <label for="message-text " class="control-label col-3"  ><span style="color: red">*&nbsp;</span>冻结理由：</label>
                                  <input id="freezeId" type="text" name="terminalUserId" class="" value=""  hidden/>
                                  <div class="col-8">
                               		   <textarea class="form-control" name="reason" minlength="1" maxlength="100" style="height:60px"></textarea>
                                  </div>
                        </div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="saveFreezeReason()">保存</button>
				</div>
			</div>
		</div>
	</div>
<!-- 模态框 -->
	<div class="modal fade" id="thawModal" data-backdrop="static" style="margin-top: 170px;">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->
				<div class="modal-header" style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					
					<label class="modal-title" id="" style="font-size: 14px">解冻</label>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="thawInput">
						<div class="form-group row">
                                  <label for="message-text" class="control-label  col-3"   id="sa"><span style="color: red">*&nbsp;</span> 解冻理由：</label>
                                  <input id="thawId" type="text" name="terminalUserId" value=""  hidden/>
                                  <div class="col-8">
                                  		<textarea class="form-control" name="reason" minlength="1" maxlength="100"  style="height:60px"></textarea>
                                  </div>
                        </div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="saveThawReason()">保存</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
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
				$("#pageNo").val(0);
				$("#companyNameA").val($("#companyNameB").val());
				$("#beginDateA").val($("#beginDateB").val());
				$("#endDateA").val($("#endDateB").val() +" 23:59:59");
				$("#searchForm").submit();
			}
			$('#companyNameB').bind('keypress', function(event) {
				if (event.keyCode == "13") {
					$("#pageNo").val(0);
					$("#companyNameA").val($("#companyNameB").val());
					$("#beginDateA").val($("#beginDateB").val());
					$("#endDateA").val($("#endDateB").val() +" 23:59:59");
					search();
				}
			});
			//冻结模态框
			function freeze(id){
				$("#freezeId").val(id);
				$("#freezeModal>textarea").val("");
				$("#freezeModal ").modal("show");
			}
			//解冻模态框
			function thaw(id){
				$("#thawId").val(id);
				$("#thawModal>textarea").val("");
				$("#thawModal").modal("show"); 
			}
			//保存冻结理由
			function saveFreezeReason(){
				var locked = false;
				if(!locked && $("#freezeInput").valid()){
					locked = true;
	        		layer.confirm('确认冻结当前账户？', {closeBtn : 0,icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
	        			var index = layer.load(1, {shade: [0.1,'#fff']});
	        			$.ajax({
	        			    url : "${ctx}/agentSystem/terminal/wasTerminalUser/freeze",
	        			    type : "post",
	        			    dataType : "text",
	        			    async:false,
	        			    data : $("#freezeInput").serialize(),
	        			    success : function(data) {
	        			        layer.close(index);
	        			        locked = false;
	        			        if("success" == data){
	        			            layer.msg("冻结成功",{icon:1,time:2000},function(){
	        			                $("#freezeModal").modal('hide');
	        			                $("#searchForm").submit();
	        			            });
	        			        }else{
	        			            layer.msg("冻结失败",{icon:2,time:1000},function(){
	        			                return;
	        			            });
	        			        }
	        			    },
	        			    error : function(result){
	        			        layer.close(index);
	        			        locked = false;
	        			        layer.msg("冻结失败",{icon:2,time:1000},function(){
	        			           return;
	        			        });
	        			    }
	        			});
	        		})
				}
			}
			//保存解冻理由
			function saveThawReason(){
				var locked = false;
				if(!locked && $("#thawInput").valid()){
					locked = true;
	        		layer.confirm('确认解冻当前账户？', {closeBtn : 0,icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
	        			var index = layer.load(1, {shade: [0.1,'#fff']});
	        			$.ajax({
	        			    url : "${ctx}/agentSystem/terminal/wasTerminalUser/thaw",
	        			    type : "post",
	        			    dataType : "text",
	        			    async:false,
	        			    data : $("#thawInput").serialize(),
	        			    success : function(data) {
		        			    layer.close(index);
		        			    locked = false;
		        			    if("success" == data){
			        			        layer.msg("解冻成功",{icon:1,time:2000},function(){
			        			            $("#thawModal").modal('hide');
			        			            $("#searchForm").submit();
			        			        });
		        			    }else{
			        			        layer.msg("解冻失败",{icon:2,time:1000},function(){
			        			            return;
			        			        });
		        			    }
	        			},
	        			error : function(result){
		        			    layer.close(index);
		        			    locked = false;
		        			    layer.msg("解冻失败",{icon:2,time:1000},function(){
		        			        return;
		        			    });
	        			}
	        			});
						
	        		})
				}
			}
			//逻辑删除终端用户		
			function deleteTerminalUser(id){
				var locked = false;
				if(!locked){
					locked = true;				
	        		layer.confirm('确认删除当前账户？', {closeBtn : 0 ,icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
	        			var index = layer.load(1, {shade: [0.1,'#fff']});			
	        			$.ajax({
	        			    url : "${ctx}/agentSystem/terminal/wasTerminalUser/delete",
	        			    type : "post",
	        			    dataType : "text",
	        			    async:false,
	        			    data : {"terminalUserId":id},
	        			    success : function(data) {
			        			    layer.close(index);
			        			    locked = false;
			        			    if("success" == data){
				        			        layer.msg("删除成功",{icon:1,time:2000},function(){
				        			            if(parseInt('${page.list.size()}')==1){
				        			                $("#pageNo").val($("#pageNo").val()-1)
				        			            }
				        			            $("#searchForm").submit();
				        			        })
			        			    }else{
				        			        layer.msg("删除失败",{icon:2,time:1000},function(){
				        			            return;
				        			        });
			        			    }
	        			},
	        			error : function(result){
			        			    layer.close(index);
			        			    locked = false;
			        			    layer.msg("删除失败",{icon:2,time:1000},function(){
			        			        return;
			        			    });
	        			}
	        			});
					})
				}
			}
			//冻结表单验证
		    $(document).ready(function(){
		    	$("#freezeInput").validate({
		    		rules:{
		    			reason:{required:true,maxlength:100,}
		    		},
		    		messages:{
		    			reason:{required:"请输入冻结理由",maxlength:"冻结理由最多100个字符",
		    			}
		    		},
		            errorPlacement: function(error, element) {
		                	error.insertAfter(element);  	
		            }
		    	})
	    	//解冻表单验证
	    	$("#thawInput").validate({
	    		rules:{
	    			reason:{required:true,maxlength:100,
	    			}
	    		},
	    		messages:{
	    			reason:{required:"请输入解冻理由",maxlength:"解冻理由最多100个字符",
	    			}
	    		},
	            errorPlacement: function(error, element) {
	                	error.insertAfter(element);       	
	            }
	    	})
	    	//删除模态框中错误提示信息
	    	$(".modal .close").click(function(){
	    		$("label.error").remove();
	    		$("textarea").val("");
	    	})
	    })
	    //进入编辑终端页面
	    function edit(terminalUserId){
				window.location.href="${ctx}/agentSystem/terminal/wasTerminalUser/form?terminalUserId=" + terminalUserId
			}
	</script>
</body>
</html>