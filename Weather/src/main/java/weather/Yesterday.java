package weather;

public class Yesterday {
    // 日期（fxDate），最高气温（tempMax）、最低气温
    // （tempMin）、白天天气情况（textDay）
    private String fxdate ;
    private String tempMax ;
    private  String tempMin ;
    private  String textDay ;
    public String getFxdate() {
        return fxdate;
    }

    public void setFxdate(String fxdate) {
        this.fxdate = fxdate;
    }

    public String getTempMax() {
        return tempMax;
    }

    public void setTempMax(String tempMax) {
        this.tempMax = tempMax;
    }

    public String getTempMin() {
        return tempMin;
    }

    public void setTempMin(String tempMin) {
        this.tempMin = tempMin;
    }

    public String getTextDay() {
        return textDay;
    }

    public void setTextDay(String textDay) {
        this.textDay = textDay;
    }


}
