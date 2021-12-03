package co.micol.prj.emp.mapper;

import java.util.List;

import co.micol.prj.emp.vo.Departments;
import co.micol.prj.emp.vo.Employee;
import co.micol.prj.emp.vo.Jobs;

public interface EmployeeMapper {

	List<Employee> selectEmployees();
	List<Jobs> selectJobs();
	List<Departments> selectDepartments();
	
	int insertEmployees(Employee emp);
	int updateEmployees(Employee emp);
	int deleteEmployees(Employee emp);
}
