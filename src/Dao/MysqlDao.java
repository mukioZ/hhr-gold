package Dao;
import java.sql.*;  
public class MysqlDao{  
    public static void main(String[] args){  
               // ����������        
        String driver = "com.mysql.jdbc.Driver";  
               // URLָ��Ҫ���ʵ����ݿ���world        
        String url = "jdbc:mysql://5901ad996d3ac.sh.cdb.myqcloud.com:8233/hhr?&user=root&useUnicode=true&characterEncoding=utf8";  
               // MySQL����ʱ���û���           
        String user = "inquire";           
        // MySQL����ʱ������          
        String password = "09poilkm";  
        String name;  
                try {               
                 // ������������        
                Class.forName(driver);  
                    // �������ݿ�       
               Connection conn = DriverManager.getConnection(url, user, password);  
                   if(!conn.isClosed())          
                  System.out.println("Succeeded connecting to the Database!");  
                  // statement����ִ��SQL���             
                     Statement statement = conn.createStatement();  
                     String sql = "select * from orderjd"; 
                     ResultSet rs = statement.executeQuery(sql);  
                     while(rs.next())  {         
                      
                         name = rs.getString("OrderPriceTotal");  
                            // ������              
                            System.out.println(rs.getString("OrderNickName") + "\t" + name);           
                       }
    conn.close();  }   
        catch(ClassNotFoundException e) {  
         System.out.println("Sorry,can`t find the Driver!");              
         e.printStackTrace();  
        } catch(SQLException e) {  
         e.printStackTrace();  
        } catch(Exception e) {  
         e.printStackTrace();  
        }   
        }  
}  
