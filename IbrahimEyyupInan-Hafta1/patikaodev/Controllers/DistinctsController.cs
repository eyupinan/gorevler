using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Http;
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
    public class DistinctsController : ControllerBase
    {
        private readonly patikaodevContext _context;

        private readonly IMapper _mapper;

        public DistinctsController(patikaodevContext context, IMapper mapper)
        {
            _mapper = mapper;
            _context = context;
           
            
        }

        // GET: api/Distincts
        [HttpGet]
        public async Task<ActionResult<IEnumerable<DistinctDto>>> GetDistinct()
        {
            IEnumerable<Distinct> cities = await _context.Distinct.Include(c => c.city).ToListAsync();
            return _mapper.Map<IEnumerable<Distinct>, List<DistinctDto>>(cities);
        }
        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<DistinctDto>>> getBySearch([FromQuery] DistinctQuery query)
        {

            IQueryable<Distinct> distinctContext = from s in _context.Distinct select s;
            if (query.id != 0)
            {
                distinctContext = distinctContext.Where(d => d.Id == query.id);
            }
            if (query.name != null)
            {
                distinctContext = distinctContext.Where(d => d.Name == query.name);
            }
            if (query.areaStart != 0)
            {
                if (query.areaEnd != 0)
                {
                    distinctContext = distinctContext.Where(d => d.area > query.areaStart && d.area < query.areaEnd);
                }
                else if (query.areaStart < 0)
                {
                    distinctContext = distinctContext.Where(d => d.area < -1 * query.areaStart);
                }
                else
                {
                    distinctContext = distinctContext.Where(d => d.area > query.areaStart);
                }
            }
            if (query.populationStart != 0)
            {
                if (query.populationEnd != 0)
                {
                    distinctContext = distinctContext.Where(d => d.area > query.populationStart && d.area < query.populationEnd);
                }
                else if (query.populationStart < 0)
                {
                    distinctContext = distinctContext.Where(d => d.area < -1 * query.populationStart);
                }
                else
                {
                    distinctContext = distinctContext.Where(d => d.area > query.populationStart);
                }
            }
            if (query.cityName != null)
            {
                distinctContext = distinctContext.Where(d => d.city.name == query.cityName);
            }
            if (query.cityId != 0)
            {
                distinctContext = distinctContext.Where(d => d.city.id == query.cityId);
            }
            IEnumerable<Distinct> distincts = await distinctContext.Include(c=>c.city).ToListAsync();
            return _mapper.Map<IEnumerable<Distinct>, List<DistinctDto>>(distincts);
        }

        // GET: api/Distincts/5
        [HttpGet("{id}")]
        public async Task<ActionResult<DistinctDto>> GetDistinct(int id)
        {
            var distinct = await _context.Distinct.Where(d => d.Id==id).Include(c => c.city).FirstOrDefaultAsync();


            if (distinct == null)
            {
                return NotFound();
            }

            return _mapper.Map<Distinct,DistinctDto>(distinct);
        }

        // PUT: api/Distincts/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDistinct(int id, DistinctDto distinctDto)
        {
            Distinct distinct= _mapper.Map<DistinctDto,Distinct>(distinctDto);
            if (id != distinct.Id)
            {
                return BadRequest();
            }

            _context.Entry(distinct).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DistinctExists(id))
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

        // POST: api/Distincts
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<DistinctDto>> PostDistinct(DistinctDto distinctDto)
        {
            Distinct distinct = _mapper.Map<DistinctDto, Distinct>(distinctDto);
            _context.Distinct.Add(distinct);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDistinct", new { id = distinct.Id }, distinctDto);
        }

        // DELETE: api/Distincts/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDistinct(int id)
        {
            var distinct = await _context.Distinct.FindAsync(id);
            if (distinct == null)
            {
                return NotFound();
            }

            _context.Distinct.Remove(distinct);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool DistinctExists(int id)
        {
            return _context.Distinct.Any(e => e.Id == id);
        }
    }
}
