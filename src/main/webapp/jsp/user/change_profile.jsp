<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false" %>

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" scope="session" var="mess"/>
<head>
    <title><fmt:message key="title.changeProfile" bundle="${jsp_con}"/></title>
</head>

<body>
<c:set var="currentPage" value="/jsp/change_profile.jsp" scope="request"/>

<h2><fmt:message key="title.changeProfile" bundle="${jsp_con}"/></h2><br>

<c:if test="${confirmPasswordIncorrect}">
    <span class="text-danger">
                    <fmt:message key="message.invalidConfirmedPassword" bundle="${mess}"/>
    </span><br>
    <c:remove var="confirmPasswordIncorrect"/>

</c:if>


<h3><fmt:message key="changeProfile.personal_info" bundle="${jsp_con}"/></h3><br>

<form class="form-control-sm" name="signForm" method="POST" action = "${pageContext.request.contextPath}/changeProfile">
    <table border="0" width="50%" cellpadding="8">
        <tr>
            <td>
                <fmt:message key="registration.password" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="password" name="password" class="form-control" id="password" aria-describedby="passwordHelp"
                       placeholder="<fmt:message key="changeProfile.password.placeholder" bundle="${jsp_con}"/>"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,30}" required>
                <small id="passwordHelp" class="form-text text-muted"><fmt:message key="registration.password.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.confirm" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="password" name="confirmed_password" class="form-control" id="confirm_password" aria-describedby="confirmPasswordHelp"
                       placeholder="<fmt:message key="changeProfile.confirm.placeholder" bundle="${jsp_con}"/>"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,30}" required>
                <small id="confirmPasswordHelp" class="form-text text-muted"><fmt:message key="registration.confirm.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.name" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="name" class="form-control" id="name" aria-describedby="nameHelp"
                       placeholder="${user.name}" pattern="[A-Z]{1}[a-z]{2,19}|[А-Я]{1}[а-я]{2,19}" required>
                <small id="nameHelp" class="form-text text-muted"><fmt:message key="registration.name.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.surname" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="surname" class="form-control" id="surname" aria-describedby="surnameHelp"
                       placeholder="${user.surname}" pattern="[A-Z]{1}[a-z]{2,19}|[А-Я]{1}[а-я]{2,19}" required>
                <small id="surnameHelp" class="form-text text-muted"><fmt:message key="registration.surname.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.dob" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="dob" class="form-control" id="dob"
                       pattern="([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))"
                       placeholder="${user.dob}" required>
                <small id="ageHelp" class="form-text text-muted"><fmt:message key="registration.dob.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                    <fmt:message key="button.updateProfile" bundle="${jsp_con}"/>
                </button>
            </td>
        </tr>
    </table>
</form>




</body>
</html>
