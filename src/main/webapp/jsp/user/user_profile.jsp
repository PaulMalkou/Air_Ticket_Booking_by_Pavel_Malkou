<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false" %>

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" scope="session" var="mess"/>
<head>
    <title><fmt:message key="title.user.profile" bundle="${jsp_con}"/></title>
</head>

<body>
<c:set var="currentPage" value="/jsp/user_profile.jsp" scope="request"/>

<h2><fmt:message key="title.user.profile" bundle="${jsp_con}"/></h2><br>

<form method="get" action="${pageContext.request.contextPath}/logout">
    <input type="submit" value="<fmt:message key="button.logout" bundle="${jsp_con}"/>">
</form>

<h3><fmt:message key="profile.personal_info" bundle="${jsp_con}"/></h3>

<a href="${pageContext.request.contextPath}/jsp/user/change_profile.jsp" class="button" role="button">
    <fmt:message key="profile.wantToChangeProfile" bundle="${jsp_con}"/><br>
</a><br>

<table border="0" width="20%" cellpadding="8">
    <tr>
        <td><fmt:message key="profile.id" bundle="${jsp_con}"/>:</td>
        <td>${user.id}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.email" bundle="${jsp_con}"/>:</td>
        <td>${user.email}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.password" bundle="${jsp_con}"/>:</td>
        <td>${user.password}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.name" bundle="${jsp_con}"/>:</td>
        <td>${user.name}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.surname" bundle="${jsp_con}"/>:</td>
        <td>${user.surname}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.passport_number" bundle="${jsp_con}"/>:</td>
        <td>${user.passport_number}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.dob" bundle="${jsp_con}"/>:</td>
        <td>${user.dob}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.sex" bundle="${jsp_con}"/>:</td>
        <td>${user.sex}</td>
    </tr>
    <tr>
        <td><fmt:message key="profile.phone_number" bundle="${jsp_con}"/>:</td>
        <td>${user.phone_number}</td>
    </tr>
</table><br>

<h3><fmt:message key="profile.balance_info" bundle="${jsp_con}"/></h3><br>
<div><fmt:message key="profile.balance" bundle="${jsp_con}"/>: ${user.balance} BYN</div><br>

<form:form method="get" action="/addDropDownLists">
    <input type="submit" value="<fmt:message key="button.wantToMakeOrder" bundle="${jsp_con}"/>"/>
</form:form><br>

<form:form method="post" action="/showUserOrders">
    <input type="submit" value="<fmt:message key="button.showUserOrders" bundle="${jsp_con}"/>"/>
</form:form>

</body>
</html>
