<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/resources/static/css/board.css">
</head>
<body>
    <div class="container">
        <!-- 글 작성 팝업 -->
        <div class="write-popup">
            <div class="editor">
                <div class="input-box">
                    <label for="studentsName">작성자 : </label>
                    <input id="studentsName" type="text" value="현상원" readonly>
                </div>
                <div class="input-box">
                    <label for="title">제목 : </label>
                    <input id="title" type="text" placeholder="제목을 입력하세요...">
                </div>
                <div class="input-box">
                    <textarea id="content" rows="10" cols="65" placeholder="내용을 간단히 적어주세요..."></textarea>
                </div>
                <div class="btn-area">
                    <a href="#" class="btn-cancel">취소</a>
                    <a id="contentSubmit" href="#" class="btn-success">등록</a>
                </div>
            </div>
        </div>
        <!-- 글 작성 수정 -->
        <div class="update-popup">
            <div class="editor">
                <div class="close">
                    <a href="#" class="btn-close">닫기</a>
                </div>
                <div class="input-box">
                    <label for="title">제목 : </label>
                    <input id="upt-title" type="text" placeholder="제목을 입력하세요...">
                </div>
                <div class="input-box">
                    <textarea id="upt-content" rows="10" cols="65" placeholder="내용을 간단히 적어주세요..."></textarea>
                </div>
                <div class="btn-area">
                    <input type="hidden" id="boardIdHidden">
                    <a id="contentUpdate" href="#" class="btn-update">수정</a>
                    <a id="contentDelete" href="#" class="btn-delete">삭제</a>
                </div>
            </div>
        </div>
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="logo-apple"></ion-icon></span>
                        <span class="title">DW Board</span>                
                    </a>
                </li>
                <li>
                    <a href="/board?pageNum=1&pageSize=10">
                        <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                        <span class="title">Dashboard</span>                
                    </a>
                </li>
                <li>
                    <a href="/students">
                        <span class="icon"><ion-icon name="person-outline"></ion-icon></span>
                        <span class="title">Students</span>                
                    </a>
                </li>
                <li>
                    <a href="/logs">
                        <span class="icon"><ion-icon name="lock-closed-outline"></ion-icon></span>
                        <span class="title">Logs</span>                
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>
                        <span class="title">Sign Out</span>                
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!-- main -->
    <div class="main">
        <div class="topbar">
            <div class="toggle">
                <!-- toggle -->
                <ion-icon name="menu-outline"></ion-icon>
            </div>
            <!-- search -->
            <div class="search">
                <label>
                    <input id="searchBar" type="text" placeholder="작성자를 검색하세요...">
                    <input id="keyword" type="hidden" value="null">
                </label>
            </div>
            <div>
                <a href="#" class="logout">Logout</a>
            </div>
        </div>
         <!-- cards -->
         <div class="cardBox">
             <div class="card">
                 <div>
                    <div id="studentsCnt" class="numbers">1400</div>
                    <div class="cardName">학생 수</div>
                 </div>
                 <div class="iconBx">
                    <ion-icon name="school-outline"></ion-icon>
                 </div>
             </div>
             <div class="card">
                <div>
                   <div id="boardCnt" class="numbers">500</div>
                   <div class="cardName">게시글 수</div>
                </div>
                <div class="iconBx">
                    <ion-icon name="book-outline"></ion-icon>
                </div>
            </div>
            <div class="card">
                <div>
                   <div id="writerCnt" class="numbers">300</div>
                   <div class="cardName">작성자 수</div>
                </div>
                <div class="iconBx">
                    <ion-icon name="code-slash-outline"></ion-icon>
                </div>
            </div>
            <div class="card">
                <div>
                   <div id="viewsCnt" class="numbers">2800</div>
                   <div class="cardName">조회 수</div>
                </div>
                <div class="iconBx">
                    <ion-icon name="eye-outline"></ion-icon>
                </div>
            </div>
         </div>
         <!-- table -->
         <div class="details">
             <div class="recentOrders">
                 <div class="cardHeader">
                     <h2>Board List</h2>
                     <a href="#" class="btn">글 작성</a>
                 </div>
                 <table>
                     <thead>
                         <tr>
                            <th>게시판 번호</th>
                            <th>작성자</th>
                            <th>제목</th>
                            <th>수정 날짜</th>
                            <th>작성 날짜</th>
                            <th>조회 수</th>
                         </tr>
                     </thead>
                     <tbody id="data">
                     	<c:choose>
                     		<c:when test="${fn:length(pageHelper.list) > 0}">
		                     	<c:forEach items="${pageHelper.list}" var="item">
		                     		<tr onclick="getBoard(${item.boardId})">
										<td>${item.boardId}</td>
										<td>${item.studentsName}</td>
										<td>${item.title}</td>
										<td>${item.updateAt}</td>
										<td>${item.createAt}</td>
										<c:choose>
											<c:when test="${item.cnt < 10}">
												<td><span class="row">${item.cnt}</span></td>
											</c:when>
											<c:when test="${item.cnt < 20}">
												<td><span class="middle">${item.cnt}</span></td>
											</c:when>
											<c:otherwise>
												<td><span class="high">${item.cnt}</span></td>
											</c:otherwise>
										</c:choose>
						        	</tr>
		                     	</c:forEach>
                     		
                     		</c:when>
                     		<c:otherwise>
                     			<tr>
                     				<td colspan="6" style="text-align:center;">게시글이 없습니다.</td>
                     			</tr>
                     		</c:otherwise>
                     	</c:choose>
                         <!-- <tr>
                             <td>1</td>
                             <td>현상원</td>
                             <td>점심시간이 너무 짧아요!</td>
                             <td>2022-05-19</td>
                             <td>2022-05-18</td>
                             <td><span class="high">8320</span></td>
                         </tr> -->
                     </tbody>
                 </table>
                 <div class="pagination">
                 	<c:if test="${pageHelper.hasPreviousPage}">
                 		<a href="/board?pageNum=${pageHelper.pageNum-1}&pageSize=10#"">Previous</a>
                 	</c:if>
                 	<c:forEach begin="${pageHelper.navigateFirstPage}" end="${pageHelper.navigateLastPage}" var="pageNum">
						<a id="pageNum${pageNum}" href="/board?pageNum=${pageNum}&pageSize=${pageHelper.pageSize}#">${pageNum}</a>
					</c:forEach>
                 	<c:if test="${pageHelper.hasNextPage}">
                 		<a href="/board?pageNum=${pageHelper.pageNum+1}&pageSize=10#">Next</a>
                 	</c:if>
                 	<input id="nowPageNum" type=hidden value="${pageHelper.pageNum}" />
                    
                    <!-- <a href="#">Previous</a>
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#">Next</a> -->
                 </div>
             </div>
         </div>
    </div>
