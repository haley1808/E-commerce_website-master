<%@page import="com.learn.mycart.helper.Helper" %>
<%@page import="com.learn.mycart.dao.ProductDao" %>
<%@page import="com.learn.mycart.helper.FactoryProvider" %>
<%@page import="java.util.List" %>
<%@page import="com.learn.mycart.entities.*" %>
<html>
<head>
    <title>Products</title>
    <%@include file="components/common_css_js.jsp" %>

</head>

<body>

<%@include file="components/navbar.jsp" %>
<%
//    String cat = request.getParameter("category");

    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
    List<Product> list = null;

//    if (cat == null || cat.trim().equals("all")) {
        list = dao.getAllProducts();
//    } else {
//        int cid = Integer.parseInt(cat.trim());
//        list = dao.getAllProductsById(cid);
    //}
%>

<div class="container mt-4">
    <h2 class="text-center">Products</h2>
    <div class="text-left mt-2" style="margin-bottom: 10px">
        <a href="admin.jsp" class="btn btn-secondary">Back</a>
    </div>
    <%@include file="components/message.jsp" %>
    <div class="row">
        <% for (Product p : list) { %>
        <div class="col-md-4">
            <div class="card mb-4">
                <img class="card-img-top m-2" src="img/products/<%= p.getpPhoto()%>" alt="<%= p.getpName() %>"
                     style="height: 200px; object-fit: contain; width: auto;">
                <div class="card-body">
                    <h5 class="card-title mb-1">
                        Name: <%= p.getpName() %>
                    </h5>
                    <p class="card-text mb-1">Description: <%= Helper.get10Words(p.getpDesc()) %>
                    </p>
                    <p class="card-text mb-1">Category: <%= p.getCategory().getCategoryTitle() %>
                    </p>
                    <p class="card-text mb-1">Quantity: <%= p.getpQuantity() %>
                    </p>

                    <% if (p.getpDiscount() > 0) { %>
                    <div class="d-flex align-items-center mb-1">
                        <h6 class="text-danger font-weight-bold mb-0">Price:
                            <%= p.getFormattedPriceAfterDiscount() %> &#8363;
                        </h6>
                        <h6 class="text-secondary font-weight-normal ml-2 mb-0">
                            <del><%= p.getFormattedPrice(p.getpPrice()) %> &#8363;</del>
                        </h6>
                    </div>
                    <p class="text-muted mb-1">Discount: <%= p.getpDiscount() %>%</p>
                    <% } else { %>
                    <h6 class="text-danger font-weight-bold mb-1">Price:
                        <%= p.getFormattedPrice(p.getpPrice()) %> &#8363;
                    </h6>
                    <p class="text-muted mb-1">Discount: <%= p.getpDiscount() %>%</p>
                    <% } %>

                    <button class="btn btn-danger mt-2" data-toggle="modal" data-target="#deleteModal<%= p.getPid() %>">
                        Delete
                    </button>
                </div>
            </div>
        </div>

        <!-- Modal xác nhận xóa -->
        <div class="modal fade" id="deleteModal<%= p.getPid() %>" tabindex="-1" role="dialog"
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
                        Do you want to delete "<b><%= p.getpName() %>
                    </b>" ?
                    </div>
                    <div class="modal-footer">
                        <form action="ProductOperationServlet" method="post">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <input type="hidden" name="operation" value="deleteProduct">
                            <input type="hidden" name="pid" value="<%= p.getPid() %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
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
