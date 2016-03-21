<html>
<head>
	<title>悍思巡检信息平台</title>
    <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<style type='text/css' media='screen'>
	#login {
		margin: 30px 0px;
		text-align: center;
	}
	#title{
		text-align: center;
	}
	#login .inner {
		width: 360px;
		height: 240px;
		padding-bottom: 6px;
		margin: 0px auto;
		text-align: left;
		background: #fff url(../images/login.png);
	}

	#login .inner .fheader {
		padding: 10px 0px 10px 0px;
		text-align:center;
		color: #000;
		margin:10px 10px 0px 10px;
		background: #cccabb;
		font-size: 20px;
		font-weight: bold;
	}

	#login .inner .cssform{
		margin: 0px 20px 10px 20px;
		height: 160px;
	    background: #fff url(../images/login.jpg) ;
	}
	#login .inner .cssform p {
		clear: left;
		margin: 0;
		padding: 10px  0 5px 100px;
	}

	#login .inner .cssform input[type='text'] {
		width: 120px;
		margin-top: 5px;
		margin-left:15px;
	}

	#login .inner .cssform label {
		text-align: right;
		margin-left: -30px;
		width: 60px;
		padding-top: 5px;
		padding-right: 5px;
		color:  #ffffff;
	}
	#login .inner .Isubmit{
		width:60px;
		height:30px;
		background: #524d53;
		color: white;
	}

	#login #remember_me_holder {
		padding-left: 70px;
	}

	#login #submit {
		margin:0px 5px;
	}

	#login #remember_me_holder label {
		float: left;
		margin-left: 0;
		text-align: left;
		width: 60px;
		display:inline;
	}

	#login .inner .login_message {
		padding: 6px 10px 10px 10px;
		color: #c33;
		text-align: center;
	}

	#login .inner .text_ {
		width: 120px;
		margin-top: 5px;
		margin-left:15px;
	}

	#login .inner .chk {
		height: 12px;
		float:left;
	}
	</style>
</head>

<body>
<div id='title'>
<img style="border: 0 none;"  src="${resource(dir:'images',file:'title_login.png')}"/>
</div>
<div id='login'>
	<div class='inner'>
		<div class='fheader'><img style="border: 0 none;" src="${resource(dir:'images',file:'user.png')}"/><g:message code="springSecurity.login.header"/></div>

		<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
		</g:if>

		<form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
			<p>
				<label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class='text_' name='j_username' id='username'/>
			</p>

			<p>
				<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='text_' name='j_password' id='password'/>
			</p>

			<p id="remember_me_holder">
				<input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
				<label for='remember_me'><g:message code="springSecurity.login.remember.me.label"/></label>
				<input type='submit' id="submit" value='${message(code: "springSecurity.login.button")}' class='Isubmit'/>
				<g:link controller="systemInfo" style="color:white;font-weight:bold;font-size:14px;">系统信息</g:link>
			</p>
		</form>
	</div>
</div>
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
