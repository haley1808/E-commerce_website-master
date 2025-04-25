<%

    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
<div class="alert alert-warning alert-dismissible fade show" role="alert" id="alertMessage">
    <%=message %>
    <%--  <button type="button" class="close" data-dismiss="alert" aria-label="Close">--%>
    <%--    <span aria-hidden="true">&times;</span>--%>
    <%--  </button>--%>
</div>


<%
        session.removeAttribute("message");

    }
%>
<script>
    // Tự động ẩn thông báo sau 2 giây (2000ms)
    setTimeout(function () {
        let alertElement = document.getElementById("alertMessage");
        if (alertElement) {
            alertElement.style.display = "none";
        }
    }, 2000);
</script>