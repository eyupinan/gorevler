using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using patikaodev.Data;
using patikaodev.Models;
using patikaodev.Models.dto;
using patikaodev.Models.query;

namespace patikaodev.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CitiesController : ControllerBase
    {
        private readonly patikaodevContext _context;

        private readonly IMapper _mapper;

        public CitiesController(patikaodevContext context, IMapper mapper)
        {
            _mapper = mapper; 
            _context = context;
            


        }

        // GET: api/Cities
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CityDto>>> GetCity()
        {
            IEnumerable<City> cities =  await _context.City.ToListAsync();
            return _mapper.Map<IEnumerable<City>, List<CityDto>>(cities);
        }
        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<CityDto>>> getBySearch([FromQuery] Query query)
        {

            IQueryable<City> cityContext = from s in _context.City select s;
            if (query.id != 0)
            {
                cityContext = cityContext.Where(d => d.id == query.id);
            }
            if (query.name != null)
            {
                cityContext = cityContext.Where(d => d.name == query.name);
            }
            if (query.areaStart!= 0)
            {
                if (query.areaEnd != 0)
                {
                    cityContext = cityContext.Where(d => d.area > query.areaStart && d.area < query.areaEnd);
                }
                else if (query.areaStart < 0)
                {
                    cityContext = cityContext.Where(d => d.area < -1* query.areaStart);
                }
                else
                {
                    cityContext = cityContext.Where(d => d.area > query.areaStart);
                }
            }
            if (query.populationStart != 0)
            {
                if (query.populationEnd != 0)
                {
                    cityContext = cityContext.Where(d => d.area > query.populationStart && d.area < query.populationEnd);
                }
                else if (query.populationStart < 0)
                {
                    cityContext = cityContext.Where(d => d.area < -1 * query.populationStart);
                }
                else
                {
                    cityContext = cityContext.Where(d => d.area > query.populationStart);
                }
            }
            IEnumerable<City> cities = await cityContext.ToListAsync();
            return _mapper.Map<IEnumerable<City>, List<CityDto>>(cities);
        }

        // GET: api/Cities/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CityDto>> GetCity(long id)

        {
            var city = await _context.City.FindAsync(id);

            if (city == null)
            {
                return NotFound();
            }

            return _mapper.Map<City,CityDto>(city);
        }

        // PUT: api/Cities/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCity(long id, CityDto cityDto)
        {
            City city = _mapper.Map<CityDto,City>(cityDto);
            if (id != city.id)
            {
                return BadRequest();
            }

            _context.Entry(city).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CityExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Cities
        [HttpPost]
        public async Task<ActionResult<CityDto>> PostCity(CityDto cityDto)
        {
            City city = _mapper.Map<CityDto, City>(cityDto);
            _context.City.Add(city);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCity", new { id = city.id }, cityDto);
        }

        // DELETE: api/Cities/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCity(long id)
        {
            var city = await _context.City.FindAsync(id);
            if (city == null)
            {
                return NotFound();
            }

            _context.City.Remove(city);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CityExists(long id)
        {
            return _context.City.Any(e => e.id == id);
        }
    }
}
