package com.vironit.airticketsbooking.springapp.controller;

import com.vironit.airticketsbooking.springapp.config.AirTicketBookingMvcConfig;
import com.vironit.airticketsbooking.springapp.config.AirTicketBookingSecurityConfig;
import com.vironit.airticketsbooking.springapp.manager.PageManager;
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
public class UserControllerTest {
    private MockMvc mockMvc;
    @Autowired
    UserController userController;
    @Autowired
    UserService userService;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.standaloneSetup(userController).build();
    }

    @Test
    public void registrationTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/registration")
                                                                      .param("email","test@test.test")
                                                                      .param("password","Test10")
                                                                      .param("confirmed_password","Test10")
                                                                      .param("name","Test")
                                                                      .param("surname","Test")
                                                                      .param("passport_number","TEST10TE")
                                                                      .param("dob","2018-12-22")
                                                                      .param("sex","F")
                                                                      .param("phone_number","+000(00)000-00-00")
                                                                      .param("balance","0");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.login"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void logoutTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.get("/logout")
                                                                      .sessionAttr("user", userService.findUserByEmail("test@test.test"));
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.login"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void changeProfileTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/changeProfile")
                                                                      .param("password","Test100")
                                                                      .param("confirmed_password","Test100")
                                                                      .param("name","TestUpdated")
                                                                      .param("surname","TestUpdated")
                                                                      .param("dob","2001-01-01")
                                                                      .sessionAttr("user", userService.findUserByEmail("test@test.test"));
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.user"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void showUserOrdersTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/showUserOrders")
                                                                      .sessionAttr("user", userService.findUserByEmail("test@test.test"));
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.user_orders"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void addMoneyTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/addMoney")
                                                                      .param("moneyAmount", "500")
                                                                      .sessionAttr("user", userService.findUserByEmail("test@test.test"));
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.pay_order"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }
}
