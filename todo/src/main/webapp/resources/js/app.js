function jsmakeList(data){
	for(let emp of data){
		var pet =document.getElementById("petTemplate");
		pet.getElementsByClassName("panel-title")[0].innerHTML = emp.name
		pet.getElementsByClassName("img-rounded")[0].src = emp.picture
		pet.getElementsByClassName("pet-breed")[0].innerHTML = emp.breed
		pet.getElementsByClassName("pet-age")[0].innerHTML = emp.age
		pet.getElementsByClassName("pet-location")[0].innerHTML = emp.location
		pet.getElementsByTagName("button")[0].setAttribute("data-id",emp.id)
		document.getElementById("petsRow").appendChild(pet.firstElementChild.cloneNode(true));	
}}
async function jsPetSelect(){
	let jsPetSelect = await fetch("petSelect");
	let jsPetList = await jsPetSelect.json();
	jsmakeList(jsPetList)
	jsAdoptSelect();	
	}

async function jsAdoptSelect(){
	let jsAdoptSelect = await fetch("adoptSelect");
	let jsAdoptList = await jsAdoptSelect.json();
	for(let emp of jsAdoptList){
		for(let i=0;i<document.getElementById("petsRow").childElementCount;i++){
		if(emp.id==document.getElementsByTagName("button")[i].getAttribute("data-id"))
		{document.getElementsByTagName("button")[i].setAttribute("disabled",true);
		document.getElementsByTagName("button")[i].innerHTML="Success";}
		
	}}
}

jsPetSelect();
/*
fetch("petSelect")
	.then(response => response.json())
	.then(result => {
		for (let emp of result) {

			fetch("adoptSelect")
				.then(response => response.json())
				.then(result => {
					for (let emp2 of result) {
						var pet = document.getElementById("petTemplate")

						if (emp2.id == emp.id) {
							pet.getElementsByClassName("btn")[0].setAttribute('disabled',true);
							pet.getElementsByClassName("btn")[0].innerHTML="success"
							
							break;
						}	 else {
							pet.getElementsByClassName("btn")[0].removeAttribute("disabled");
							pet.getElementsByClassName("btn")[0].innerHTML="Adopt"
						}

					}
					pet.getElementsByClassName("panel-title")[0].innerHTML = emp.name
					pet.getElementsByClassName("img-rounded")[0].src = emp.picture
					pet.getElementsByClassName("pet-breed")[0].innerHTML = emp.breed
					pet.getElementsByClassName("pet-age")[0].innerHTML = emp.age
					pet.getElementsByClassName("pet-location")[0].innerHTML = emp.location
					document.getElementById("petsRow").appendChild(pet.firstElementChild.cloneNode(true));
					
	})


			/*	var pet = $('#petTemplate').clone()
				$(pet).show();
			
					$(pet).find(".panel-title").html(emp.name)
			
					$(pet).find("img").attr("src",emp.picture)
					$(pet).find(".pat-age").html(emp.age)
					console.log(emp.age)
					$(pet).find(".pat-breed").html(emp.breed)
					$(pet).find(".pat-location").html(emp.location)
					
						$("#petsRow").append(pet)

		}
	}) 
	*/
/*	
	
fetch('./petSelect')
	.then(response => response.json())
	.then(makeList)
	.then(markAdopted)
function markAdopted() {
	fetch('./adoptSelect')
		.then(response => response.json())
		.then(data => {
			for (i = 0; i < data.length; i++) {
				$('.panel-pet').eq(data[i].id).find('button').text('Success').attr('disabled', true);

			}
		})
};*/






function makeList(data) {
	

	for(let emp of data){
	var pet = $('#petTemplate').clone()
	$(pet).css("display","")
	$(pet).find(".panel-title").html(emp.name)
	$(pet).find("img").attr("src", emp.picture)
	$(pet).find(".pet-age").html(emp.age)
	$(pet).find(".pet-breed").html(emp.breed)
	$(pet).find(".pet-location").html(emp.location)
	$('#petsRow').append(pet.children(":first-child").clone(true));
	
}


};

async function petList(){
	try{
		let petSelect = await fetch("./petSelect")
		let petMakeList = await petSelect.json();
		makeList(petMakeList);
		markAdopted();
		
	}catch(e){
		console.log("error"+e.message)
	}
};

async function markAdopted(){
	try{
		let mark = await fetch("./adoptSelect");
		let markList = await mark.json();
		console.log(markList.length)
		for(let i=0;i<markList.length;i++){
			$('.panel-pet').eq(markList[i].id).find('button').text('Success').attr('disabled', true);

		}
	}catch(e){
		console.log("markerror"+e.message)
	}
	
};

petList();











