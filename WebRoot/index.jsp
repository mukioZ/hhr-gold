<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="Dao.MysqlDao.*"%>
<%@page import="java.math.*"%> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>金牌合伙人</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="hhr-gold">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />  
<style type="text/css">

@charset "utf-8";  

*{ margin:0;padding:0;}  
  

* html body{ overflow:visible;}  
* html iframe, * html frame{ overflow:auto;}  
* html frameset{ overflow:hidden;}  
  
body{ color:#F6F6F6; background:#FFF; font:12px/22px Verdana,Arial,sans-serif,"Times New Roman",宋体; text-align:center;}  
body,ul,ol,li,p,h1,h2,h3,h4,h5,h6,form,fieldset,table,td,img,div,tr{ margin:0; padding:0;box-sizing:border-box;}  
input,select{ font-size:12px; vertical-align:middle;}  
  

body div{ text-align:left;}  
  

textarea,input{ word-wrap:break-word; word-break:break-all; padding:0px;}  
  

li{ list-style-type:none;}  
  

img{ border:0 none;}  
  

a:link, a:visited{ color:#04C; text-decoration:none;}  
a:hover{ color:#F60; text-decoration:underline;}  
  

a { outline:none; star:expression(this.onFocus=this.blur());}  
  

h1{ font-size:24px;}  
h2{ font-size:20px;}  
h3{ font-size:18px;}  
h4{ font-size:16px;}  
h5{ font-size:14px;}  
h6{ font-size:12px;}  

.e td,th
{
    text-align:center;
    border:solid #000 1px;
    border-color:#cccccc;
    font-size:13px;
    font-family: "微软雅黑"; 
    color:#666666;
}

.mlg td
{
    text-align:center;
    border:solid #000 0px;
    border-color:#cccccc;
    font-size:13px;
    font-family: "微软雅黑"; 
    color:#666666;
}
.mlg th
{
    text-align:center;
    border:solid #000 0px;
    border-color:#cccccc;
    font-size:13px;
    font-family: "微软雅黑"; 
    color:#666666;
}




</style>
  </head>

  <body style="text-align:center">

<img src ="<%=request.getContextPath()%>/img/ste.jpg" width="100%" align="center" />
<br/>
  <table align="center" style="display:inline-block;" class="mlg">
<tr>
<th border="0" font-side=4>请输入店主/合伙人ID</td>
</tr> 


 </table> 
 
<div style="text-align:center;">
<form name="chaxun01" style="display:inline-block;">
<input type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" id="txt" name="custid" />
<input type="submit" value="查询" onclick="Submit();">
</form>
</div>
<%
  String custid=request.getParameter("custid");
  String driver = "com.mysql.jdbc.Driver";  
  String url = "jdbc:mysql://5901ad996d3ac.sh.cdb.myqcloud.com:8233/hhr?&user=root&useUnicode=true&characterEncoding=utf8";   
  String user = "inquire";                  
  String password = "X4f800I7e251";  

//try {               
  Class.forName(driver);  
  Connection conn = DriverManager.getConnection(url, user, password);  
  if(!conn.isClosed())          
   {

if(custid==null||custid==""){custid="1";}

   else{          
             Statement statepd = conn.createStatement();
             String pdsql="select * from orderpeo where partnerid="+custid+"";
             ResultSet pdd=statepd.executeQuery(pdsql);
             
             if(pdd.next()){
             String category=pdd.getString("category");
             if("合伙人".equals(category)){
             //
             System.out.println("1");
   
             Statement statefansnum = conn.createStatement();  
             String fanssql = "select count(*) fansnum2 from orderpeo where partnerid="+custid+" and fanstime between '2017-4-1 00:00' and '2017-6-1 00:00'"; 
             ResultSet rsfansnum = statefansnum.executeQuery(fanssql); 
             rsfansnum.next();
             int fansnum2 = rsfansnum.getInt("fansnum2");
             Statement statement = conn.createStatement();  
             String sql = "select * from orderpeo where partnerid="+custid+""; 
             ResultSet rs = statement.executeQuery(sql);  
             rs.next();                          
             String fansid = rs.getString("fansid");
             Statement statefans = conn.createStatement(); 
             String sql2="select sum(pnum*price) total,count(distinct(orderid)) idnum from orderform,orderpeo where partnerid="+custid+" and orderform.ordercustid=orderpeo.fansid and ordertime between '2017-4-1 00:00' and '2017-6-1 00:00'";  
             ResultSet fans = statefans.executeQuery(sql2);
             fans.next();
    
             
             
             
             //
             Statement statefreight = conn.createStatement(); 
             String freight="select sum(freight) freightall from (select freight from orderform,orderpeo where partnerid="+custid+" and orderform.ordercustid=orderpeo.fansid and ordertime between '2017-4-1 00:00' and '2017-6-1 00:00' group by orderid)t";  
             ResultSet rsfreight = statefreight.executeQuery(freight);
             rsfreight.next();
             String freightall=rsfreight.getString("freightall");
             if(freightall==null){freightall="0";}              
             double freightall2=Double.valueOf(freightall).doubleValue();   
                               
             int idnum;
             idnum=fans.getInt("idnum");
             String idnum1=String.valueOf(idnum);
             if(idnum1==null){idnum=0;} 
             String total=fans.getString("total");
             if(total==null){total="0";} 
             double total2=Double.valueOf(total).doubleValue()+freightall2;             
             double total3=fansnum2*0.3+total2*0.7;
             BigDecimal total4=new BigDecimal(total3);  
             double total5 = total4.setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();  
             %>
             
<br/>   
<form name="chaxun02" style="text-align:center;">   
     <table border="0" style="display:inline-block;" align="center" bordercolor="#cccccc" class="e">

  <tr align="left" >
    <th width="100" >店主/合伙人ID:</th>
    <td width="100"><%=custid%></td>
  </tr>
  <tr align="left">
    <th width="100">粉丝数:</th>
   <td width="100"><%=fansnum2 %></td>
  </tr>
  <tr align="left">
    <th width="100" >订单数:</th>
    <td width="100"><%=idnum%></td>
  </tr>
  <tr align="left">
    <th width="100" >销售额:</th>
    <td width="100"><%=total2%></td>
  </tr>
  <tr align="left"> 
    <th width="100" >积&nbsp;&nbsp;&nbsp;分:</th>
    <td width="100"><%=total5%></td>
  </tr> 
   </table>       
       
  <table align="center" style="display:inline-block;" class="mlg">
<tr>
<br/>
</tr>
<tr>
<br/>
</tr>
<tr>
<td border="0">积分=销售额x70%+粉丝x30%(活动期间5.1-5.31)</td>
</tr>

 </table>           
          
  </form>         <%}   
  
  
  else if("店主".equals(category))
  
  
  {          System.out.println("2");
             Statement statefansnum = conn.createStatement();  
             String fanssql = "select count(*) fansnum2 from orderpeo where partnerid="+custid+" and fanstime between '2017-4-1 00:00' and '2017-6-1 00:00'"; 
             ResultSet rsfansnum = statefansnum.executeQuery(fanssql); 
             rsfansnum.next();
             int fansnum2 = rsfansnum.getInt("fansnum2");
             Statement statement = conn.createStatement();  
             String sql = "select * from orderpeo where partnerid="+custid+""; 
             ResultSet rs = statement.executeQuery(sql);  
             rs.next();                          
             String fansid = rs.getString("fansid");
             Statement statefans = conn.createStatement(); 
             String sql2="select sum(pnum*price) total,count(distinct(orderid)) idnum from orderform,orderpeo where partnerid="+custid+" and orderform.ordercustid=orderpeo.fansid and ordertime between '2017-4-1 00:00' and '2017-6-1 00:00'";  
             ResultSet fans = statefans.executeQuery(sql2);
             fans.next();
             
             Statement stateself = conn.createStatement(); 
             String sqlself="select sum(pnum*price) total,count(distinct(orderid)) idnum from orderform where ordercustid="+custid+"  and ordertime between '2017-4-1 00:00' and '2017-6-1 00:00'";  
             ResultSet self = stateself.executeQuery(sqlself);
             self.next(); 
             
             Statement statefreight = conn.createStatement(); 
             String freight="select sum(freight) freightall from (select freight from orderform,orderpeo where partnerid="+custid+" and orderform.ordercustid=orderpeo.fansid and ordertime between '2017-4-1 00:00' and '2017-6-1 00:00' group by orderid)t";  
             ResultSet rsfreight = statefreight.executeQuery(freight);
             rsfreight.next();
             String freightall=rsfreight.getString("freightall");
             if(freightall==null){freightall="0";}              
             double freightalll=Double.valueOf(freightall).doubleValue(); 
             
             Statement statefreight2 = conn.createStatement(); 
             String freight2="select sum(freight) freightall from (select freight from orderform where ordercustid="+custid+"  and ordertime between '2017-4-1 00:00' and '2017-6-1 00:00' group by orderid)t";  
             ResultSet rsfreight2 = statefreight2.executeQuery(freight2);
             rsfreight2.next();
             String freightall2=rsfreight2.getString("freightall");
             if(freightall2==null){freightall2="0";}              
             double freightalll2=Double.valueOf(freightall2).doubleValue();     
                               
             int idnum;
             int idnums;
             idnum=fans.getInt("idnum");
             idnums=self.getInt("idnum");
             String idnum1=String.valueOf(idnum);
             String idnums1=String.valueOf(idnums);
             if(idnum1==null){idnum=0;} 
             String total=fans.getString("total");
             if(idnums1==null){idnums=0;} 
             String totals=self.getString("total");
             if(totals==null){totals="0";} 
             double total2=Double.valueOf(total).doubleValue()+Double.valueOf(totals).doubleValue()+freightalll+freightalll2;             
             double total3=fansnum2*0.3+total2*0.7/2;
             BigDecimal total4=new BigDecimal(total3);  
             double total5 = total4.setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();  
             %>
             
<br/>   
<form name="chaxun02" style="text-align:center;">   
     <table border="0" style="display:inline-block;" align="center" bordercolor="#cccccc" class="e">

  <tr align="left" >
    <th width="100" >店主/合伙人ID:</th>
    <td width="100"><%=custid%></td>
  </tr>
  <tr align="left">
    <th width="100">粉丝数:</th>
   <td width="100"><%=fansnum2 %></td>
  </tr>
  <tr align="left">
    <th width="100" >订单数:</th>
    <td width="100"><%=idnum%></td>
  </tr>
  <tr align="left">
    <th width="100" >销售额:</th>
    <td width="100"><%=total2%></td>
  </tr>
  <tr align="left"> 
    <th width="100" >积&nbsp;&nbsp;&nbsp;分:</th>
    <td width="100"><%=total5%></td>
  </tr> 
   </table>       
       
  <table align="center" style="display:inline-block;" class="mlg">
<tr>
<br/>
</tr>
<tr>
<br/>
</tr>
<tr>
<td border="0">积分=销售额x70%+粉丝x30%(活动期间5.1-5.31)</td>
</tr>

 </table>           
          
  </form>         <%
  
  
  
  
  }} 
}     
}
conn.close();    
//}
  
// catch(ClassNotFoundException e) {             
//        e.printStackTrace();  
//        } catch(SQLException e) {  
//         e.printStackTrace();  
//        } catch(Exception e) {  
//        e.printStackTrace();  
//        }   
        
   %>
   
<br/>
<br/>
<br/>
<br/>
<br/>  
<table align="center" style="display:inline-block;" class="mlg" width="80%">
   <tr>
<!--  <td border="0"><a href="http://m.yangdongxi.com/tms/m/2730edb8ad900187cfd193aa542dd8ad.html">tips:如何查看自己的合伙人ID?</a></td> -->
</tr> 
</table>
<br/>



<img src="http://hhrerp.checkout2china.com/HHR-ERP/hhrcode/livecode?code=2017050415900" width="100%" align="center" />



<img src="http://hhrerp.checkout2china.com/HHR-ERP/hhrcode/livecode?code=2017050415901" width="100%" align="center" />



</html>
