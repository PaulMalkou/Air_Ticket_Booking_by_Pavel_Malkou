<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false" %>


<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" var="mess"/>
<head>
    <title><fmt:message key="title.order_manager" bundle="${jsp_con}"/></title>
</head>

<body>
<c:set var="currentPage" value="/jsp/manage_orders.jsp" scope="session"/>

<h2><fmt:message key="title.order_manager" bundle="${jsp_con}"/></h2><br><br>

<div class="container text-center justify-content-center" style="margin-top: 250px">
    <div class="row">
        <div class="col">
            <c:if test="${empty orders}">
                <fmt:message key="orders.noOrders" bundle="${jsp_con}"/><br><br>
            </c:if>
            <c:if test="${messageOrderIsAlreadyCancelled}">
                <span class="text-danger">
                    <fmt:message key="message.orderIsAlreadyCancelled" bundle="${mess}"/></span>
            </c:if>
            <c:if test="${messageOrderCancelled}">
                <span class="text-success">
                    <fmt:message key="message.orderCancelled"  bundle="${mess}"/></span>
                <c:remove var="messageOrderCancelled"/>
            </c:if>
            <c:if test="${messageOrderFinished}">
                <span class="text-success">
                    <fmt:message key="message.orderFinished"  bundle="${mess}"/></span>
                <c:remove var="messageOrderFinished"/>
            </c:if>
            <c:if test="${not empty orders}">
                <br><h3 class="text-right"><fmt:message key="title.orders" bundle="${jsp_con}"/>
                <c:if test="${userToShowOrders != null}">
                    <fmt:message key="orders.for" bundle="${jsp_con}"/> <br><br>
                    ID = ${userToShowOrders.id},  ${userToShowOrders.name} ${userToShowOrders.surname},  ${userToShowOrders.email}
                </c:if>
            </h3><br>
                <table class="table table-hover table-bordered" width="90%" cellpadding="5" border="1" >
                    <thead class="thead-light text-uppercase">
                    <tr>
                        <th scope="col"><fmt:message key="orders.orderId" bundle="${jsp_con}"/></th>
                        <c:if test="${userToShowOrders == null}">
                            <th scope="col"><fmt:message key="orders.userId" bundle="${jsp_con}"/></th>
                        </c:if>
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
                    <c:forEach var="order" items="${orders}" varStatus="status">
                        <tr align="center">
                            <td scope="row" class="text-center">
                                    ${order.id}<br>
                            </td>
                            <c:if test="${userToShowOrders == null}">
                                <td class="text-center">
                                    <c:forEach var="user" items="${usersWithOrders}">
                                        <c:if test="${user.id == order.user.id}">
                                            ${user.name} ${user.surname} <br>
                                            <span class="text-nowrap">${user.phone_number}</span><br>
                                        </c:if>
                                    </c:forEach>
                                        ${order.user.id}
                                </td>
                            </c:if>
                            <td>${order.number_passengers}</td>
                            <td>${order.departure_airport.name}, <br>${order.departure_airport.country}, <br>${order.departure_airport.city}</td>
                            <td>${order.arrival_airport.name}, <br>${order.arrival_airport.country},<br>${order.arrival_airport.city}</td>
                            <td>${order.airline.name_airline}</td>
                            <td>${order.flightDetails.departure_time}</td>
                            <td>${order.flightDetails.arrival_time}</td>
                            <td>${order.flightDetails.has_transfer_point}</td>
                            <td>${order.flightDetails.airplane.airplane_model}</td>
                            <td>${order.fare}</td>
                            <td>${order.is_paid()}</td>
                            <td class="text-center">${order.order_status}</td>
                            <c:if test="${order.order_status == 'ACTIVE'}">
                                <td>
                                    <form method="get" action="${pageContext.request.contextPath}/cancelOrderAdmin">
                                        <input type="hidden" name="id_order" value="${order.id}">
                                        <input type="submit" value="<fmt:message key="orders.cancel" bundle="${jsp_con}"/>"/>
                                    </form>
                                </td>
                                <td>
                                    <form method="get" action="${pageContext.request.contextPath}/finishOrder">
                                        <input type="hidden" name="id_order" value="${order.id}">
                                        <input type="submit" value="<fmt:message key="orders.finish" bundle="${jsp_con}"/>"/>
                                    </form>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>

        </div>

    </div>
</div>


</body>
</html>




