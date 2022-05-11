using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace patikaodev.Models
{
    public class City
    {
        [Key]
        public long id { get; set; }
        public string name { get; set; }
        public long population { get; set; }
        public long area { get; set; }
        [JsonIgnore]
        public virtual List<Distinct> distincts { get; set; }
        public City()
        {

        }
        public City(long id, string name, long population, long area, List<Distinct> distincts)
        {
            this.id = id;
            this.name = name;
            this.population = population;
            this.area = area;
            this.distincts = distincts;
        }
    }
}