</body>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
<script>
    $('.btn').click(function(){
        $('.write-popup').css('display', 'block');
    });
    $('.btn-cancel').click(function(){
        $('.write-popup').css('display', 'none');
    });
    $('.btn-close').click(function(){
        location.reload();
    });
    let list = document.querySelectorAll('.navigation li');
    function activeLink(){
        list.forEach((item) => {item.classList.remove('hovered')});
        this.classList.add('hovered');
    }
    list.forEach((item) => {item.addEventListener('mouseover',activeLink)});
</script>
<script>
	// esc
	$(document).keydown(function(e){
        if(e.keyCode == 27){
            $('.write-popup').css('display','none');
            $('.update-popup').css('display','none');
        }
    })
	
    function goPage(pageName){
		if(pageName == 'logs'){
			location.href="/logs";
		}
		if(pageName == 'students'){
			location.href="/students";		
		}
		if(pageName == 'dashboard'){
			location.href="/board?pageNum=1&pageSize=10";
		}
	}

	function getBoardList(pageNum, pageSize){
		location.href="/board?pageNum="+pageNum+"&pageSize="+pageSize
	}
	// 통계함수 호출
	getBoardStatistics();
    function getBoardStatistics(){
        $.ajax({
            url : "/api/v1/board/statistics",
            type : 'GET',
            dataType : 'json',
            success : function(response){
                $('#boardCnt').text(response.boardCnt);
                $('#studentsCnt').text(response.studentsCnt);
                $('#viewsCnt').text(response.viewsCnt);
                $('#writerCnt').text(response.writerCnt);
            }
        });
    }
	
	// page 번호 알아내서 css 바꾸기
	getPageNum()
	function getPageNum(){
		var pageNum = $('#nowPageNum').val();
		$('#pageNum'+pageNum).css('backgroundColor','#287bff')
		$('#pageNum'+pageNum).css('color','#fff')
	}
	// Board 보여주기 함수
	function getBoard(boardId){
        // boardId html에 hidden 하기 : 수정,삭제에 이용하려고
        // 화면 띄우기
        $('.update-popup').css('display', 'block');
        // ajax 작성
        $.ajax({
            url : "/api/v1/board/boardId/"+boardId,
            type : "GET",
            dataType : "json",
            success : function (response){
                // input에 data set 해주기
                $('#upt-title').val(response.title);
                $('#upt-content').val(response.content);
                $('#boardIdHidden').val(boardId);
                setBoardViews(boardId); // 조회 수 함수
            },
            error : function (request, status, error){
                console.log("Error : "+error);
            }
        });
    }
	// 조회수 증가 함수
	function setBoardViews(boardId){
        $.ajax({
            url : '/api/v1/board/views/boardId/'+boardId,
            type : 'PATCH',
            contentType : 'application/json',
            dataType : 'json',
            success : function (response){
                // 게시물 상세화면 감추기
                if(response > 0){
                    // 추후 로직 예정
					// error page로 이동하는 로직
                }

            }
        });
    }
	
	// 게시판 작성
	$('#contentSubmit').click(function(){
        if(confirm('게시글을 작성하시겠습니까?')){
            var studentsId = 1;
            var title = $('#title').val();
            var content = $('#content').val();
            // 빈칸 확인
            if(title == ''){
              alert('제목을 입력해주세요.')
              return false;
            }
            if(content == ''){
              alert('내용을 입력해주세요.')
              return false;
            }
            // API 서버에 전송할 JSON 생성
            var jsonData = {
                studentsId : studentsId,
                title : title,
                content : content
            }
            // AJAX 세팅
            $.ajax({
              url : '/api/v1/board',
              type : 'POST',
              contentType : 'application/json', // 서버에 json type으로 보낼 예정(요청)
              dataType : 'json', // 서버 결과를 json으로 응답 받겠다.
              data : JSON.stringify(jsonData),
              success : function(response){
                // 전송 한 data가 DB에 저장되었으면 alert
                if(response>0){
                	var pageNum = $('#nowPageNum').val();
                    getBoardList(pageNum,10);
                } 
            }
        })
    }
    });
	
	// 게시물 수정
    $('#contentUpdate').click(function(){
        var boardId = $('#boardIdHidden').val(); // hidden에 숨겨놓은 boardId
        // json data 만들기
        var title = $('#upt-title').val();
        var content = $('#upt-content').val();
        var jsonData = {
            title : title,
            content : content
        };
        // ajax 작성
        $.ajax({
            url : '/api/v1/board/boardId/'+boardId,
            type : 'PATCH',
            contentType : 'application/json',
            dataType : 'json',
            data : JSON.stringify(jsonData),
            success : function (response){
                // 게시물 상세화면 감추기
                if(response > 0){
                	alert("수정 완료")
                	var pageNum = $('#nowPageNum').val();
                    getBoardList(pageNum,10);
                }

            }
        });
    })
    // 게시물 삭제
    $('#contentDelete').click(function(){
        var boardId = $('#boardIdHidden').val(); // hidden에 숨겨놓은 boardId
        
        if(confirm('해당 게시물을 정말 삭제하시겠습니까?')){
	        // ajax 작성
	        $.ajax({
	            url : '/api/v1/board/boardId/'+boardId,
	            type : 'DELETE',
	            contentType : 'application/json',
	            dataType : 'json',
	            success : function (response){
	                // 게시물 상세화면 감추기
	                if(response > 0){
	                	alert("삭제 완료")
	                	var pageNum = $('#nowPageNum').val();
	                    getBoardList(pageNum,10);
	                }
	            }
	        });
        }
    })
    $('#searchBar').keyup(function(key){
        var pageNum = 1;
        var pageSize = 10;
        if(key.keyCode==13){
            // input 값 가져오기
            var search = $('#searchBar').val().trim();
            // hidden tag에 내가 검색한 keyword를 vlaue에 set
            if(search != ''){
            	location.href="/board/search?search="+search+"&pageNum="+pageNum+"&pageSize="+pageSize;
            }
        }
    })
	
</script>
</html>