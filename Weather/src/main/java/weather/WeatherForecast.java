package weather;

public class WeatherForecast {
    private  Date date;

    public Date getData() {
        return date;
    }

    public void setData(Date date) {
        this.date = date;
    }

    public String getStatues() {
        return statues;
    }

    public void setStatues(String statues) {
        this.statues = statues;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    private String statues;
    private String desc ;
}
