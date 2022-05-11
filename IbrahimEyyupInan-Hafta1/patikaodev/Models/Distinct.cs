using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace patikaodev.Models
{
    public class Distinct
    {   
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public long population { get; set; }
        public long area { get; set; }
        [ForeignKey("city")]
        public long cityId { get; set; }
        public virtual City city { get; set; }
        public Distinct()
        {

        }

        public Distinct(int id, string name, long population, long area, long cityId)
        {
            Id = id;
            Name = name;
            this.population = population;
            this.area = area;
            this.cityId = cityId;
        }

        public Distinct(int id, string name, long population, long area, City city)
        {
            Id = id;
            Name = name;
            this.population = population;
            this.area = area;
            this.city = city;
        }
    }
}
