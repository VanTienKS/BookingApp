﻿using BookMovieTicketApp.Web.Models;
using BookMovieTicketApp.Web.Service.IService;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace BookMovieTicketApp.Web.Controllers {
	public class CouponController : Controller {
		private readonly ICouponService _couponService;
		public CouponController(ICouponService couponService) {
			_couponService = couponService;
		}

		public async Task<IActionResult> CouponIndex() {
			List<CouponDto> list = new();
			ResponseDto? response = await _couponService.GetAllCouponAsync();
			if (response != null && response.IsSuccess) {
				list = JsonConvert.DeserializeObject<List<CouponDto>>(Convert.ToString(response.Result));
			} else {
				TempData["error"] = response?.Message;
			}
			return View(list);
		}

		public async Task<IActionResult> CouponCreate() {
			return View();
		}

		[HttpPost]
		public async Task<IActionResult> CouponCreate(CouponDto couponDto) {
			if (ModelState.IsValid) {
				ResponseDto? response = await _couponService.CreateCouponAsync(couponDto);
				if (response != null && response.IsSuccess) {
					return RedirectToAction(nameof(CouponIndex));
				}
			}
			return View(couponDto);
		}

		public async Task<IActionResult> CouponDelete(int couponID) {
			ResponseDto? response = await _couponService.GetCouponByIdAsync(couponID);
			if (response != null && response.IsSuccess) {
				CouponDto? couponDto = JsonConvert.DeserializeObject<CouponDto>(Convert.ToString(response.Result));
				return View(couponDto);
			}
			return NotFound();
		}

		[HttpPost]
		public async Task<IActionResult> CouponDelete(CouponDto couponDto) {
			ResponseDto? response = await _couponService.DeleteCouponAsync(couponDto.CouponId);
			if (response != null && response.IsSuccess) {
				return RedirectToAction(nameof(CouponIndex));
			}
			return View(couponDto);
		}
	}
}
