package com.learn.mycart.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.learn.mycart.entities.User;
import org.hibernate.Transaction;

import java.util.List;

public class UserDao {

    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    //getuser by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        try {

            String query = "from User where userEmail=:e and userPassword=:p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);
            user = (User) q.uniqueResult();

            session.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> getAllUsers() {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from User");
        List<User> list = query.list();
        return list;

    }

    public boolean deleteUser(int userId) {
        boolean f = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            User user = session.get(User.class, userId);
            session.delete(user);
            tx.commit();
            session.close();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean checkEmail(String email) {
        boolean f = false;
        try {
            Session session = this.factory.openSession();
            String query = "from User where userEmail=:e";
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            User user = (User) q.uniqueResult();
            if (user != null) {
                f = true;
            }
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public User getUserById(int userId) {
        User user = null;
        try {
            Session session = this.factory.openSession();
            user = session.get(User.class, userId);
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

}
