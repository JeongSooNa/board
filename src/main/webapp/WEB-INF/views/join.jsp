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
    <title>회원가입</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      .container {
        margin: 100px auto;
        background: rgba(232, 232, 232, 0.5);
        width: 800px;
        height: auto;
        padding: 3%;
      }
      .container h1 {
        text-align: center;
        margin-bottom: 10px;
      }
      .container input {
        width: 100%;
        height: 30px;
        margin-bottom: 5px;
      }
      .container select {
        width: 100%;
        height: 30px;
        margin-bottom: 5px;
      }
      .row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 5px;
      }
      .row input {
        flex-basis: 30%;
      }
      .row select {
        flex-basis: 30%;
      }
      button {
        color: #fff;
        border: solid 1px rgba(0, 0, 0, 0.08);
        background-color: #03c75a;
        width: 100%;
        padding: 15px 0 15px;
        margin-top: 10px;
        font-size: 18px;
        font-weight: 700;
        text-align: center;
        cursor: pointer;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>DW 게시판 회원가입</h1>
      <label for="password">비밀번호</label>
      <input id="password" type="password" />
      <label for="rePassword">비밀번호 재확인</label>
      <input id="rePassword" type="password" />
      <label for="userName">이름</label>
      <input id="userName" type="text" />
      <button type="button" onclick="join()">가입하기</button>
    </div>
    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
    <script>
      function join(){
        // 프론트에서 정보 Check!
        var password = $('#password').val();
        var rePassword = $('#rePassword').val();
        var userName = $('#userName').val();

        if(password == '' || rePassword == '' || userName == ''){
          alert('양식을 모두 적어주세요.')
          return false;
        }
        if(password !== rePassword){
          alert('입력한 비밀번호가 다릅니다.')
          $('#rePassword').focus();
          return false;
        }
        // API 서버에 전송할 JSON 생성
        var jsonData = {
          studentsName : userName,
          studentsPassword : rePassword
        }
        // AJAX 세팅
        $.ajax({
          url : '/api/v1/students',
          type : 'POST',
          contentType : 'application/json', // 서버에 json type으로 보낼 예정(요청)
          dataType : 'json', // 서버 결과를 json으로 응답 받겠다.
          data : JSON.stringify(jsonData),
          success : function(response){
            // 전송 한 data가 DB에 저장되었으면 alert
            if(response>0){
            	alert('회원가입이 완료되었습니다.')
            	location.href = "/login";
            }
          }
        })

        // 완료 후 백앤드에서도 Check 필요.
      }
    </script>
  </body>
</html>
