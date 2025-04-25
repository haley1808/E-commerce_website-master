<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.learn.mycart.entities.User" %>

<html>
<head>
    <meta charset="ISO-8859-1">
    <title>User Profile</title>
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

        .profile-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            border: 3px solid #ddd;
        }
    </style>
</head>

<body>
<%@include file="components/navbar.jsp" %>

<div class="container mt-4">
    <div class="profile-card p-4">
        <h2 class="text-center mb-4">User Profile</h2>

        <div class="row">
            <!-- Ảnh đại diện -->
            <div class="col-md-4 text-center">
                <img src="img/<%= current_user.getUserPic()%>" alt="<%= current_user.getUserName() %>"
                     class="profile-img">
            </div>

            <!-- Thông tin cá nhân -->
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-6">
                        <h6><b>Full Name:</b></h6>
                        <p><%= current_user.getUserName() %>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <h6><b>Email:</b></h6>
                        <p><%= current_user.getUserEmail() %>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <h6><b>Phone:</b></h6>
                        <p><%= current_user.getUserPhone() %>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <h6><b>Address:</b></h6>
                        <p><%= current_user.getUserAddress() %>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <h6><b>Role:</b></h6>
                        <p><%= current_user.getUserType() %>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-secondary">Back</a>
            <button class="btn btn-danger" data-toggle="modal"
                    data-target="#deleteModal<%= current_user.getUserId() %>">
                Delete Account
            </button>
        </div>
    </div>
</div>

<!-- Modal xác nhận xóa -->
<div class="modal fade" id="deleteModal<%= current_user.getUserId() %>" tabindex="-1" role="dialog"
     aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete your account "<b><%= current_user.getUserName() %>
            </b>"? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <form action="UserOperationServlet" method="post">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <input type="hidden" name="operation" value="deleteUser">
                    <input type="hidden" name="userId" value="<%= current_user.getUserId() %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
