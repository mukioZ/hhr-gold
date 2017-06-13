package Dao;
import java.sql.*;  
public class MysqlDao{  
    public static void main(String[] args){  
               // 驱动程序名        
        String driver = "com.mysql.jdbc.Driver";  
               // URL指向要访问的数据库名world        
        String url = "jdbc:mysql://5901ad996d3ac.sh.cdb.myqcloud.com:8233/hhr?&user=root&useUnicode=true&characterEncoding=utf8";  
               // MySQL配置时的用户名           
        String user = "inquire";           
        // MySQL配置时的密码          
        String password = "09poilkm";  
        String name;  
                try {               
                 // 加载驱动程序        
                Class.forName(driver);  
                    // 连续数据库       
               Connection conn = DriverManager.getConnection(url, user, password);  
                   if(!conn.isClosed())          
                  System.out.println("Succeeded connecting to the Database!");  
                  // statement用来执行SQL语句             
                     Statement statement = conn.createStatement();  
                     String sql = "select * from orderjd"; 
                     ResultSet rs = statement.executeQuery(sql);  
                     while(rs.next())  {         
                      
                         name = rs.getString("OrderPriceTotal");  
                            // 输出结果              
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
