using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using patikaodev.Models;

namespace patikaodev.Data
{
    public class patikaodevContext : DbContext
    {
        public patikaodevContext (DbContextOptions<patikaodevContext> options)
            : base(options)
        {
        }

        public DbSet<patikaodev.Models.City> City { get; set; }

        public DbSet<patikaodev.Models.Distinct> Distinct { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Distinct>()
                .HasKey(b => b.Id);
            modelBuilder.Entity<City>()
                .HasKey(b => b.id);
            modelBuilder.Entity<Distinct>()
                .HasOne(p => p.city)
                .WithMany(b => b.distincts)
                .HasForeignKey(p => p.cityId);
            var city1 = new City(12341, "Trabzon2", 816684, 4685, new List<Distinct>());
            modelBuilder.Entity<City>()
                .HasData(city1);
            /*var dist1 = new Distinct(11, "Of", 41248, 330, city1.id);
            var dist2 = new Distinct(12, "Akçaabat", 121535, 385, city1.id);
            var dist3 = new Distinct(13, "Gaziosmanpaşa", 497959, 11, city2.id);
            var dist4 = new Distinct(14, "Üsküdar", 533570, 35, city2.id);
            var dist5 = new Distinct(15, "Çankaya", 925828, 288, city3.id);
            var dist6 = new Distinct(16, "Keçiören", 917759, 153, city3.id);*/
            //modelBuilder.Entity<City>().HasData(
            //    city1);
            //modelBuilder.Entity<Distinct>().HasData(
            //    dist1,dist2,dist3,dist4,dist5,dist5,dist6
            //);

        }
    }
}
