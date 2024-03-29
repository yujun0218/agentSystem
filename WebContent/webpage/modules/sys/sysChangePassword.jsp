<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">	
		<link href="${ctxStatic}/agentSystem/css/default.css" rel="stylesheet" type="text/css" />
		<!--必要样式-->
    	<link href="${ctxStatic}/agentSystem/css/styles.css" rel="stylesheet" type="text/css" />
    	<link href="${ctxStatic}/agentSystem/css/demo.css" rel="stylesheet" type="text/css" />
    	<link href="${ctxStatic}/agentSystem/css/loaders.css" rel="stylesheet" type="text/css" />
    	<link href="${ctxStatic}/agentSystem/css/iconfont.css" rel="stylesheet" type="text/css"/>					
	</head>	
	<style>
	.error{
	    /* font-size: 14px; */
    	color: red;
    	padding-left: 65px;
	}
	.layui-layer-dialog .layui-layer-content{
		color:black;
		}
	input:-webkit-autofill, input:-webkit-autofill:hover, input:-webkit-autofill:focus,
			input:-webkit-autofill:active {
			-webkit-transition-delay: 99999s;
			-webkit-transition: color 99999s ease-out, background-color 99999s
				ease-out;
		}
	.loginBottom {
    opacity: 0.5;   
    transition-duration: .5s;
    width: 840px;
    height: 1px;
    position: absolute;
    left: 0;
    right: 0;
    margin: auto;
    bottom: 0;
    padding: 100px 40px 40px 40px;   
}
	</style>
	<body>
	<div class='login' style="padding-bottom: 60px;padding-top:80px;">
		<div class='login_title'>
			<span>代理商后台登录</span>
		</div>
		<form id="loginChange" action="">		
		<div class='login_fields'>		
			<div class='login_fields__user'>
				<div class='icon'>					
					<img alt="" src='${ctxStatic}/agentSystem/img/user_icon_copy.png'>
				</div>
				
				<input  name="loginName" value="${login_name}" id="changeUserId" autocomplete="off"  placeholder='用户名' maxlength="15" type="text" style="margin-left: 65px;padding-left: 0px;"/>				
				
			</div>
			<div class='login_fields__password'>
				<div class='icon'>
					<img alt="" src='${ctxStatic}/agentSystem/img/lock_icon_copy.png'>
				</div>
				<input name="oldPassword" id="oldPassword" autocomplete="off" placeholder='请输入原密码' maxlength="20" type='password' style="margin-left: 65px;padding-left: 0px;">				
			</div>
			<div class='login_fields__password'>
				<div class='icon'>
					<img alt="" src='${ctxStatic}/agentSystem/img/lock_icon_copy.png'>
				</div>
				<input name="changeNewPassword" id="changeNewPassword" autocomplete="off" placeholder='请输入新密码' maxlength="20" type='password' style="margin-left: 65px;padding-left: 0px;">				
			</div>
			<div class='login_fields__password'>
				<div class='icon'>
					<img alt="" src='${ctxStatic}/agentSystem/img/lock_icon_copy.png'>
				</div>
				<input name="changeConfirmNewPassword" id="changeConfirmNewPassword" autocomplete="off" placeholder='请再次确认密码' maxlength="20" type='password' style="margin-left: 65px;padding-left: 0px;">				
			</div>
			<div class="center">		
				<div id="messageBox" class="alert alert-success" style="font-size: 10px;padding-left: 40px;"><span></span></div>	
			</div>
			<div class= 'change_pwd'>
			<a href="${ctx}/backLogin" style="font-size:14px;">登录</a>
			</div>		 	
			<div class='login_fields__submit'>
				<input type='button' value='确认修改' onclick="savePassword();">
			</div>
			
		</div>
		</form>
	</div>
	<div class='loginBottom'>Copyright © 2011-2030 www.vicmob.com. All Rights Reserved 无锡微炫客信息技术有限公司版权所有<a href="http://www.miitbeian.gov.cn" style="color:#fbfbfb" target="_blank"> 苏ICP备15062425号</a> </div>
