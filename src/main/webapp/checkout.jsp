<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in !! Login first to access checkout page");
        response.sendRedirect("login.jsp");
        return;
    }


%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Mycart : Checkout</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>

<%@include file="components/navbar.jsp" %>
<div class="container">
    <form method="POST" action="UserOperationServlet">
        <div class="row mt-5">
            <div class="col-md-6">
                <!-- card -->

                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center mb-5">Your selected items</h3>
                        <div class="cart-body"></div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <!-- form details -->
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center mb-5">Your details for order</h3>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label> <input
                                value="<%=user.getUserEmail() %>"
                                type="email" class="form-control" id="exampleInputEmail1"
                                aria-describedby="emailHelp" placeholder="Enter email">
                            <small id="emailHelp" class="form-text text-muted">We'll
                                never share your email with anyone else.</small>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Your name</label> <input value="<%=user.getUserName() %>"
                                                                                     type="text" class="form-control"
                                                                                     id="name"
                                                                                     aria-describedby="emailHelp"
                                                                                     placeholder="Enter your name">

                        </div>
                        <div class="form-group">
                            <label for="exampleFormControlTextarea1">Your shipping address</label>
                            <textarea class="form-control" id="exampleFormControlTextarea1"
                                      rows="3" placeholder="Enter your address"><%=user.getUserAddress() %></textarea>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Your Phone Number</label> <input
                                value="<%=user.getUserPhone() %>"
                                type="text" class="form-control" id="phone"
                                aria-describedby="emailHelp" placeholder="Enter your number">

                        </div>
                        <div class="container text-center">
                            <input type="hidden" name="operation" value="order">
                            <button type="submit" class="btn btn-outline-success">Order now</button>
                            <a class="btn btn-outline-primary" href="index.jsp">Continue shopping</a>
                        </div>


                    </div>
                </div>

            </div>

        </div>
    </form>
</div>


<%@include file="components/common_modals.jsp" %>

</body>
</html>