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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class UserController {
    private final static Logger LOGGER = LogManager.getLogger(UserController.class);
    private OrderService orderService;
    private UserService userService;

    @Autowired
    public UserController(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    public UserController() {}

    @PostMapping(value = "/registration")
    public ModelAndView registration(@RequestParam(value = "email") String email,
                                     @RequestParam(value = "password") String password,
                                     @RequestParam(value = "confirmed_password") String confirmedPassword,
                                     @RequestParam(value = "name") String name,
                                     @RequestParam(value = "surname") String surname,
                                     @RequestParam(value = "passport_number") String passport_number,
                                     @RequestParam(value = "dob") Date dob,
                                     @RequestParam(value = "sex") String sex,
                                     @RequestParam(value = "phone_number") String phone_number,
                                     @RequestParam(value = "balance") Double balance,
                                     HttpServletRequest request)
    {
        if (!password.equals(confirmedPassword)) {
            request.setAttribute("confirmPasswordIncorrect", true);
            return new ModelAndView(PageManager.getPage("page.registration"));
        }
        List<User> allUsers = userService.findAllUsers();
        for (User currentUser : allUsers) {
            if(currentUser.getEmail().equals(email)){
                request.setAttribute("loginAlreadyExist", true);
                return new ModelAndView(PageManager.getPage("page.registration"));
            }
            if(currentUser.getPassport_number().equals(passport_number)){
                request.setAttribute("passportNumberAlreadyExist", true);
                return new ModelAndView(PageManager.getPage("page.registration"));
            }
            if(currentUser.getPhone_number().equals(phone_number)){
                request.setAttribute("phoneNumberAlreadyExist", true);
                return new ModelAndView(PageManager.getPage("page.registration"));
            }
        }
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodingPassword = passwordEncoder.encode(password);
        User user = new User(email, encodingPassword, name, surname, passport_number, dob, sex, phone_number, User.Role.USER, balance);
        userService.addUser(user);
        LOGGER.log(Level.INFO, "User with login: " + user.getEmail() + " is registered now");
        return new ModelAndView(PageManager.getPage("page.login"));
    }

    @GetMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        String page = PageManager.getPage("page.login");
        LOGGER.log(Level.INFO,user.getEmail() +" logout");
        return page;
    }

    @PostMapping(value = "/changeProfile")
    public ModelAndView changeProfile(@RequestParam(value = "password") String passwordValue,
                                      @RequestParam(value = "confirmed_password") String confirmedPasswordValue,
                                      @RequestParam(value = "name") String nameValue,
                                      @RequestParam(value = "surname") String surnameValue,
                                      @RequestParam(value = "dob") String dobValue,
                                      HttpServletRequest request)
    {
        User user = (User) request.getSession().getAttribute("user");
        if (!passwordValue.equals(confirmedPasswordValue)) {
            request.getSession().setAttribute("confirmPasswordIncorrect", true);
            return new ModelAndView(PageManager.getPage("page.change_profile"));
        }
        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodingPassword = passwordEncoder.encode(passwordValue);
        Date dob = Date.valueOf(dobValue);
        userService.updateUserProfile(user.getId(), encodingPassword, nameValue, surnameValue, dob);
        User updatedUser = userService.findUserById(user.getId());
        request.getSession().setAttribute("user", updatedUser);
        LOGGER.log(Level.INFO, nameValue + " " + surnameValue + " updated personal profile");
        return new ModelAndView(PageManager.getPage("page.user"));
    }

    @PostMapping(value = "/showUserOrders")
    public ModelAndView showUserOrders(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        List<Order> orders = orderService.findOrdersByUserId(user.getId());
        List<Order> activeOrders = orders.stream()
                                         .filter(order -> order.getOrder_status() == Order.Status.ACTIVE)
                                         .collect(Collectors.toList());
        List<Order> cancelledOrders = orders.stream()
                                            .filter(order -> order.getOrder_status() == Order.Status.CANCELLED)
                                            .collect(Collectors.toList());
        List<Order> finishedOrders = orders.stream()
                                            .filter(order -> order.getOrder_status() == Order.Status.FINISHED)
                                            .collect(Collectors.toList());
        request.getSession().setAttribute("orders", orders);
        request.getSession().setAttribute("activeOrders", activeOrders);
        request.getSession().setAttribute("cancelledOrders", cancelledOrders);
        request.getSession().setAttribute("finishedOrders", finishedOrders);
        return new ModelAndView(PageManager.getPage("page.user_orders"));
    }

    @PostMapping(value = "/addMoney")
    public ModelAndView addMoney(@RequestParam(value = "moneyAmount")double moneyAmountValue,
                                 HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("user");
        userService.addMoney(user, moneyAmountValue);
        User updatedUser = userService.findUserById(user.getId());
        request.getSession().setAttribute("user", updatedUser);
        LOGGER.log(Level.INFO, "User with login " + user.getEmail() + " recharged balance by " + moneyAmountValue + " BYN");
        return new ModelAndView(PageManager.getPage("page.pay_order"));
    }

    @GetMapping(value = "/login")
    public String showLoginPage() { return  PageManager.getPage("page.login"); }
    @GetMapping(value = "/registration")
    public String showRegistrationPage() {
        return PageManager.getPage("page.registration");
    }
    @GetMapping(value = "/access_denied")
    public String accessDeniedPage() {
        return PageManager.getPage("page.access_denied");
    }
    @GetMapping(value = "/user/user_profile")
    public String userPage() { return PageManager.getPage("page.user");}
    @GetMapping(value = "/admin/admin_profile")
    public String adminPage() { return PageManager.getPage("page.admin");}
}
