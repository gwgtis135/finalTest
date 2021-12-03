package co.micol.prj.emp.web;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import co.micol.prj.emp.mapper.EmployeeMapper;
import co.micol.prj.emp.vo.Departments;
import co.micol.prj.emp.vo.Employee;


@RestController
@CrossOrigin(origins = {"http://localhost:3000"}, maxAge = 3600)
public class EmployeeController {
	private static final Logger logger = 
			LoggerFactory.getLogger(EmployeeController.class);
	
	@Autowired
	private EmployeeMapper employeeDao;
	
	
	@RequestMapping(value="/employee/department")
	public Departments selectDepartment() {
		return employeeDao.selectDepartments().get(0);
	}	
	
	
	@RequestMapping(value="/employee/jobDeptList")
	public Map<String, Object> jobDeptList() {
		Map<String, Object> map = new HashMap<>();
		map.put("jobs", employeeDao.selectJobs());
		map.put("depts", employeeDao.selectDepartments());
		map.put("emps", employeeDao.selectEmployees());
		
		return map;		
	}	
	
	@RequestMapping(value="/employee/insertEmployees", method=RequestMethod.POST )
	public  Employee insertEmployees(Employee bean, HttpServletResponse response) {
		employeeDao.insertEmployees(bean);
		return bean;
	}	
	@RequestMapping(value="/employee/updateEmployees", method=RequestMethod.POST )
	public  Employee updateEmployees(Employee bean, HttpServletResponse response) {
		employeeDao.updateEmployees(bean);
		return bean;
	}	
	@RequestMapping(value="/employee/deleteEmployees", method=RequestMethod.POST )
	public  Employee deleteEmployees(Employee bean, HttpServletResponse response) {
		
		employeeDao.deleteEmployees(bean);
		return bean;
	}	
	
}
