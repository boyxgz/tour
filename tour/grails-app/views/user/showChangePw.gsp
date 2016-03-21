<html>
<head>
	<title><g:message code="springSecurity.change.password"/></title>
        <meta name="layout" content="main" />
	<style type='text/css' media='screen'>
	#login {
		margin: 15px 0px;
		padding: 0px;
		text-align: center;
	}

	#login .inner {
		width: 340px;
		padding-bottom: 6px;
		margin: 60px auto;
		text-align: left;
		border: 1px solid #aab;
		background-color: #f0f0fa;
		-moz-box-shadow: 2px 2px 2px #eee;
		-webkit-box-shadow: 2px 2px 2px #eee;
		-khtml-box-shadow: 2px 2px 2px #eee;
		box-shadow: 2px 2px 2px #eee;
	}

	#login .inner .fheader {
		padding: 18px 26px 14px 26px;
		background-color: #f7f7ff;
		margin: 0px 0 14px 0;
		color: #2e3741;
		font-size: 18px;
		font-weight: bold;
	}

	#login .inner .cssform p {
		clear: left;
		margin: 0;
		padding: 4px 0 3px 0;
		padding-left: 105px;
		margin-bottom: 20px;
		height: 1%;
	}

	#login .inner .cssform input[type='text'] {
		width: 120px;
	}

	#login .inner .cssform label {
		font-weight: bold;
		float: left;
		text-align: right;
		margin-left: -105px;
		width: 110px;
		padding-top: 3px;
		padding-right: 10px;
	}

	#login #remember_me_holder {
		padding-left: 120px;
	}

	#login #submit {
		margin-left: 15px;
	}

	#login #remember_me_holder label {
		float: none;
		margin-left: 0;
		text-align: left;
		width: 200px
	}

	#login .inner .login_message {
		padding: 6px 25px 20px 25px;
		text-align:center;
		font-weight:bold;
		color: #c33;
	}

	#login .inner .text_ {
		width: 120px;
	}

	#login .inner .chk {
		height: 12px;
	}
	</style>
</head>

<body>
<div id='login'>
	<div class='inner'>
		<div class='fheader'>请修改密码</div>

		<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
		</g:if>

		<g:form action="changePw" controller="user" name="changeForm" class='cssform'>
			<p>
				<label for='oPw'>旧密码:</label>
				<input type='password' class='text_' name='oPw' id='oPw'/>
			</p>
			<p>
				<label for='newPw'>新密码:</label>
				<input type='password' class='text_' name='newPw' id='newPw'/>
			</p>
			<p>
				<label for='confirmPw'>确认密码:</label>
				<input type='password' class='text_' name='confirmPw' id='confirmPw'/>
			</p>

			<p>
				<input type='submit' id="submit" value='确认修改'/>
			</p>
		
		</g:form>
	</div>
</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['changeForm'].elements['oPw'].focus();
	})();
	// -->
</script>
</body>
</html>
