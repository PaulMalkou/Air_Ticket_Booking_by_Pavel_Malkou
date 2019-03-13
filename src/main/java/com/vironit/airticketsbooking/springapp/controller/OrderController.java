package com.vironit.airticketsbooking.springapp.controller;

import com.vironit.airticketsbooking.springapp.entity.*;
import com.vironit.airticketsbooking.springapp.manager.PageManager;
import com.vironit.airticketsbooking.springapp.service.*;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Random;

@Controller
public class OrderController {
    private final static Logger LOGGER = LogManager.getLogger(OrderController.class);
    private OrderService orderService;
    private UserService userService;
    private AirportService airportService;
    private AirlineService airlineService;
    private FlightDetailsService flightDetailsService;

    @Autowired
    public OrderController(OrderService orderService, UserService userService, AirportService airportService, AirlineService airlineService, FlightDetailsService flightDetailsService) {
        this.orderService = orderService;
        this.userService = userService;
        this.airportService = airportService;
        this.airlineService = airlineService;
        this.flightDetailsService = flightDetailsService;
    }

    @GetMapping(value = "/addDropDownLists")
    public ModelAndView addDropDownLists(HttpServletRequest request){
        String page = PageManager.getPage("page.place_order");
        List<Airport> listAirports = airportService.findAllAirports();
        request.getSession().setAttribute("listAirports", listAirports);
        List<Airline> listAirlines = airlineService.findAllAirlines();
        request.getSession().setAttribute("listAirlines", listAirlines);
        return new ModelAndView(page);
    }

    @PostMapping(value = "/placeOrder")
    public ModelAndView placeOrder(@RequestParam("number_passengers") int numberPassengersValue,
                                   @RequestParam("departureAirport") long departureAirportIdValue,
                                   @RequestParam("arrivalAirport") long arrivalAirportIdValue,
                                   @RequestParam("airline") long airlineIdValue,
                                   HttpServletRequest request) {
        if (departureAirportIdValue == arrivalAirportIdValue) {
            request.setAttribute("airportSelectIncorrect", true);
            return new ModelAndView(PageManager.getPage("page.place_order"));
        }
        User user = (User) request.getSession().getAttribute("user");
        double fare = setRandomFare();
        Double howMuchMoneyNotEnough = fare - user.getBalance();
        request.getSession().setAttribute("howMuchMoneyNotEnough", howMuchMoneyNotEnough);

        Airport departureAirport = airportService.findAirportById(departureAirportIdValue);
        Airport arrivalAirport = airportService.findAirportById(arrivalAirportIdValue);
        Airline airline = airlineService.findAirlineById(airlineIdValue);
        FlightDetails flightDetails = flightDetailsService.findFlightDetailsById(getFlightDetailsID());
        Order order = new Order(user, numberPassengersValue, departureAirport, arrivalAirport, airline, flightDetails, fare, false, Order.Status.ACTIVE);
        orderService.createOrder(order);
        request.getSession().setAttribute("order", order);
        LOGGER.log(Level.INFO, "Order for " + user.getEmail() + " is placed");
        return new ModelAndView(PageManager.getPage("page.pay_order"));
    }

    @PostMapping(value = "/payOrder")
    public ModelAndView payOrder(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Order order = (Order) request.getSession().getAttribute("order");
        if(order == null) {
            request.setAttribute("orderIsPaidAlready", true);
            return new ModelAndView(PageManager.getPage("page.pay_order"));
        }
        double fare = order.getFare();
        if (!userService.checkBalance(user, fare)) {
            request.setAttribute("messageNotEnoughMoney", true);
            return new ModelAndView(PageManager.getPage("page.pay_order"));
        }
        userService.withdrawnMoney(user, fare);
        orderService.pickUpOrder(order.getId());
        request.setAttribute("messageMoneyWithdrawn", true);
        User updatedUser = userService.findUserById(user.getId());
        request.getSession().setAttribute("user", updatedUser);
        request.getSession().removeAttribute("order");
        LOGGER.log(Level.INFO, "Order with ID: " + order.getId() + " is paid successfully");
        return new ModelAndView(PageManager.getPage("page.pay_order"));
    }

    @GetMapping(value = "/cancelOrderAdmin")
    public ModelAndView cancelOrderAdmin(@RequestParam("id_order")long idOrderValue, HttpServletRequest request) {
        String page = PageManager.getPage("page.manage_orders");
        User currentUser = (User) request.getSession().getAttribute("userToShowOrders");
        List<Order> orders = (List<Order>) request.getSession().getAttribute("orders");
        Order order = getCurrentOrder(orders, idOrderValue);
        orderService.cancelOrder(order.getId());
        List<Order> listOrdersUpdated = orderService.findOrdersByUserId(currentUser.getId());
        request.getSession().setAttribute("orders", listOrdersUpdated);
        request.setAttribute("messageOrderCancelled", true);
        LOGGER.log(Level.INFO, "Order with ID: " + order.getId() + " is cancelled");
        return new ModelAndView(page);
    }

    @GetMapping(value = "/finishOrder")
    public ModelAndView finishOrder( @RequestParam("id_order")long idOrderValue, HttpServletRequest request){
        String page = PageManager.getPage("page.manage_orders");
        User currentUser = (User) request.getSession().getAttribute("userToShowOrders");
        List<Order> orders = (List<Order>) request.getSession().getAttribute("orders");
        Order order = getCurrentOrder(orders, idOrderValue);
        orderService.finishOrder(order.getId());
        List<Order> updatedUserOrders = orderService.findOrdersByUserId(currentUser.getId());
        request.getSession().setAttribute("orders", updatedUserOrders);
        request.getSession().setAttribute("messageOrderFinished", true);
        LOGGER.log(Level.INFO, "Order with ID: " + order.getId() + " is finished");
        return new ModelAndView(page);
    }

    @GetMapping(value = "/cancelOrderUser")
    public ModelAndView cancelOrderUser(@RequestParam("id_order")long idOrderValue, HttpServletRequest request) {
        String page = PageManager.getPage("page.user_orders");
        User user = (User) request.getSession().getAttribute("user");
        List<Order> orders = (List<Order>) request.getSession().getAttribute("orders");
        Order order = getCurrentOrder(orders, idOrderValue);
        orderService.cancelOrder(order.getId());
        List<Order> activeOrdersUpdated = orderService.findAllUserActiveOrders(user.getId());
        List<Order> cancelledOrdersUpdated = orderService.findAllUserCancelledOrders(user.getId());
        request.getSession().setAttribute("activeOrders", activeOrdersUpdated);
        request.getSession().setAttribute("cancelledOrders", cancelledOrdersUpdated);
        request.setAttribute("messageOrderCancelled", true);
        LOGGER.log(Level.INFO, "Order with ID: " + order.getId() + " is cancelled");
        return new ModelAndView(page);
    }

    private Order getCurrentOrder(List<Order> orders, long idOrderValue){
        Order order = orders.stream()
                            .filter(o -> o.getId() == idOrderValue)
                            .findAny()
                            .orElse(null);
        return order;
    }

    private double setRandomFare() {
        Random random = new Random();
        int fare = random.nextInt(500) + 50;
        return fare;
    }

    private long getFlightDetailsID() {
        long idFlightDetails =  new Random().nextInt(5) + 1;
        return idFlightDetails;
    }
}
