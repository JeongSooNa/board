<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="/resources/static/css/login.css" />
    <title>게시판 로그인</title>
  </head>
  <body>
    <div class="container">
      <h1>Login</h1>
      <div class="login-form">
        <div class="txt-field">
          <input id="userId" type="text" required />
          <label>Please input ID</label>
        </div>
        <div class="txt-field">
          <input id="userPassword" type="password" required />
          <label>Please input Password</label>
        </div>
        <input class="login-btn" id="loginBtn" type="button" value="Login" />
        <div class="signup-link">회원이 아닌가요? <a href="/join">회원가입</a></div>
      </div>
    </div>
    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
    <script>
      // 로그인 버튼이 click될 때 실행
      $('#loginBtn').click(function(){
        // data
        var userId = $('#userId').val();
        var userPassword = $('#userPassword').val();

        // id 빈칸 여부
        if(userId === ''){
          alert('아이디를 입력하세요.');
          $('#userId').focus();
          return false;
        }
        // 비밀번호 빈칸 여부
        if(userPassword === ''){
          alert('비밀번호를 입력하세요.');
          $('#userPassword').focus();
          return false;
        }

        // API 서버에 전송할 JSON 생성
        var jsonData = {
          studentsName : userId,
          studentsPassword : userPassword
        }
        // AJAX 세팅
        $.ajax({
          url : 'http://localhost:8080/api/v1/login',
          type : 'POST',
          contentType : 'application/json', // 서버에 json type으로 보낼 예정(요청)
          dataType : 'json', // 서버 결과를 json으로 응답 받겠다.
          data : JSON.stringify(jsonData),
          success : function(response){
            if(response) location.href = '/board?pageNum=1&pageSize=10'; // page이동
            else alert('비밀번호 혹은 이름이 틀렸습니다.')
          }
        })
      })
    </script>
  </body>
</html>