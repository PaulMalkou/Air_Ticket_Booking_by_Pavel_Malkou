package com.vironit.airticketsbooking.springapp.service;

import com.vironit.airticketsbooking.springapp.dao.impl.UserDAO;
import com.vironit.airticketsbooking.springapp.entity.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.List;
@Transactional
@Service
public class UserService {
    private UserDAO dao;
    @Autowired
    public UserService(UserDAO dao) {
        this.dao = dao;
    }

    public void addUser(User user) {
        dao.create(user);
    }

    public List<User> findAllUsers() {
        List<User> users = dao.findAll(User.class);
        return users;
    }

    public User findUserById(Long id) {
        User user = dao.findById(id, User.class);
        return user;
    }

    public User findUserByEmail(String email) {
        User user = dao.findUserByEmail(email);
        return user;
    }

    public List<User> findUsersWithOrder() {
        List<User> users = dao.findAll(User.class);
        return users;
    }

    public User checkUser(String login, String password) {
        User user = dao.findUserByEmailAndPassword(login, password);
        return user;
    }

    public void updateUserProfile(long id, String password, String name, String surname, Date dob) {
        dao.updateUserProfile(id, password, name, surname, dob);
    }

    public boolean checkBalance(User user, double fare) {
        double balance = user.getBalance();
        return balance >= fare;
    }

    public void addMoney(User user, double amount) {
        double balance = user.getBalance();
        balance+=amount;
        dao.updateBalance(user, balance);
    }

    public void withdrawnMoney(User user, double amount) {
        double balance = user.getBalance();
        balance-=amount;
        dao.updateBalance(user, balance);
    }

    public void deleteUser(User user) {
        dao.delete(user);
    }

}
