<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" isELIgnored="false" %>

<html>
<fmt:setBundle basename="jsp_content" scope="session"/>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key="title.error"/></title>
</head>
    <h2><fmt:message key="title.error"/></h2><br>
<body>
    <strong>Request from ${pageContext.errorData.requestURI} is failed</strong>
    <br/>
    <strong><Servlet> Controller: ${pageContext.errorData.servletName}</Servlet></strong>
    <br/>
    <strong>Status code: ${pageContext.errorData.statusCode}</strong>
    <br/>
    <strong>Exception: ${pageContext.errorData.throwable}</strong>
    <br/>
    <div>
        <a href="${pageContext.request.contextPath}/jsp/login.jsp"></a>
    </div>
     <h3>Sorry. Your request can't be performed</h3>
</body>
</html>
