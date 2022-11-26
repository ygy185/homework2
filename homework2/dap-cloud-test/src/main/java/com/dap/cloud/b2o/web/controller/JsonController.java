package com.dap.cloud.b2o.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dap.cloud.b2o.web.vo.ResultVO;

@RestController
@RequestMapping(path = "/demo")
public class JsonController {

		

		@GetMapping(path = "/test")
		public ResultVO test() {
			ResultVO resultVO = new ResultVO();
			resultVO.setCode(0);
			resultVO.setMsg("成功");

			return resultVO;
		}
}
