<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order</title>
    <%@include file="components/common_css_js.jsp" %>
    <style>
        .profile-card {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            background: #fff;
        }
    </style>
</head>

<body>
<%@include file="components/navbar.jsp" %>

<div class="container mt-4">
    <div class="profile-card p-4">
        <%@include file="components/message.jsp" %>
        <h2 class="text-center mb-4">Order Successfully</h2>

        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-primary">Home</a>
        </div>
    </div>
</div>


</body>
</html>
<script>
    <% String msg = (String) session.getAttribute("order");
    if (msg != null) { %>
    localStorage.removeItem("cart");
    <% session.removeAttribute("order"); %>
    <% } %>
</script>