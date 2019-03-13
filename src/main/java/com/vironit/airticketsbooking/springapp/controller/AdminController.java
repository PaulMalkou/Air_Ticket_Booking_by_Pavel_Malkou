package com.vironit.airticketsbooking.springapp.controller;

import com.vironit.airticketsbooking.springapp.entity.Order;
import com.vironit.airticketsbooking.springapp.entity.User;
import com.vironit.airticketsbooking.springapp.manager.PageManager;
import com.vironit.airticketsbooking.springapp.service.OrderService;
import com.vironit.airticketsbooking.springapp.service.UserService;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class AdminController {
    private final static Logger LOGGER = LogManager.getLogger(AdminController.class);
    private OrderService orderService;
    private UserService userService;

    @Autowired
    public AdminController(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    @PostMapping(value = "/manageOrders")
    public ModelAndView manageOrders( @RequestParam(value = "userIdToShowOrders")Long userId, HttpServletRequest request) {
        List<Order> orders;
        if (userId != null) {
            orders = orderService.findOrdersByUserId(userId);
            User userToShowOrders = userService.findUserById(userId);
            request.getSession().setAttribute("userToShowOrders", userToShowOrders);
        } else {
            orders = orderService.findAllOrders();
            List<User> usersWithOrders = userService.findUsersWithOrder();
            request.getSession().setAttribute("usersWithOrders", usersWithOrders);
        }
        request.getSession().setAttribute("orders", orders);
        return new ModelAndView(PageManager.getPage("page.manage_orders"));
    }

    @PostMapping(value = "/manageUsers")
    public ModelAndView manageUsers(HttpServletRequest request) {
        List<User> users = userService.findAllUsers();
        request.getSession().setAttribute("users", users);
        return new ModelAndView(PageManager.getPage("page.manage_users"));
    }

    @PostMapping(value = "/removeUser")
    public ModelAndView removeUser(@RequestParam("userToDeleteId") long idUser, HttpServletRequest request) {
        userService.deleteUser(userService.findUserById(idUser));
        List<User> users = userService.findAllUsers();
        request.getSession().setAttribute("users", users);
        LOGGER.log(Level.INFO, "User with ID " + idUser + " is removed");
        return new ModelAndView(PageManager.getPage("page.manage_users"));
    }

}
