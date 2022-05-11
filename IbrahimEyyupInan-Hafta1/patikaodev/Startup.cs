using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using patikaodev.Data;
using patikaodev.Models;
using Microsoft.EntityFrameworkCore.Diagnostics;
using AutoMapper;

namespace patikaodev
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "patikaodev", Version = "v1" });
            });

            services.AddDbContext<patikaodevContext>(context =>
            {
                context.UseInMemoryDatabase("TodoList").ConfigureWarnings(x => x.Ignore(InMemoryEventId.TransactionIgnoredWarning));

            }
                    );
            services.AddScoped<patikaodevContext>();
            var mapperConfig = new MapperConfiguration(mc =>
            {
                mc.AddProfile(new CityProfile());
                mc.AddProfile(new DistinctProfile());
            });

            IMapper mapper = mapperConfig.CreateMapper();
            services.AddSingleton(mapper);

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, patikaodevContext _context)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "patikaodev v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
            var city1 = new City(1, "Trabzon", 816684, 4685, new List<Distinct>());
            var city2 = new City(2, "Istanbul", 15840900, 5343, new List<Distinct>());
            var city3 = new City(3, "Ankara", 5747325, 24521, new List<Distinct>());

            _context.City.Add(city1);
            _context.City.Add(city2);
            _context.City.Add(city3);

            var dist1 = new Distinct(1, "Of", 41248, 330, city1);
            var dist2 = new Distinct(2, "Akçaabat", 121535, 385, city1);
            var dist3 = new Distinct(3, "Gaziosmanpaşa", 497959, 11, city2);
            var dist4 = new Distinct(4, "Üsküdar", 533570, 35, city2);
            var dist5 = new Distinct(5, "Çankaya", 925828, 288, city3);
            var dist6 = new Distinct(6, "Keçiören", 917759, 153, city3);

            _context.Distinct.Add(dist1);
            _context.Distinct.Add(dist2);
            _context.Distinct.Add(dist3);
            _context.Distinct.Add(dist4);
            _context.Distinct.Add(dist5);
            _context.Distinct.Add(dist6);

            _context.SaveChanges();


        }
    }
}
