# Hafta 1 Proje
* Program Şehirler ve ilçeler üzerine bir api sunmaktadır.
## Ana Swagger Görünümü
 * ![resim1](/img/resim1.png)
## Sorgular
 * Sorgu objesi gerektirdikleri aşağıdaki gibidir.<br>
 ![resim5](/img/resim5.png)
 * Genel sorgu <br>
 * ![resim2](/img/resim2.png)<br>
 * İlçeler için search parametreleri ile sorgu; aşağıda şehiri trabzon idsi olan ilçeler görüntülenmiştir.<br>
 ![resim3](/img/resim3.png)<br>
## Post,Put,Delete
* Post işleminde id değeri verilmesi gerekmez. Şehir bağlantısının kurulabilmesi için cityId eklenmek zorundadır.Response edilen veri gönderilen verinin birebir aynısıdır.<br>
![resim4](/img/resim4.png)
* Put işlemide post işlemi ile aynı şekilde gerçekleştirilir tek farkı url parametresi olarak Id eklenmesi gerekmektedir.
* Delete işleminde silinmek istenen il veya ilçenin id değeri url parametresi olarak verilmesi gerekmektedir.