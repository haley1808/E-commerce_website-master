package com.learn.mycart.servlets;

import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.dao.UserDao;
import com.learn.mycart.helper.FactoryProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
public class UserOperationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Constructor
    public UserOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String op = request.getParameter("operation");

        if (op.trim().equals("deleteUser")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            boolean success = userDao.deleteUser(userId);

            HttpSession httpsession = request.getSession();
            if (success) {
                httpsession.setAttribute("message", "User deleted successfully");
                httpsession.removeAttribute("current-user");
            } else {
                httpsession.setAttribute("message", "Failed to delete user");
            }
            response.sendRedirect("index.jsp");

        } else if (op.trim().equals("order")) {
            List<Integer> listId = new ArrayList<>();
            List<Integer> listQuantity = new ArrayList<>();
            String[] ids = request.getParameterValues("productId[]");
            String[] quantities = request.getParameterValues("productQuantity[]");
            if (ids != null) {
                for (String id : ids) {
                    listId.add(Integer.parseInt(id));
                }
            }
            if (quantities != null) {
                for (String quantity : quantities) {
                    listQuantity.add(Integer.parseInt(quantity));
                }
            }
            ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
            boolean success = productDao.updateProductQuantityByListId(listId, listQuantity);
            HttpSession httpsession = request.getSession();
            if (success) {
                httpsession.setAttribute("message", "Order placed successfully");
                httpsession.setAttribute("order", "success");
            } else {
                httpsession.setAttribute("message", "Failed to place order");
            }
            response.sendRedirect("order.jsp");

        } else {
            HttpSession httpsession = request.getSession();
            httpsession.setAttribute("message", "Invalid operation");
            response.sendRedirect("index.jsp");
        }
    }
}
