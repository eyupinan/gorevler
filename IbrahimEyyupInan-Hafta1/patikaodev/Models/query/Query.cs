namespace patikaodev.Models.query
{
    public class Query
    {
        public int id { get; set; }
        public string name { get; set; }
        // start ve end içeren ifadeler küçük büyük ve arasında sorgularını okumak içindir.
        // eğer areaEnd ve areaStart ikisi birden verilmiş ise between işlemi yapılır
        // eğer areaEnd veya populationEnd verilmemesi durumunda eğer areaStart veya populationStart 0dan küçükse küçüktür,
        // 0'dan büyükse büyüktür operatörü ile işleme tabi tutulur
        public long areaStart { get; set; }
        public long areaEnd { get; set; }

        public long populationStart { get; set; }
        public long populationEnd { get; set; }


    }
}
