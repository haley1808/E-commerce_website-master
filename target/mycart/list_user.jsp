<%@page import="com.learn.mycart.helper.Helper" %>
<%@page import="com.learn.mycart.helper.FactoryProvider" %>
<%@page import="java.util.List" %>
<%@page import="com.learn.mycart.entities.*" %>
<%@ page import="com.learn.mycart.dao.UserDao" %>
<html>
<head>
    <title>Users</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<%
    UserDao dao = new UserDao(FactoryProvider.getFactory());
    List<User> list = dao.getAllUsers();
%>
<% int userId = (int) session.getAttribute("admin-id"); %>
<div class="container mt-4">
    <h2 class="text-center">Users</h2>
    <div class="text-left mt-2" style="margin-bottom: 10px">
        <a href="admin.jsp" class="btn btn-secondary">Back</a>
    </div>
    <%@include file="components/message.jsp" %>
    <div class="row">
        <% for (User u : list) { %>
        <div class="col-md-4">
            <div class="card mb-4">
                <img class="card-img-top m-2" src="img/<%= u.getUserPic()%>" alt="<%= u.getUserName() %>"
                     style="height: 200px; object-fit: cover; width: auto;">
                <div class="card-body">
                    <h5 class="card-title mb-1">Name: <%= u.getUserName() %>
                    </h5>
                    <p class="card-text mb-1">Address: <%= Helper.get10Words(u.getUserAddress()) %>
                    </p>
                    <p class="card-text mb-1">Email: <%= u.getUserEmail() %>
                    </p>
                    <p class="card-text mb-1">Phone: <%= u.getUserPhone() %>
                    </p>
                    <p class="card-text mb-1">Type: <%= u.getUserType() %>
                    </p>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
<%@include file="components/common_modals.jsp" %>
</body>
</html>