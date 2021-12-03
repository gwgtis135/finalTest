<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>RESTful 웹서비스 클라이언트(JSON)</title>
<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
</script>
    <script src="https://unpkg.com/vue@next"></script>

</head>
<body>
<div id="app">
	<div class="container">
		<form id="form1" class="form-horizontal">
			<h2>사용자 등록 및 수정</h2>
			<div class="form-group">
				<label>아이디:</label> <input type="text" class="form-control" v-model="id" :disabled="ableId"
					name="id">
			</div>
			<div class="form-group">
				<label>이름:</label> <input type="text" class="form-control" v-model="name"
					name="name">
			</div>
			<div class="form-group">
				<label>패스워드:</label> <input type="text" class="form-control" v-model="password"
					name="password">
			</div>
			<div class="form-group">
				<label>역할:</label> <select class="form-control" name="role" v-model="role">
					<option value="Admin">관리자</option>
					<option value="User">사용자</option>
				</select>
			</div>
			<div class="btn-group">
				<input type="button" class="btn btn-primary" value="등록" @click="insertMember"
					id="btnInsert" /> <input type="button" class="btn btn-primary" @click="updateMember(indexMember)"
					value="수정" id="btnUpdate"/> <input type="button"
					class="btn btn-primary" value="초기화" id="btnInit" />
			</div>
		</form>
	</div>
	<hr />
	<div class="container">
		<h2>사용자 목록</h2>
		<table class="table text-center">
			<thead>
				<tr>
					<th class="text-center">아이디</th>
					<th class="text-center">이름</th>
					<th class="text-center">패스워드</th>
					<th class="text-center">역할</th>
					<th class="text-center">조회/삭제</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="(member,index) in members" :key="member.id">
					<td class="text-center" v-for="emp in member" >{{emp}}</td>
					<td class="text-center" ><button @click="selectMember(index)">조회</button><button @click="deleteMember(index)">삭제</button> </td>
	</tr>

			</tbody>
		</table>
	</div>
