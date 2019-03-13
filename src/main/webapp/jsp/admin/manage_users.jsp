<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<head>
    <title><fmt:message key="title.users" bundle="${jsp_con}"/></title>
</head>
<body>
<c:set var="currentPage" value="/jsp/manage_users.jsp" scope="request"/>

<h2><fmt:message key="title.users" bundle="${jsp_con}"/></h2><br>

<a href="${pageContext.request.contextPath}/jsp/admin/admin_profile.jsp" class="button" role="button">
    <fmt:message key="button.backToAdminPage" bundle="${jsp_con}"/><br>
</a><br>

<div class="container text-center" style="margin-top: 250px">
    <div class="row justify-content-center">
        <div class="col">
            <table class="table table-hover table-bordered" cellpadding="5">
                <thead class="thead-light text-uppercase">
                <tr>
                    <th scope="col"><fmt:message key="profile.id" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.email" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.name" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.surname" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.passport_number" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.dob" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.sex" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.phone_number" bundle="${jsp_con}"/></th>
                    <th scope="col"><fmt:message key="profile.balance" bundle="${jsp_con}"/></th>
                </tr>
                </thead>
                <tbody class="text-left">
                <c:forEach var="user" items="${users}" varStatus="status">
                    <c:if test="${user.role == 'USER'}">
                        <tr>
                            <td scope="row">${user.id}</td>
                            <td>${user.email}</td>
                            <td>${user.name}</td>
                            <td>${user.surname}</td>
                            <td class="text-nowrap">${user.passport_number}</td>
                            <td>${user.dob}</td>
                            <td>${user.sex}</td>
                            <td>${user.phone_number}</td>
                            <td>${user.balance} </td>
                            <td>
                                <form:form method="post" action="/removeUser">
                                    <input type="hidden" name="userToDeleteId" value="${user.id}"/>
                                    <input type="submit" value="<fmt:message key="button.remove" bundle="${jsp_con}"/>"/>
                                </form:form>
                            </td>
                            <td>
                                <form:form method="post" action="/manageOrders" target="_blank">
                                    <input type="hidden" name="userIdToShowOrders" value="${user.id}">
                                    <input type="submit" size="70" value=<fmt:message key="button.showUserOrders" bundle="${jsp_con}"/>/>
                                </form:form>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<br>
<br>

</body>
</html>

