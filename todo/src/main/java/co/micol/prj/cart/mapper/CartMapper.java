package co.micol.prj.cart.mapper;

import java.util.List;

import co.micol.prj.cart.vo.CartVO;

public interface CartMapper {
	public List<CartVO> cartSelectList();
	public int cartDeleteAll();
	public int cartDelete(CartVO vo);
	public int cartInsert(CartVO vo);
	public int cartUpdate(CartVO vo);
	
}
