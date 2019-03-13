package com.vironit.airticketsbooking.springapp.controller;

import com.vironit.airticketsbooking.springapp.manager.PageManager;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class ExceptionHandlerController {

    @ExceptionHandler(value = Exception.class)
    public ModelAndView redirectToErrorPage(Exception e) {
        ModelAndView mav = new ModelAndView(PageManager.getPage("page.error"));
        return mav;
    }
}
