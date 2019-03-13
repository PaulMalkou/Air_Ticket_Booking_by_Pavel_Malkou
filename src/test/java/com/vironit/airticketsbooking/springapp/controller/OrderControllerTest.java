package com.vironit.airticketsbooking.springapp.controller;

import com.vironit.airticketsbooking.springapp.config.AirTicketBookingMvcConfig;
import com.vironit.airticketsbooking.springapp.config.AirTicketBookingSecurityConfig;
import com.vironit.airticketsbooking.springapp.manager.PageManager;
import com.vironit.airticketsbooking.springapp.service.OrderService;
import com.vironit.airticketsbooking.springapp.service.UserService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {AirTicketBookingMvcConfig.class, AirTicketBookingSecurityConfig.class})
@WebAppConfiguration
public class OrderControllerTest {
    private MockMvc mockMvc;
    @Autowired
    OrderController orderController;
    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.standaloneSetup(orderController).build();
    }

    @Test
    public void addDropDownListsTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.get("/addDropDownLists");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.place_order"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void placeOrderTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/placeOrder")
                                                                      .param("number_passengers", "3")
                                                                      .param("departureAirport", "10")
                                                                      .param("arrivalAirport", "2")
                                                                      .param("airline", "7")
                                                                      .sessionAttr("user", userService.findUserByEmail("test@test.test"));
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.pay_order"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void payOrderTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/payOrder")
                                                                      .sessionAttr("user", userService.findUserByEmail("test@test.test"))
                                                                      .sessionAttr("order", orderService.findOrderById(101));
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.pay_order"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void cancelOrderAdminTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.get("/cancelOrderAdmin")
                                                                      .sessionAttr("userToShowOrders", userService.findUserByEmail("test@test.test"))
                                                                      .sessionAttr("orders", orderService.findOrdersByUserEmail("test@test.test"))
                                                                      .param("id_order", "101");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.manage_orders"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void finishOrderTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.get("/finishOrder")
                                                                      .sessionAttr("userToShowOrders", userService.findUserByEmail("test@test.test"))
                                                                      .sessionAttr("orders", orderService.findOrdersByUserEmail("test@test.test"))
                                                                      .param("id_order", "101");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.manage_orders"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void cancelOrderUserTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.get("/cancelOrderUser")
                                                                      .sessionAttr("user", userService.findUserByEmail("test@test.test"))
                                                                      .sessionAttr("orders", orderService.findOrdersByUserEmail("test@test.test"))
                                                                      .param("id_order", "101");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.user_orders"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

}
