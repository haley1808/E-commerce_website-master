<%@page import="com.learn.mycart.helper.Helper" %>
<%@page import="com.learn.mycart.dao.CategoryDao" %>
<%@page import="com.learn.mycart.helper.FactoryProvider" %>
<%@page import="java.util.List" %>
<%@page import="com.learn.mycart.entities.*" %>
<html>
<head>
    <title>Categories</title>
    <%@include file="components/common_css_js.jsp" %>

</head>

<body>

<%@include file="components/navbar.jsp" %>
<%

    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> clist = cdao.getCategories();
%>

<div class="container mt-4">
    <h2 class="text-center">Categories</h2>
    <div class="text-left mt-2" style="margin-bottom: 10px">
        <a href="admin.jsp" class="btn btn-secondary">Back</a>
    </div>
    <%@include file="components/message.jsp" %>
    <div class="row">
        <% for (Category c : clist) { %>
        <% int totalProducts = cdao.countProducts(c.getCategoryId()); %>
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title mb-1">Name: <%= c.getCategoryTitle() %>
                    </h5>
                    <p class="card-text mb-1">Description: <%= Helper.get10Words(c.getCategoryDescriptioin()) %>
                    </p>
                    <p class="card-text mb-1">Product count: <%= totalProducts %>
                    </p>

                    <button class="btn btn-danger mt-2" data-toggle="modal"
                            data-target="#deleteModal<%= c.getCategoryId() %>">
                        Delete
                    </button>
                </div>
            </div>
        </div>

        <!-- Modal xác nhận xóa -->
        <div class="modal fade" id="deleteModal<%= c.getCategoryId() %>" tabindex="-1" role="dialog"
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
                        <% if (totalProducts > 0) { %>
                        <p class="text-danger">Note: This category has <b><%= totalProducts %>
                        </b> products. You need to delete all products in this category before deleting the category.
                        </p>
                        <% } else { %>
                        Are you sure you want to delete "<b><%= c.getCategoryTitle() %>
                    </b>" ?
                        <% } %>
                    </div>
                    <div class="modal-footer">
                        <form action="ProductOperationServlet" method="post">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <input type="hidden" name="operation" value="deleteCategory">
                            <input type="hidden" name="cid" value="<%= c.getCategoryId() %>">
                            <% if (totalProducts == 0) { %>
                            <button type="submit" class="btn btn-danger">Delete</button>
                            <% } %>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
<%@include file="components/common_modals.jsp" %>

</body>
</html>
