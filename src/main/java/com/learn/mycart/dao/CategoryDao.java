package com.learn.mycart.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.learn.mycart.entities.Category;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    // save category to db
    public int saveCategory(Category cat) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (Integer) session.save(cat);
        tx.commit();
        session.close();
        return catId;
    }

    public List<Category> getCategories() {
        Session s = this.factory.openSession();
        Query<Category> query = s.createQuery("from Category");
        List<Category> list = query.list();
        return list;
    }

    public Category getCategoryById(int cid) {
        Category cat = null;
        try {
            Session session = this.factory.openSession();
            cat = session.get(Category.class, cid);
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }

    public int countProducts(int cid) {
        int count = 0;
        try {
            Session session = this.factory.openSession();
            Query query = session.createQuery("select count(p.Pid) from Product p where p.category.categoryId=:cId");
            query.setParameter("cId", cid);
            count = ((Long) query.uniqueResult()).intValue();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean deleteCategory(int cid) {
        boolean f = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            Category cat = session.get(Category.class, cid);
            session.delete(cat);
            tx.commit();
            session.close();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

}
