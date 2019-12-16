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
        public CheckinController(IUserDAO userDao)
        {
            this.userDao = userDao;
        }

        [HttpPost]
        [Authorize]
        public IActionResult AddCheckin(Checkin checkin)
        {
            checkin.UserId = GetCurrentUserId();
            Console.WriteLine(checkin.UserId);
            Console.WriteLine(checkin.LocationId);
            Console.ReadLine();
            return Ok();
        }

        private int GetCurrentUserId()
        {
            return userDao.GetUser(base.User.Identity.Name).Id;
        }
    }
}