using AutoMapper;
using patikaodev.Models.dto;

namespace patikaodev.Models
{
    public class CityProfile:Profile
    {
        public CityProfile()
        {
            CreateMap<City, CityDto>();
                
            CreateMap<CityDto, City>();
        }
    }
}
