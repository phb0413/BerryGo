<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="cp" value="${ pageContext.request.contextPath }"></c:set>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>itemList</title>
	<style>
		table, tr, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        #content-itemList {
            margin: 0 auto;
            width: 600px;
        }
        #title {
            text-align: center;
        }
        .itemImage {
        	width: 100px;
        	border: 1px solid lightgray;        
        }
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<table id="content-itemList">
		<tr>
			<td colspan="6" id="title"><h1>전체 과일 목록</h1></td>
		</tr>
		<c:set var="itemSize" value="${fn:length(itemList)}"></c:set>
		<c:forEach var="index" begin="0" end="${itemSize}" step="3"> <!-- step을 3으로 설정 -->
			<tr>
				<c:forEach var="j" begin="0" end="2"> <!-- 한 번에 3개 항목을 표시하기 위해 end를 2로 설정 -->
					<c:if test="${index + j < itemSize}">
						<td width="150px" height="150px" align="center">
							<c:set var="imagePath" value="${pageContext.request.contextPath}/resources/image/${itemList[index + j].item_image}"></c:set>
							<a href = "#"><img class="itemImage" src="${imagePath}" width="100px"></a>
						</td>
					</c:if>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="j" begin="0" end="2">
					<c:if test="${index + j < itemSize}">
						<c:choose>
							<c:when test="${itemList[index + j].item_stock <= 0}">
								<td>${itemList[index + j].item_name}</td>
							</c:when>
							<c:otherwise>
								<td><a href="${cp}/shop/itemInfo.do?itemNumber=${itemList[index + j].item_number}">${itemList[index + j].item_name}</a></td>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="j" begin="0" end="2">
					<c:if test="${index + j < itemSize}">
						<c:choose>
							<c:when test="${itemList[index + j].item_stock <= 0}">
								<td><b>품절</b></td>
							</c:when>
							<c:otherwise>
								<td>${itemList[index + j].item_price}</td>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>
