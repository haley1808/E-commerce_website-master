package com.learn.mycart.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.learn.mycart.entities.Product;

public class ProductDao {

    private SessionFactory factory;


    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }


    public boolean saveProduct(Product product) {
        boolean f = false;

        try {

            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.save(product);
            f = true;


            tx.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }
        return f;
    }


    //get all products


    public List<Product> getAllProducts() {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product");
        List<Product> list = query.list();
        return list;

    }

    //get all products of given category
    public List<Product> getAllProductsById(int cid) {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product as p where p.category.categoryId=:id");
        query.setParameter("id", cid);
        List<Product> list = query.list();
        return list;

    }

    public boolean deleteProduct(int productId) {
        boolean deleted = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            Product product = session.get(Product.class, productId);
            if (product != null) {
                session.delete(product);
                deleted = true;
            }

            tx.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deleted;
    }

    public boolean updateProductQuantityByListId(List<Integer> listId, List<Integer> quantity) {
        boolean updated = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            for (int i = 0; i < listId.size(); i++) {
                Product product = session.get(Product.class, listId.get(i));
                if (product != null) {
                    product.setpQuantity(product.getpQuantity() - quantity.get(i));
                }
            }

            tx.commit();
            session.close();
            updated = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }

}

