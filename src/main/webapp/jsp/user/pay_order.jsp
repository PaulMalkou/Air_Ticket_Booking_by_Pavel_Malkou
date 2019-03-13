<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" var="mess"/>

<%--<fmt:setBundle basename="messages" scope="session"/>--%>
<head>
    <title><fmt:message key="title.order_pay" bundle="${jsp_con}"/></title>
</head>

<body>
<c:set var="currentPage" value="/jsp/pay_order.jsp" scope="session"/>

<h2><fmt:message key="title.order_pay" bundle="${jsp_con}"/></h2><br>

<c:if test="${orderIsPaidAlready}">
    <fmt:message key="message.orderIsAlreadyPaid" bundle="${mess}"/><br><br>
    <c:remove var="orderIsPaidAlready"/>
</c:if><br>

<c:if test="${messageNotEnoughMoney}">
    <span class="text-danger">
        <fmt:message key="message.notEnoughMoney" bundle="${mess}"/>
    </span><br><br>
    <span class="text-danger">
        <fmt:message key="message.amountNoEnough" bundle="${mess}"/>:
    </span><br><br>
    ${howMuchMoneyNotEnough} BYN <br><br>
    <c:remove var="messageNotEnoughMoney"/>
</c:if>

<c:if test="${messageMoneyWithdrawn}">
    <fmt:message key="message.moneyWithdrawn" bundle="${mess}"/><br><br>
    <c:remove var="messageMoneyWithdrawn"/>
</c:if><br>

<a href="${pageContext.request.contextPath}/jsp/user/user_profile.jsp" class="button" role="button">
    <fmt:message key="button.backToUserPage" bundle="${jsp_con}"/><br>
</a><br>

<form method="post" action="${pageContext.request.contextPath}/payOrder">
    <table border="0" width="40%" cellpadding="8">
        <tr>
            <td>
                <fmt:message key="orders.client" bundle="${jsp_con}"/>: ${user.name} ${user.surname}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="orders.number_passengers" bundle="${jsp_con}"/>: ${order.number_passengers}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="orders.id_departure_airport" bundle="${jsp_con}"/>: ${order.departure_airport.name} - ${order.departure_airport.country} - ${order.departure_airport.city}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="orders.id_arrival_airport" bundle="${jsp_con}"/>: ${order.arrival_airport.name} - ${order.arrival_airport.country} - ${order.arrival_airport.city}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="orders.id_airline" bundle="${jsp_con}"/>: ${order.airline.name_airline}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="flightDetails.dateTimeOfDeparture" bundle="${jsp_con}"/>: ${order.flightDetails.departure_time}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="flightDetails.dateTimeOfArrival" bundle="${jsp_con}"/>: ${order.flightDetails.arrival_time}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="flightDetails.hasTransferPoint" bundle="${jsp_con}"/> ${order.flightDetails.has_transfer_point}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="flightDetails.airplane" bundle="${jsp_con}"/>: ${order.flightDetails.airplane.airplane_model}
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="profile.balance" bundle="${jsp_con}"/>: ${user.balance} BYN
            </td>
        </tr>
        <tr>
            <td>
                <fmt:message key="orders.fare" bundle="${jsp_con}"/>: ${order.fare} BYN
                </label></td>
        </tr>

        <tr>

            <td>
                <input type="submit" value=<fmt:message key="button.payOrder" bundle="${jsp_con}"/>/>
            </td>
        </tr>

    </table><br><br>
</form>

<form name="addMoney" method="post" action="${pageContext.request.contextPath}/addMoney">
    <div class="row justify-content-center">
        <div class="col-auto">
            <fmt:message key="profile.make_deposit" bundle="${jsp_con}"/>:<br>
            <input type="number" class="form-control" placeholder="100" min="10" max="1000" name="moneyAmount" required/> BYN
        </div><br>
        <div class="col-auto">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                <fmt:message key="button.addMoney" bundle="${jsp_con}"/>
            </button>
        </div>
    </div><br>
</form>

</body>
</html>
