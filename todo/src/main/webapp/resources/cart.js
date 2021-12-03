let cart = {
	cartList: async function() {
		let selList = await fetch("../cartSelectList");
		let selList2 = await selList.json();
		//console.log("1111", selList2)
		for (emp of selList2) {
			var pr = document.getElementById("template").cloneNode(true);
			pr.style.display = "";
			pr.querySelector(".row").setAttribute("data-no", emp.no);
			pr.querySelector("[name=buy]").setAttribute("data-check",1)
			pr.querySelector("[name=buy]").setAttribute("onclick",`cart.checkList(${emp.no})`);
		
			pr.querySelector(".pname").firstElementChild.innerHTML = emp.product_nm;
			pr.getElementsByClassName("p_price")[0].value = emp.price;
			
			pr.getElementsByClassName("p_num")[0].value = emp.qty;
			pr.querySelector(".sum").innerHTML = emp.price * emp.qty;
			
			document.getElementById("basket").appendChild(pr.firstElementChild.cloneNode(true));
			
		}
		this.reCalc();
	}, 
	checkList: function(n){
		(document.querySelector(`[data-no="${n}"]`).querySelector("[name=buy]").getAttribute("data-check")==0)?document.querySelector(`[data-no="${n}"]`).querySelector("[name=buy]").setAttribute("data-check",1):document.querySelector(`[data-no="${n}"]`).querySelector("[name=buy]").setAttribute("data-check",0)		
	},
	delItem: function() {
		//console.log(event.target.closest(".row"))
		 let no = event.target.closest(".row").getAttribute("data-no"); 
		let url = "../cartDelete?no="+no;
		fetch(url).then(response=>response.json()).then(
			//선택한 버튼으 ㅣ상품을 삭제 버튼 closet. remove()
			result=>{
				document.querySelector(`[data-no="${result.no}"]`).closest(".row").remove()
				this.reCalc();
			}
		)
	},

	delCheckedItem: function() {
		let checkList = document.querySelectorAll("[data-no]");
		let numList=[];
		
		for(e of checkList){
	if( e.querySelector("[name=buy]").getAttribute("data-check")==1){
		numList.push(e.getAttribute("data-no"));
	}
}
fetch(`../cartDeleteCheck?nos=${numList}`)
.then(result=>{
	for(e of checkList){
	if( e.querySelector("[name=buy]").getAttribute("data-check")==1){
		e.remove();this.reCalc();
	}
}
})


		/*		let delCh = await fetch("../cartDeleteCheck?nos=");
				let delChList = await delCh.json();*/

	},
	delAllItem: function() {
	fetch("../cartDeleteAll")
	.then(response=>response.json())
	.then(result=>{
		document.querySelectorAll(".data").forEach(a=>a.remove())	
		this.reCalc();}
		)

	},

	changePNum: function() {
let no =event.target.closest(".row").getAttribute("data-no");
let change=event.target.closest(".updown").firstElementChild.value;
event.target.querySelector(".up")?change++:change--;

if(change<=0){
	this.delItem();
}
else{
fetch(`../cartUpdate?no=${no}&qty=${change}`)
.then(response=>response.json())
.then(result=>{
	document.querySelector(`[data-no="${no}"]`).querySelector(".updown").firstElementChild.value=change;
	document.querySelector(`[data-no="${no}"]`).querySelector(".sum").innerHTML=document.querySelector(`[data-no="${no}"]`).querySelector(".p_price").value*change
	this.reCalc();
})}



	},
	reCalc:function(){
		let Cal=0;
		let num=0;
		//console.log(document.querySelectorAll("[data-no]").length)
		for(let i =0;i<document.querySelectorAll("[data-no]").length;i++){
			Cal +=document.querySelectorAll(".p_price")[i].value*document.querySelectorAll(".p_num")[i].value;
			num+=document.querySelectorAll(".p_num")[i].value*1;
		}
	console.log(Cal)
	document.querySelector("#sum_p_num").innerHTML=`상품갯수: ${num}개 `
	document.querySelector("#sum_p_price").innerHTML=`합계금액: ${Cal}원`
	},

}
cart.cartList();