</div>
	<script>
	
	const mountedApp = Vue.createApp({
		data(){
			return{
				members:[],
				id:'',
				password:'',
				name:'',
				role:'',
				ableId:false,
				indexMember:''
			}
		},
		methods:{
			selectMember(index){				
				fetch("users?id="+this.members[index].id)
				.then(response=>response.json())
				.then(result=>{this.id=result.id;this.password=result.password;this.name=result.name;this.role=result.role;
				this.ableId=true;
				this.indexMember=index
				})
			},
			deleteMember(index){
				fetch("deleteUser?id="+this.members[index].id)
				.then(response=>response.json())
				.then(result=>{
					this.members.splice(index,1)
				})
			},
			insertMember(){
				fetch("insertUser",{method:"POST",headers:{'Content-Type': 'application/x-www-form-urlencoded',
			    },
			    body : "id="+this.id+"&name="+this.name+"&password="+this.password+"&role="+this.role
			    	}).then(response=>response.json())
			    	.then(result=>{
			    		this.members.push({id:result.id,name:result.name,password:result.password,role:result.role}
			    		)
			    	})
			},
			updateMember(index){
				fetch("updateUser",{method:"POST",headers:{'Content-Type': 'application/x-www-form-urlencoded',
			    },
			    body : "id="+this.id+"&name="+this.name+"&password="+this.password+"&role="+this.role
			    	}).then(response=>response.json())
			    	.then(result=>{
			    		console.log(index)
			    		this.members[index].id= result.id;
			    		this.members[index].name= result.name;
			    		this.members[index].password= result.password;
			    		this.members[index].role= result.role;
				
				
				this.ableId=false
			    	})
			}
		},
		computed:{
			
		},
		mounted(){
			fetch("userList")
			.then(response=>response.json())
			.then(result=>{
				for(rs of result){
			
				this.members.push({id: rs.id, name:rs.name, password:rs.password, role:rs.role})
				}
			})
		}
	}).mount("#app")
	
	
	
	
		/* document.getElementById("btnInsert").addEventListener("click",InsertUser)
		document.getElementById("btnUpdate").addEventListener("click",UpdateUser)
		document.getElementsByName("id")[0].addEventListener("keyup",HideInsert)
		
		
		function HideInsert(){
			document.querySelector("#btnUpdate").style.display="none"
		}
	function UpdateUser(){
			var id = document.querySelector("[name='id']").value;
			var password = document.querySelector("[name='password']").value;
			var name = document.querySelector("[name='name']").value;
			var role = document.querySelector("[name='role']").value;
			fetch("updateUser",{method:"POST",headers:{'Content-Type': 'application/x-www-form-urlencoded',
		    },
		    body : "id="+id+"&name="+name+"&password="+password+"&role="+role
		    	}).then(response=>response.json())
		    	.then(result=>{
		    		document.querySelector("[id='"+id+"']").closest("tr").children[1].innerText=password;
		    		document.querySelector("[id='"+id+"']").closest("tr").children[2].innerText=name;
		    		document.querySelector("[id='"+id+"']").closest("tr").children[3].innerText=role;
		    		console.log(document.querySelector("[id='"+id+"']"))
		    
		    		document.querySelector("[name='id']").removeAttribute("readonly")
					
		    	})
		}
	
	function UpdUser(){
			var root= event.target.closest("tr")
			fetch("users?id="+root.firstElementChild.innerText).then(response=>response.json())
			.then(result=>{
				document.querySelector("[name='id']").value=result.id
				document.querySelector("[name='password']").value=result.password
				document.querySelector("[name='name']").value=result.name
				document.querySelector("[name='role']").value=result.role
				document.querySelector("#btnUpdate").style.display=""
					document.querySelector("[name='id']").setAttribute("readonly",true)
				
				
			})
	}
	function DelUser(){
	var root = event.target.closest("tr")
	console.log( event.target.closest("tr").firstElementChild)
	fetch("deleteUser?id="+root.firstElementChild.innerText)
	.then(response=>response.json()).then(result=>{
		root.remove();
	})
		}
	
	
	function InsertUser(){
			var id = document.querySelector("[name='id']").value;
			var password = document.querySelector("[name='password']").value;
			var name = document.querySelector("[name='name']").value;
			var role = document.querySelector("[name='role']").value;
			console.log(id,password,name,role)
			
			fetch("insertUser",{method:"POST",headers:{'Content-Type': 'application/x-www-form-urlencoded',
		    },
		    body : "id="+id+"&name="+name+"&password="+password+"&role="+role
		    	//`id=${id}&name=${name}&password=${password}&role=${document.querySelector("[name='role']").value}`		    
	}).then(response=>response.json())
	.then(result=>{
		console.log(result)
		var newRow = document.querySelector(".table").insertRow();
		var newId= newRow.insertCell(0);
		var newPassword= newRow.insertCell(1);
		var newName= newRow.insertCell(2);
		var newRole= newRow.insertCell(3);
		var newLine = newRow.insertCell(4);
		var newButton = document.createElement("button")
		var newButton2 = document.createElement("button")
		newButton.innerText="조회"
		newButton2.innerText="삭제"
		newButton.classList.add("btnUpd");
		newButton.classList.add("btnDel");
		newButton.setAttribute("onclick","UpdUser()")
		newButton2.setAttribute("onclick","DelUser()")
		newId.setAttribute("id",result.id)
		newId.innerText=result.id;
		newPassword.innerText=result.password;
		newName.innerText=result.name;
		newRole.innerText=result.role;
		newLine.appendChild(newButton);
		newLine.appendChild(newButton2);

	})
		}
	
	function UserList(){
		fetch("userList").then(response=>response.json()).then(result=>{
			for(e of result){
			var newRow = document.querySelector(".table").insertRow();
			var newId= newRow.insertCell(0);
			var newPassword= newRow.insertCell(1);
			var newName= newRow.insertCell(2);
			var newRole= newRow.insertCell(3);
			var newLine = newRow.insertCell(4);
			var newButton = document.createElement("button")
			var newButton2 = document.createElement("button")
			newId.setAttribute("id",e.id)
			newButton.innerText="조회"
			newButton2.innerText="삭제"
			newButton.classList.add("btnUpd");
			newButton2.classList.add("btnDel");
			newButton.setAttribute("onclick","UpdUser()")
			newButton2.setAttribute("onclick","DelUser()")
			newId.innerText=e.id;
			newPassword.innerText=e.password;
			newName.innerText=e.name;
			newRole.innerText=e.role;
			newLine.appendChild(newButton);
			newLine.appendChild(newButton2);
			}})
	}
	
	
	
	
	
	UserList(); */
	</script>
</body>
</html>