using AutoMapper;
using BookMovieTicketApp.Services.CouponAPI.Models;
using BookMovieTicketApp.Services.CouponAPI.Models.Dto;

namespace BookMovieTicketApp.Services.CouponAPI {
    public class MappingConfig {
        public static MapperConfiguration RegisterMap() {
            var mappingCongif = new MapperConfiguration(config => {
                config.CreateMap<CouponDto, Coupon>();
                config.CreateMap<Coupon, CouponDto>();
            });
            return mappingCongif;
        }
    }
}
