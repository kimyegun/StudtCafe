<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("cache-control","no-store");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
	<link rel="stylesheet" href="../css/bootstrap.css">
	<link rel="stylesheet" href="../css/sidebar.css">
	<link rel="stylesheet" href="../css/list.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
<c:choose>
	<c:when test='${msg=="deleted"}'>
		<script>
			window.onload = function () {
				alert("회원 정보를 삭제했습니다.");
			}
		</script>
	</c:when>
</c:choose>
</style>
</head>
<body>
	<div id="viewport">
		<jsp:include page="sidebar.jsp"></jsp:include>
		<!-- Content -->
		<div id="content">
			<jsp:include page="top.jsp"></jsp:include>
			<div class="main_back">
				<div class="container">
					<h1 style="font-family: Namum">카테고리</h1>
					<div style="border-bottom: 1px solid #bdbdbd42; margin:5px 20px 20px 20px"></div>
					<form method="post" name="search">
						<table class="pull-right">
							<tr>
								<td>
									<select class="form-control" name="searchField">
										<option value="0">선택</option>
										<option value="bbsTitle">제목</option>
										<option value="userID">작성자</option>
									</select>
								</td>
								<td>
									<input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100"></td>
								<td><button type="button" class="btn btn-white btn-dark">검색</button></td>
								<td>
									<a href="#" data-toggle="modal" data-target="#myModal" style="background-color:red; color:blue;"  class="btn addbtn pull-right">추가</a>
								</td>
							</tr>
						</table>
					</form>
					<div style="width:100%; height:70%; overflow:auto">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="active table table1" style=" border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="text-align: center; vertical-align: middle;"></th>
									<th style="text-align: center; vertical-align: middle;">수정</th>
									<th style="text-align: center; vertical-align: middle;">삭제</th>
									<th style="text-align: center; vertical-align: middle;">카테고리명</th>
									<th style="text-align: center; vertical-align: middle;">카테고리 설명</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${list ==null }">
										<tr height="10">
											<td colspan="6">
												<p align="center">
													<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
												</p>
											</td>
										</tr>
									</c:when>
									<c:when test="${list !=null }">
										<c:forEach var="item" items="${list }" varStatus="articleNum">
											<tr align="center">
												<!-- 다른곳에서 복붙하지말고 여기에 추가해주세요  -->
												<td width="5%">${articleNum.count}</td>
												<td width="5%"><a href="#" data-toggle="modal" data-target="#myModal2"  class="btn back-blue btn-success pull-right">수정</a></td>
												<td width="5%"><input type="button" value="삭제" onclick="location.href='${contextPath}/admin/remove3.do?kateSearchNo=${item.kateNo}&katNo=${katTargetNo}'"></td>
												<td width="35%">${item.kateName}</td>
												<td width="50%">${item.kateDetail}</td>
										</c:forEach>
									</c:when>
								</c:choose>
							</tbody>
						</table>
					</div>
					
					<!-- 카테고리 추가 Modal -->
					<div class="modal fade" id="myModal" role="dialog">
						<form action="/admin/katadd.do" method="post">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header back-blue">
										<span class="font-nanum">카테고리 추가</span>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 id="modal-title" class="modal-title"></h4>
									</div>
									<div class="modal-body">
										<table class="table">
											<tr>
												<td>카테고리명</td>
												<td><input class="form-control" name="kateName" type="text"></td>
											</tr>
											<tr>
												<td>카테고리 설명</td>
												<td><textarea class="form-control" name="kateDetail" rows="5"></textarea></td>
											</tr>
										</table>
									</div>
									<div class="modal-footer">
										<button class="btn btn-success pull-right" type="submit">작성</button>
										<input type="hidden" size="67" maxlength="500" name="katNo" value="${katTargetNo}" />
									</div>
								</div>
							</div>
						</form>
					</div>
					
					<!-- 카테고리 수정 Modal -->
					<div class="modal fade" id="myModal2" role="dialog">
						<form action="/admin/katmod.do" method="post">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header back-blue">
										<span class="font-nanum">카테고리 수정</span>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 id="modal-title" class="modal-title"></h4>
									</div>
									<div class="modal-body">
										<table class="table">
											<tr>
												<td>카테고리명</td>
												<td><input class="form-control" name="kateName" type="text"></td>
											</tr>
											<tr>
												<td>카테고리 설명</td>
												<td><textarea class="form-control" name="kateDetail" rows="5"></textarea></td>
											</tr>
										</table>
									</div>
									<div class="modal-footer">
										<button class="btn btn-success pull-right" type="submit">수정하기</button>
										<input type="hidden" size="67" maxlength="500" name="katNo" value="${katTargetNo}" />
									</div>
								</div>
							</div>
						</form>
					</div>					
					
				</div>
			</div>
		</div>
	</div>

	<script src="../js/bootstrap.js"></script>
</body>
</html>