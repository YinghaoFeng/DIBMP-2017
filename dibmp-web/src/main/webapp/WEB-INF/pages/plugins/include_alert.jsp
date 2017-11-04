<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${msg != null}">
	<div class="alert alert-danger" id="alertDiv">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<span id="alertText">${msg}</span>
	</div>
</c:if>
<c:if test="${param.setfloat == null}">
	<div class="alert alert-success" id="alertDiv" style="display:none;">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<span id="alertText"></span>
	</div>
</c:if>
<c:if test="${param.setfloat != null}">
	<div class="alert alert-success" id="alertDiv" style="display:none; float: left">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<span id="alertText"></span>
	</div>
</c:if>