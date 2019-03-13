<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page isELIgnored="false" %>

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" scope="session" var="mess"/>

<head>
    <title><fmt:message key="title.registration" bundle="${jsp_con}"/></title>
</head>

<body>

<h2><fmt:message key="title.registration" bundle="${jsp_con}"/></h2><br>

<c:if test="${confirmPasswordIncorrect}">
    <span class="text-danger">
                    <fmt:message key="message.invalidConfirmedPassword" bundle="${mess}"/>
    </span><br>
    <c:remove var="confirmPasswordIncorrect"/>

</c:if>

<c:if test="${loginAlreadyExist}">
    <span class="text-danger">
                    <fmt:message key="message.loginAlreadyExist" bundle="${mess}"/>
    </span><br>
    <c:remove var="loginAlreadyExist"/>

</c:if>

<c:if test="${passportNumberAlreadyExist}">
    <span class="text-danger">
                    <fmt:message key="message.passportNumberAlreadyExist" bundle="${mess}"/>
    </span><br>
    <c:remove var="passportNumberAlreadyExist"/>

</c:if>

<c:if test="${phoneNumberAlreadyExist}">
    <span class="text-danger">
                    <fmt:message key="message.phoneNumberAlreadyExist" bundle="${mess}"/>
    </span><br>
    <c:remove var="phoneNumberAlreadyExist"/>

</c:if>

<form class="form-control-sm" name="signForm" method="POST" action = "${pageContext.request.contextPath}/registration">
    <table border="0" width="50%" cellpadding="8">
        <tr>
            <td>
                <fmt:message key="registration.login" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="email" class="form-control" id="login" aria-describedby="emailHelp"
                       placeholder="<fmt:message key="registration.login.placeholder" bundle="${jsp_con}"/>"
                       pattern="[a-z0-9._%+-]{1,20}@[a-z0-9.-]{1,16}\.[a-z]{2,3}$" required>
                <small id="emailHelp" class="form-text text-muted"><fmt:message key="registration.login.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.password" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="password" name="password" class="form-control" id="password" aria-describedby="passwordHelp"
                       placeholder="<fmt:message key="registration.password.placeholder" bundle="${jsp_con}"/>"
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
                       placeholder="<fmt:message key="registration.confirm.placeholder" bundle="${jsp_con}"/>"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,30}" required>
                <small id="confirmPasswordHelp" class="form-text text-muted"><fmt:message
                        key="registration.confirm.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.name" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="name" class="form-control" id="name" aria-describedby="nameHelp"
                       placeholder="<fmt:message key="registration.name.placeholder" bundle="${jsp_con}"/>"
                       pattern="[A-Z]{1}[a-z]{2,19}|[А-Я]{1}[а-я]{2,19}" required>
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
                       placeholder="<fmt:message key="registration.surname.placeholder" bundle="${jsp_con}"/>"
                       pattern="[A-Z]{1}[a-z]{2,19}|[А-Я]{1}[а-я]{2,19}" required>
                <small id="surnameHelp" class="form-text text-muted"><fmt:message key="registration.surname.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.passport_number" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="passport_number" class="form-control" id="passport_number" aria-describedby="passportHelp"
                       placeholder="<fmt:message key="registration.passport_number.placeholder" bundle="${jsp_con}"/>" required>
                <small id="passportHelp" class="form-text text-muted"><fmt:message key="registration.passport_number.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.dob" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="dob" class="form-control" id="dob"
                       placeholder="<fmt:message key="registration.dob.placeholder" bundle="${jsp_con}"/>"
                       pattern="([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))" required>
                <small id="ageHelp" class="form-text text-muted"><fmt:message key="registration.dob.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.sex" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="radio" name="sex" value="M" checked>
                M
                <input type="radio" name="sex" value="F">
                F
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.phone" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="text" name="phone_number" class="form-control" id="phone_number" aria-describedby="phoneHelp"
                       placeholder="<fmt:message key="registration.phone.placeholder" bundle="${jsp_con}"/>"
                       pattern="[+]\d{3}[(]\d{2}[)]\d{3}[-]\d{2}[-]\d{2}" required>
                <small id="phoneHelp" class="form-text text-muted"><fmt:message key="registration.phone.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="registration.balance" bundle="${jsp_con}"/>
            </td>
            <td>
                <input type="number" name="balance" min="10" max="1000" class="form-control" id="balance"
                       placeholder="<fmt:message key="registration.balance.placeholder" bundle="${jsp_con}"/>" required> BYN
                <small id="balanceHelp" class="form-text text-muted">  <fmt:message key="registration.balance.small" bundle="${jsp_con}"/>
                </small>
            </td>
        </tr>
        <tr>
            <td>
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                    <fmt:message key="button.registration" bundle="${jsp_con}"/>
                </button>
            </td>
        </tr>
    </table>
</form>

</body>

</html>