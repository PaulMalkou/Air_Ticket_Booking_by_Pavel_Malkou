<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false" %>

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" var="mess"/>
<head>
    <title><fmt:message key="title.user_orders" bundle="${jsp_con}"/></title>
</head>
<body>
<c:set var="currentPage" scope="session" value="/jsp/user_orders.jsp"/>

<div class="container text-center justify-content-center" style="margin-top: 250px">

    <a href="${pageContext.request.contextPath}/jsp/user/user_profile.jsp" class="button" role="button">
        <fmt:message key="button.backToUserPage" bundle="${jsp_con}"/><br>
    </a><br>

    <c:if test="${empty orders}">
        ${user.name} ${user.surname}, <fmt:message key="message.noOrders" bundle="${mess}"/>
    </c:if>
    <c:if test="${not empty orders}">
        <h3>${user.name} ${user.surname}'s <fmt:message key="user_orders.info"  bundle="${jsp_con}"/> </h3><br>
    </c:if>
    <c:if test="${messageOrderIsAlreadyCancelled}">
    <span class="text-danger">
        <fmt:message key="message.orderIsAlreadyCancelled" bundle="${mess}"/></span><br><br>
    </c:if>
    <c:if test="${messageOrderCancelled}">
    <span class="text-success">
        <fmt:message key="message.orderCancelled" bundle="${mess}"/></span><br><br>
        <c:remove var="messageOrderCancelled"/>
    </c:if>
    <c:if test="${messageOrderFinished}">
    <span class="text-success">
        <fmt:message key="message.orderPickedUp" bundle="${mess}"/></span><br><br>
        <c:remove var="messageOrderPickedUp"/>
    </c:if>
    <c:if test="${not empty activeOrders}">
        <h3><fmt:message key="user_orders.active_orders" bundle="${jsp_con}"/></h3>
        <table class="table table-hover table-bordered" width="90%" cellpadding="5" border="1" >
            <thead class="thead-light text-uppercase">
            <tr>
                <th scope="col"><fmt:message key="orders.orderId" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.number_passengers" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_departure_airport" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_arrival_airport" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_airline" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.dateTimeOfDeparture" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.dateTimeOfArrival" bundle="${jsp_con}"/></th>
                <th scope="col"> <fmt:message key="flightDetails.hasTransferPoint" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.airplane" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.fare" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.isPaid" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.order_status" bundle="${jsp_con}"/></th>
            </tr>
            </thead>
            <tbody class="text-left">
            <c:forEach var="order" items="${activeOrders}" varStatus="status">
                <tr align="center">
                    <td scope="row" class="text-center">
                            ${order.id}
                    </td>
                    <td>${order.number_passengers}</td>
                    <td>${order.departure_airport.name}, <br>${order.departure_airport.country}, <br>${order.departure_airport.city}</td>
                    <td>${order.arrival_airport.name}, <br>${order.arrival_airport.country}, <br>${order.arrival_airport.city}</td>
                    <td>${order.airline.name_airline}</td>
                    <td>${order.flightDetails.departure_time}</td>
                    <td>${order.flightDetails.arrival_time}</td>
                    <td>${order.flightDetails.has_transfer_point}</td>
                    <td>${order.flightDetails.airplane.airplane_model}</td>
                    <td>${order.fare}</td>
                    <td>${order.is_paid()}</td>
                    <td class="text-center">${order.order_status}</td>
                    <td>
                        <form method="get" action="${pageContext.request.contextPath}/cancelOrderUser">
                            <input type="hidden" name="id_order" value="${order.id}">
                            <input type="submit" value=<fmt:message key="orders.cancel" bundle="${jsp_con}"/> />
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${not empty cancelledOrders}">
        <br>
        <h3><fmt:message key="user_orders.cancelled_orders" bundle="${jsp_con}"/></h3>
        <table class="table table-hover table-bordered" width="90%" cellpadding="5" border="1" >
            <thead class="thead-light text-uppercase">
            <tr>
                <th scope="col"><fmt:message key="orders.orderId" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.number_passengers" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_departure_airport" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_arrival_airport" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_airline" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.dateTimeOfDeparture" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.dateTimeOfArrival" bundle="${jsp_con}"/></th>
                <th scope="col"> <fmt:message key="flightDetails.hasTransferPoint" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.airplane" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.fare" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.isPaid" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.order_status" bundle="${jsp_con}"/></th>
            </tr>
            </thead>
            <tbody class="text-left">
            <c:forEach var="order" items="${cancelledOrders}" varStatus="status">
                <tr align="center">
                    <td scope="row" class="text-center">
                            ${order.id}<br>
                    </td>
                    <td>${order.number_passengers}</td>
                    <td>${order.departure_airport.name}, <br>${order.departure_airport.country}, <br>${order.departure_airport.city}</td>
                    <td>${order.arrival_airport.name}, <br>${order.arrival_airport.country}, <br>${order.arrival_airport.city}</td>
                    <td>${order.airline.name_airline}</td>
                    <td>${order.flightDetails.departure_time}</td>
                    <td>${order.flightDetails.arrival_time}</td>
                    <td>${order.flightDetails.has_transfer_point}</td>
                    <td>${order.flightDetails.airplane.airplane_model}</td>
                    <td>${order.fare}</td>
                    <td>${order.is_paid()}</td>
                    <td class="text-center">${order.order_status}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${not empty finishedOrders}">
        <br>
        <h3><fmt:message key="user_orders.finished_orders" bundle="${jsp_con}"/></h3>
        <table class="table table-hover table-bordered" width="90%" cellpadding="5" border="1" >
            <thead class="thead-light text-uppercase">
            <tr>
                <th scope="col"><fmt:message key="orders.orderId" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.number_passengers" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_departure_airport" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_arrival_airport" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.id_airline" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.dateTimeOfDeparture" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.dateTimeOfArrival" bundle="${jsp_con}"/></th>
                <th scope="col"> <fmt:message key="flightDetails.hasTransferPoint" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="flightDetails.airplane" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.fare" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.isPaid" bundle="${jsp_con}"/></th>
                <th scope="col"><fmt:message key="orders.order_status" bundle="${jsp_con}"/></th>
            </tr>
            </thead>
            <tbody class="text-left">
            <c:forEach var="order" items="${finishedOrders}" varStatus="status">
                <tr align="center">
                    <td scope="row" class="text-center">
                            ${order.id}<br>
                    </td>
                    <td>${order.number_passengers}</td>
                    <td>${order.departure_airport.name}, <br>${order.departure_airport.country}, <br>${order.departure_airport.city}</td>
                    <td>${order.arrival_airport.name}, <br>${order.arrival_airport.country}, <br>${order.arrival_airport.city}</td>
                    <td>${order.airline.name_airline}</td>
                    <td>${order.flightDetails.departure_time}</td>
                    <td>${order.flightDetails.arrival_time}</td>
                    <td>${order.flightDetails.has_transfer_point}</td>
                    <td>${order.flightDetails.airplane.airplane_model}</td>
                    <td>${order.fare}</td>
                    <td>${order.is_paid()}</td>
                    <td class="text-center">${order.order_status}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

</body>
</html>


