using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SampleApi.DAL;
using SampleApi.Models;

namespace SampleApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CheckinController : Controller
    {
        private IUserDAO userDao;
        private ICheckinDAO checkinDao;
        public CheckinController(IUserDAO userDao, ICheckinDAO checkinDao)
        {
            this.userDao = userDao;
            this.checkinDao = checkinDao;
        }

        [HttpPost]
        [Authorize]
        public IActionResult AddCheckin(Checkin checkin)
        {
            checkin.UserId = GetCurrentUserId();
            bool savedCheckin = checkinDao.StoreCheckin(checkin);
            if (savedCheckin)
            {
                return Ok();
            }
            return BadRequest();
        }

        [HttpGet]
        [Authorize]
        public IActionResult GetUserCheckinHistory()
        {
            return Ok();
        }

        private int GetCurrentUserId()
        {
            return userDao.GetUser(base.User.Identity.Name).Id;
        }
    }
}