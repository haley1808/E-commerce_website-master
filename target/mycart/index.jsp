<%@page import="com.learn.mycart.helper.Helper" %>
<%@page import="com.learn.mycart.dao.CategoryDao" %>
<%@page import="com.learn.mycart.dao.ProductDao" %>
<%@page import="com.learn.mycart.helper.FactoryProvider" %>
<%@page import="java.util.List" %>
<%@page import="com.learn.mycart.entities.*" %>
<html>
<head>
    <title>Mycart: Home</title>
    <%@include file="components/common_css_js.jsp" %>

</head>
<body>
<%@include file="components/navbar.jsp" %>

<%
    String cat = request.getParameter("category");

    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
    List<Product> list = null;

    if (cat == null || cat.trim().equals("all")) {
        list = dao.getAllProducts();
    } else {
        int cid = Integer.parseInt(cat.trim());
        list = dao.getAllProductsById(cid);
    }

    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> clist = cdao.getCategories();
%>

<div class="row ml-2" style="margin-right: 0">
    <!-- show categories -->
    <div class="col-md-2">
        <div class="list-group mt-4">
            <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                All Products</a>
            <%for (Category c : clist) {%>
            <a href="index.jsp?category=<%=c.getCategoryId() %>"
               class="list-group-item list-group-item-action"><%=c.getCategoryTitle()%>
            </a>
            <%}%>
        </div>
    </div>
    <!-- //show products -->
    <div class="col-md-10">
        <!-- row -->
        <div class="row mt-4">
            <div class="col-md-12">
                <%@include file="components/message.jsp" %>
                <div class="row">
                    <% for (Product p : list) { %>
                    <div class="col-md-4 mb-4"> <!-- card -->
                        <div class="card">
                            <div class="container text-center">
                                <img alt="..."
                                     src="img/products/<%= p.getpPhoto()%>" class="card-img-top m-2"
                                     style="height: 200px; object-fit: cover; width: auto;">
                            </div>
                            <div class="card-body">
                                <h5 class="card-title ml-2">Name: <%=p.getpName() %>
                                </h5>
                                <p class="card-title ml-2">Description: <%=Helper.get10Words(p.getpDesc()) %>
                                </p>
                                <p class="card-title ml-2">Category: <%= p.getCategory().getCategoryTitle() %>
                                </p>
                                <p class="card-title ml-2">Discount: <%= p.getpDiscount() %>%</p>
                            </div>

                            <div class="card-footer text-center">
                                <button class="btn custom-bg text-white"
                                        onclick="add_to_cart(<%=p.getPid() %>,'<%=p.getpName() %>','<%=p.getPriceAfterApplyDiscount() %>','<%=p.getpQuantity() %>')">
                                    Add to Cart
                                </button>
                                <% if (p.getpDiscount() > 0) { %>
                                <button class="btn btn-outline-success">
                                    <%= p.getFormattedPriceAfterDiscount() %> &#8363;
                                    <span class="text-secondary discount-label">
                                <%= p.getFormattedPrice(p.getpPrice()) %> &#8363;
                                    </span>
                                </button>
                                <% } else { %>
                                <button class="btn btn-outline-success">
                                    <%= p.getFormattedPrice(p.getpPrice()) %> &#8363;
                                </button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="components/common_modals.jsp" %>

</body>
</html>
