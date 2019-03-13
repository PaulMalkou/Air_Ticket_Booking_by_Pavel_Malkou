<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" isELIgnored="false" %>

<html>
<fmt:setBundle basename="jsp_content"/>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key="title.error"/></title>
</head>
<h2><fmt:message key="title.error"/></h2><br>
<body>
<h2>Sorry, you do not have permission to view this page.</h2><br>
</body>
</html>
