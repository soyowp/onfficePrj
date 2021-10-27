package org.office.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class TodoDTO {
	
	private int btnNum, StartPage, endPage, total;
	private boolean prev, next;
	private TodoCri cri;
	
	public TodoDTO(TodoCri cri, int total, int btnNum) {
		this.cri = cri;
		this.btnNum = btnNum;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum()/(double)this.btnNum)*this.btnNum);
		
		this.StartPage = this.endPage -this.btnNum +1;
		
		int realEnd = (int)Math.ceil((total*1.0) / cri.getAmount());
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.StartPage == 1? false : true;
		
		this.next = this.endPage < realEnd;
	}

}
