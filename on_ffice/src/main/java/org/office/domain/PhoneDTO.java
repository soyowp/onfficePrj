package org.office.domain;

import lombok.Data;

@Data
public class PhoneDTO {
	private String to;
	private String from;
	private String type;
	private String text;
	private String app_version;
}
