package com.dap.cloud.b2o.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dap.cloud.b2o.web.vo.CoffeeVo;

@Controller
@RequestMapping("/demo")
public class XMLController {
	@RequestMapping(value = "test2", method = RequestMethod.GET)
	public @ResponseBody CoffeeVo getCoffeeInXML() {
		CoffeeVo coffee = new CoffeeVo("coffee", 100);
		return coffee;
	}
}