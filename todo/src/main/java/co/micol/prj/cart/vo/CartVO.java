package co.micol.prj.cart.vo;

public class CartVO {
 private String no; //장바구니 번호
 private String product_nm; //상품명
 private int price;//가격
 private int qty;//수량
public String getNo() {
	return no;
}
public void setNo(String no) {
	this.no = no;
}
public String getProduct_nm() {
	return product_nm;
}
public void setProduct_nm(String product_nm) {
	this.product_nm = product_nm;
}
public int getPrice() {
	return price;
}
public void setPrice(int price) {
	this.price = price;
}
public int getQty() {
	return qty;
}
public void setQty(int qty) {
	this.qty = qty;
}
}
