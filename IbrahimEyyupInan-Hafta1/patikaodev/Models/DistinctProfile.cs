using AutoMapper;
using patikaodev.Models.dto;

namespace patikaodev.Models
{
    public class DistinctProfile:Profile
    {
        public DistinctProfile()
        {
            CreateMap<Distinct, DistinctDto>()
                .ForMember(d => d.cityName,
                    opt => opt.MapFrom(src => src.city.name)
                ); ;

            CreateMap<DistinctDto, Distinct>();
        }
    }
}
