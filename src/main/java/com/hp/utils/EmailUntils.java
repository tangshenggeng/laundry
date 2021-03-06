package com.hp.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class EmailUntils {

	private static final String hostName = "smtp.qq.com";
    private static final String userInfo = "bsvrrobxysvjgbbg"; //服务器验证码 -- 非发件人邮箱密码
    
    private static final String chartset = "UTF-8";
    //发件人
    private static final String senderEmail = "1142369743@qq.com";
    //发件人昵称
    private static final String senderNick = "匠心衣橱";
    //主题
    private static final String emailSubject = "来自“匠心衣橱”干洗店的通知";
    
    /**
     * 包月到期
     * 
     * */
    public boolean expireOrder(String receive ,String orderNumber) {
    	try {
            HtmlEmail email = new HtmlEmail();
            // 配置信息
            email.setHostName(hostName);
            email.setFrom(senderEmail,senderNick);
            email.setAuthentication(senderEmail,userInfo);
            email.setCharset(chartset);
            email.setSubject(emailSubject);
            String sendHtml = "尊敬的客户您好！<hr>您在匠心衣橱的包月已到期，感谢您的支持！订单号为：<span style='color:orange;'>"+orderNumber+"</span>";
            email.setHtmlMsg(sendHtml);
            // 收件人
            if (null != receive) {
               email.addTo(receive);
            }
            //发送
            try {
				email.send();
				return true;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
            
        } catch (EmailException e) {
            e.printStackTrace();
            return false;
        } 
    }
    /**
     * 客户下单消费
     * 消费多少
     * 消费方式
     * 消费时间
     * 余额多少
     * */
    public boolean addOrder(String receive, String way,Integer price,Integer balance) {
    	Date date = new Date();
    	SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    	String time = dateFormat.format(date);
    	try {
    		HtmlEmail email = new HtmlEmail();
    		// 配置信息
    		email.setHostName(hostName);
    		email.setFrom(senderEmail,senderNick);
    		email.setAuthentication(senderEmail,userInfo);
    		email.setCharset(chartset);
    		email.setSubject(emailSubject);
    		String sendHtml = "尊敬的客户您好！<hr>您的账户在  "+time+" 通过 <span style='color:blue;'>"+way+"</span> 的方式，消费了 <span style='color:red;'>"+price+"</span> 积分，当前余额为：<span style='color:orange;'>"+balance+"</span>";
    		email.setHtmlMsg(sendHtml);
    		// 收件人
    		if (null != receive) {
    			email.addTo(receive);
    		}
    		//发送
    		try {
    			email.send();
    			return true;
    		} catch (Exception e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    			return false;
    		}
    		
    	} catch (EmailException e) {
    		e.printStackTrace();
    		return false;
    	} 
    }
    /**
     * 邮件发送工具类(单个)
     * 
     * */
    public static boolean sendEmail(String receive ,String code) {
        try {
            HtmlEmail email = new HtmlEmail();
            // 配置信息
            email.setHostName(hostName);
            email.setFrom(senderEmail,senderNick);
            email.setAuthentication(senderEmail,userInfo);
            email.setCharset(chartset);
            email.setSubject(emailSubject);
            String sendHtml = "尊敬的客户您好！<hr>您的账户激活码为：<span style='color:blue;'>"+code+"</span>";
            email.setHtmlMsg(sendHtml);
            // 收件人
            if (null != receive) {
               email.addTo(receive);
            }
            //发送
            try {
				email.send();
				return true;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
            
        } catch (EmailException e) {
            e.printStackTrace();
            return false;
        } 
    }
    /**
     * 反驳和同意通用的邮件
     * */
    public boolean sendEmailsCurrency(String receive ,String isSuccess,Map map) {
    	Long object = (Long) map.get("createTime");
    	int cashMoney = (int) map.get("cashMoney");
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//这个是你要转成后的时间的格式
    	String sd = sdf.format(new Date(object)); 
    	try {
    		HtmlEmail email = new HtmlEmail();
    		// 配置信息
    		email.setHostName(hostName);
    		email.setFrom(senderEmail,senderNick);
    		email.setAuthentication(senderEmail,userInfo);
    		email.setCharset(chartset);
    		email.setSubject(emailSubject);
    		String sendHtml = null;
    		if(isSuccess.equals("success")) {
    			sendHtml = "尊敬的客户您好！<hr>您的账户在<span style='color:blue;'>"+sd+"</span>，提现"+cashMoney+"元成功！<br>平台收取10%费用，最终到账<span style='color:blue;'>"+(cashMoney*0.9)+"</span>元注意查收！";
    		}else{
    			sendHtml = "尊敬的客户您好！<hr>抱歉！您的账户<span style='color:blue;'>出现异常！操作失败！</span>！";
    		}
    		email.setHtmlMsg(sendHtml);
    		// 收件人
    		if (null != receive) {
    			email.addTo(receive);
    		}
    		//发送
    		try {
    			email.send();
    			return true;
    		} catch (Exception e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    			return false;
    		}
    		
    	} catch (EmailException e) {
    		e.printStackTrace();
    		return false;
    	} 
    }
    /**
     * 反驳和同意通用的邮件
     * */
    public boolean sendEmailsRollBack(String receive ,String isOwe,Map map,Integer nowMoney) {
    	Long object = (Long) map.get("createTime");
    	int rechargeMoney = (int) map.get("rechargeMoney");
    	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//这个是你要转成后的时间的格式
    	String sd = sdf.format(new Date(object)); 
    	try {
    		HtmlEmail email = new HtmlEmail();
    		// 配置信息
    		email.setHostName(hostName);
    		email.setFrom(senderEmail,senderNick);
    		email.setAuthentication(senderEmail,userInfo);
    		email.setCharset(chartset);
    		email.setSubject(emailSubject);
    		String sendHtml = null;
    		if(isOwe.equals("true")) {
    			sendHtml = "尊敬的客户您好！<hr>您的账户在<span style='color:blue;'>"+sd+"</span>，充值"+rechargeMoney+"元失败！<br>并且由于您的消费使得当前积分<span style='color:blue;'>"+nowMoney+"</span>！请您尽快充值！";
    		}else{
    			sendHtml = "尊敬的客户您好！<hr>抱歉！您的账户出现异常在<span style='color:blue;'>"+sd+"</span>，充值"+rechargeMoney+"元失败！<br>";
    		}
    		email.setHtmlMsg(sendHtml);
    		// 收件人
    		if (null != receive) {
    			email.addTo(receive);
    		}
    		//发送
    		try {
    			email.send();
    			return true;
    		} catch (Exception e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    			return false;
    		}
    		
    	} catch (EmailException e) {
    		e.printStackTrace();
    		return false;
    	} 
    }
    
    /**
     * 邮件发送工具类(批量)
     * @param receive 接收者的数组 
     *  @param state 接收者的数组
     * @param isSuccess	是否通过 只有传success才通过
     * */
    public static boolean sendEmails(String[] receive ,String isSuccess) {
    	try {
    		HtmlEmail email = new HtmlEmail();
    		// 配置信息
    		email.setHostName(hostName);
    		email.setFrom(senderEmail,senderNick);
    		email.setAuthentication(senderEmail,userInfo);
    		email.setCharset(chartset);
    		email.setSubject(emailSubject);
    		String sendHtml = null;
    		if(isSuccess.equals("success")) {
    			sendHtml = "尊敬的客户您好！<hr>您的账户已经<span style='color:blue;'>通过审核</span>！您可以凭借真实姓名或邮箱登录进行接单啦！";
    		}else{
    			sendHtml = "尊敬的客户您好！<hr>抱歉！您的账户<span style='color:blue;'>未通过审核</span>！<br>请您重新申请或添加客服<span style='color:orange;'>QQ：123456789</span>了解详细申请规则！";
    		}
    		email.setHtmlMsg(sendHtml);
    		// 收件人
    		if (null != receive) {
    			email.addTo(receive);
    		}
    		//发送
    		try {
    			email.send();
    			return true;
    		} catch (Exception e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    			return false;
    		}
    		
    	} catch (EmailException e) {
    		e.printStackTrace();
    		return false;
    	} 
    }
}

