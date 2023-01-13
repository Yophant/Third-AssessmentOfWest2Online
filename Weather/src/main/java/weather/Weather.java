package weather;

import org.apache.hc.client5.http.classic.HttpClient;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.impl.async.CloseableHttpAsyncClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.io.entity.EntityUtils;

public class Weather {
    public static void main(String[] args) {
        //创建客户端对象
        CloseableHttpClient client = HttpClients.createDefault();
        //构建一个GET请求对象
        HttpGet gt = new HttpGet("https://geoapi.qweather.com/v2/city/lookup?key=94855d4debfa42f1a52047f2db2fc37e&location=福州") ;
        //发送请求，服务器响应出json字符串
        CloseableHttpClient response = client.execute(gt);
        //获取一个响应中的实体
        String jsonStr = EntityUtils.toString(response.getEntity(),"utf-8") ;
        System.out.println(jsonStr);
        //解析数据 jsonStr --> weatherForecast对象 json的帮助类:Jackson
        ObjectMapper mapper = new ObjectMapper ;
        WeatherForecast forecast = mapper.readValue(jsonStr,WeatherForecast) ;
        //当前城市
        String cityName = forecast.getData().getCity() ;
        //遍历昨天至明天三天信息
        List<WeatherInfo> weathers = forecast.getData().getForecast() ;
        for(WeatherInfo w:weathers){
            System.out.println("日期"+w.getDate());
            System.out.println("白天天气情况"+getFxdate());
            System.out.println("最高温"+w.getTempMax());
            System.out.println("最低温"+w.getTempMin());
        }
    }
}
