using BookMovieTicketApp.Web.Models;

namespace BookMovieTicketApp.Web.Service.IService {
    public interface IBaseService {
        Task<ResponseDto> SendAsync(RequestDto requestDto);
    }
}
