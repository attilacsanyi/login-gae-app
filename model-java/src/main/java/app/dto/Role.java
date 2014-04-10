package app.dto;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Role implements Serializable {

	private String key;

	private String name;

	private String description;

	/*
	 * getter & setter
	 */

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
