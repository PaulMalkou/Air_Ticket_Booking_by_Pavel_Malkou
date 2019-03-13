<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<fmt:setBundle basename="jsp_content" var="jsp_con"/>
<fmt:setBundle basename="messages" scope="session" var="mess"/>

<head>
    <title><fmt:message key="title.order" bundle="${jsp_con}"/></title>
</head>

<body>
<c:set var="currentPage" value="/jsp/order.jsp" scope="session"/>

<h2><fmt:message key="title.order" bundle="${jsp_con}"/></h2><br>

<a href="${pageContext.request.contextPath}/jsp/user/user_profile.jsp" class="button" role="button">
    <fmt:message key="button.backToUserPage" bundle="${jsp_con}"/><br>
</a><br>

<c:if test="${airportSelectIncorrect}">
    <span class="text-danger">
                    <fmt:message key="message.airportSelectIncorrect" bundle="${mess}"/>
    </span><br><br>
    <c:remove var="airportSelectIncorrect"/>
</c:if>

<form name="OrderForm" method="post" action="${pageContext.request.contextPath}/placeOrder">

    <table border="0" width="40%" cellpadding="8">
        <tr>
            <td><label><fmt:message key="order.number_passengers" bundle="${jsp_con}"/></label></td>
            <td><input type="number" name="number_passengers" min="1" max="10" required/></td>
        </tr>
        <tr>
            <td> <label><fmt:message key="order.departureAirport" bundle="${jsp_con}"/></label></td>
            <td><select name="departureAirport">
                <c:forEach items="${listAirports}" var="airport">
                    <option value="${airport.id}">
                            ${airport.name}   -   ${airport.country}   -   ${airport.city}
                    </option>
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td><label><fmt:message key="order.arrivalAirport" bundle="${jsp_con}"/></label></td>
            <td><select name="arrivalAirport">
                <c:forEach items="${listAirports}" var="airport">
                    <option value="${airport.id}">
                            ${airport.name}   -   ${airport.country}   -   ${airport.city}
                    </option>
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td><label><fmt:message key="order.airline" bundle="${jsp_con}"/></label></td>
            <td><select name="airline">
                <c:forEach items="${listAirlines}" var="airline">
                    <option value="${airline.id}">${airline.name_airline}</option>
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td><button class="btn btn-outline-success" type="submit"><fmt:message key="button.placeOrder" bundle="${jsp_con}"/></button></td>
        </tr>

    </table>

</form>

</body>
</html>
