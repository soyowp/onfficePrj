package org.office.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TodoCri extends SearchCriteria {

	private int pageNum;
	private int amount;
	private int worker;
	private int checker;
	private int startPage;

	public TodoCri() {
		this(1, 10);
	}

	public TodoCri (int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

}
