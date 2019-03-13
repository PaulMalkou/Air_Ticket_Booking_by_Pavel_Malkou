<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false" %>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" scope="session" var="mess"/>
<head>
    <title><fmt:message key="title.login" bundle="${jsp_con}"/></title>
</head>

<body>

<h2><fmt:message key="title.login" bundle="${jsp_con}"/></h2><br>

<c:if test="${messageErrorLoginPassword}">
    <span class="text-danger">
        <fmt:message key="message.ErrorLoginPassword" bundle="${mess}"/>
    </span>
</c:if>
<form name="LoginForm" method="POST" action="/login">
    <table border="0" width="25%" cellpadding="7">
        <tr>
            <td>
                <fmt:message key="login.login" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="email" id="exampleInputEmail" aria-describedby="emailHelp"
                       placeholder="<fmt:message key="login.login.placeholder" bundle="${jsp_con}"/>" required/>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="login.password" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="password" name="password" id="exampleInputPassword"
                       placeholder="<fmt:message key="login.password.placeholder" bundle="${jsp_con}"/>" required/>
            </td>
        </tr>
        <tr>
            <td>
                <button class="btn btn-outline-success" type="submit"><fmt:message key="button.login" bundle="${jsp_con}"/></button>
            </td>
        </tr>
    </table>
</form><br>

<a href="${pageContext.request.contextPath}/registration" class="button" role="button">
    <fmt:message key="login.registration.forward" bundle="${jsp_con}"/><br>
</a><br>

</body>
</html>
