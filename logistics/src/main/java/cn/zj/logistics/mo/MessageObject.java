package cn.zj.logistics.mo;

public class MessageObject {
	private Integer code;//0表示失败，1表示成功
	private String msg;
	
	public static MessageObject createMessageObject(Integer code, String msg) {
		return new MessageObject(code,msg);
	}
	private MessageObject(Integer code, String msg) {
		super();
		this.code = code;
		this.msg = msg;
	}
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
}
