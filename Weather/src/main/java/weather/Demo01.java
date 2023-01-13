import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Demo01 {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        //加载驱动
        Class.forName("com.mysql.cj.jdbc.Driver") ;
        //获取连接
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/st0816?useSSL=false&useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai","root","123456");
        System.out.println(conn);
        //创建数据库管理员，陈述对象
        String sql = "INSERT INTO `city` (`district`,`temperature`) VALUES(?,?)" ;
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,"上海");
        //执行sql 增删改的方法都是executeUpdate
        int row = stmt.executeUpdate();
        String msg = row==0?"添加失败":"添加成功";
        System.out.println(msg);
        //关闭连接
        stmt.close() ;
        conn.close() ;
    }
}