</body>
		<script src="${ctxStatic}/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery-validation/1.14.0/jquery.validate.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery-validation/1.14.0/localization/messages_zh.min.js" type="text/javascript"></script>		
		<!-- 引入layer插件 -->
		<script src="${ctxStatic}/layer/layer-v3.1.0/layer.js"></script>
		<script type="text/javascript" src="${ctxStatic}/agentSystem/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src='${ctxStatic}/agentSystem/js/stopExecutionOnTimeout.js?t=1'></script>    	
    	<script src="${ctxStatic}/agentSystem/js/Particleground.js" type="text/javascript"></script>
    	<script src="${ctxStatic}/agentSystem/js/Treatment.js" type="text/javascript"></script>
    	<script src="${ctxStatic}/agentSystem/js/jquery.mockjax.js" type="text/javascript"></script>
    	<!-- jeeplus -->
		<link href="${ctxStatic}/common/jeeplus.css" type="text/css" rel="stylesheet" />
		<script src="${ctxStatic}/common/jeeplus.js" type="text/javascript"></script>
    	<script>
    	$(document).ready(function(){
    		$("body").addClass("picBacChange");
    		$("body").show();
	    	//粒子背景特效
		    $('body').particleground({
		        dotColor: '#E8DFE8',
		        lineColor: '#133b88'
		    });  
    	});   
	   //用户名、旧密码、新密码的校验（表单的验证）
	    $(document).ready(function(){
	    	//注册表单验证
	    	$("#loginChange").validate({
	    		rules:{
	    			loginName:{
	    				required:true,//必填
	    				maxlength:15,//最多15个字符
	    				remote: "${ctx}/sys/user/validateLoginNameExist",
	    				isRightUserNameForm:true,
	    			},
	    			oldPassword:{
	    				required:true,
	    				minlength:6, 
	    				maxlength:20,
	    				isRightPasswordForm:true,
	    			},
	    			changeNewPassword:{
	    				required:true,
	    				minlength:6, 
	    				maxlength:20,
	    				isRightPasswordForm:true,
	    			},
	    			changeConfirmNewPassword:{
	    				required:true,
	    				minlength:6,
	    				equalTo:'#changeNewPassword',
	    			},
	    		},
	    		//错误信息提示
	    		messages:{
	    			loginName:{
	    				required:"用户名不能为空",	    				
	    				maxlength:"用户名至多为15个字符",
	    				remote: "请输入正确的用户名",
	    			},
	    			oldPassword:{
	    				required:"密码不能为空",
	    				minlength:"密码至少为6个字符",
	    				maxlength:"密码至多为20个字符",
	    			},
	    			changeNewPassword:{
	    				required:"密码不能为空",
	    				minlength:"密码至少为6个字符",
	    				maxlength:"密码至多为20个字符",
	    			},
	    			changeConfirmNewPassword:{
	    				required: "请再次输入密码",
	    				minlength: "确认密码不能少于6个字符",
	    				equalTo: "两次输入密码不一致",//与另一个元素相同
	    			},  		
	    		},
				
	            errorPlacement: function(error, element) {
	                error.insertAfter(element.parent());
	            } 
	    	});
	        jQuery.validator.addMethod("isRightPasswordForm", function(value, element) {
	            var rightPasswordForm = /^[a-zA-Z0-9]{6,20}$/;
	            return (rightPasswordForm.test(value));
	        }, "密码只能由字母数字组成"); 
	        jQuery.validator.addMethod("isRightUserNameForm", function(value, element) {
	            var rightUserNameForm = /^[a-zA-Z0-9]{0,20}$/;
	            return (rightUserNameForm.test(value));
	        }, "用户名只能由字母数字组成，且只能以字母开头"); 
	    	
	    });
	   //确认修改密码
	   function savePassword(){
		   var isValid = $("#loginChange").valid();
		   if(isValid){	
			  
			   
			   var url = "${ctx}/affirmChange";
	            var data = $('#loginChange').serialize();
	            $.post(url,data,function(result){	            	
	                if(result == "OK"){
	                	$("#messageBox").html('<span></span>');
	                	layer.msg("密码修改成功！",{icon:1,time:1000},function(){
	                		window.location.href="${ctx}/login";						    			
						});
	                	
	                }else if(result == "validateFailure"){		                	                	
	                    $("#messageBox").html('<span style="color:red;font-size:14px;">原始密码错误，请核对后重新输入</span>');  
	                    $("#oldPassword").val("");
	                    $("#changeNewPassword").val("");
	                    $("#changeConfirmNewPassword").val("");	                    
	                }else if(result == "error"){
	                	$("#messageBox").html('<span style="color:red;font-size:14px;">系统出错，请稍后修改</span>'); 	                    
	                }
	            });
			   
		   }
	   }
	   $("#changeUserId").bind("click",function(){
		   $("#messageBox").html('<span></span>');
	   })
	   $("#oldPassword").bind("click",function(){
		   $("#messageBox").html('<span></span>');
	   })
	   $("#changeNewPassword").bind("click",function(){
		   $("#messageBox").html('<span></span>');
	   })
	   $("#changeConfirmNewPassword").bind("click",function(){
		   $("#messageBox").html('<span></span>');
	   })
    	</script>
    	
</html>
