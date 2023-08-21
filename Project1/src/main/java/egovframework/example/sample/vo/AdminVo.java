package egovframework.example.sample.vo;

public class AdminVo {
	
	private String id;
	private String password;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public AdminVo() {};
	public AdminVo(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}
	
	@Override
	public String toString() {
		return "AdminDao [id=" + id + ", password=" + password + "]";
	}
	
	
}
