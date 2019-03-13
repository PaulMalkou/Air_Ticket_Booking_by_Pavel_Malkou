package com.vironit.airticketsbooking.springapp.controller;

import com.vironit.airticketsbooking.springapp.config.AirTicketBookingMvcConfig;
import com.vironit.airticketsbooking.springapp.config.AirTicketBookingSecurityConfig;
import com.vironit.airticketsbooking.springapp.manager.PageManager;
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
public class AdminControllerTest {
    private MockMvc mockMvc;
    @Autowired
    AdminController adminController;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();
    }

    @Test
    public void manageOrdersTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/manageOrders")
                                                                      .param("userIdToShowOrders", "100");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.manage_orders"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void manageUsersTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/manageUsers");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.manage_users"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }

    @Test
    public void removeUserTest() throws Exception {
        MockHttpServletRequestBuilder request = MockMvcRequestBuilders.post("/removeUser")
                                                                      .param("userToDeleteId", "100");
        ResultMatcher ok = MockMvcResultMatchers.status().isOk();
        ResultMatcher viewName = MockMvcResultMatchers.forwardedUrl(PageManager.getPage("page.manage_users"));
        mockMvc.perform(request)
                .andExpect(ok)
                .andExpect(viewName);
    }


}
