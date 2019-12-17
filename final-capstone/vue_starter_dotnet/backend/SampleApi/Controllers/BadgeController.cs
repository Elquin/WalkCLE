using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SampleApi.DAL;

namespace SampleApi.Controllers
{
    [Route("api/[controller]")]
    public class BadgeController : Controller
    {
        private IUserDAO userDao;
        private IBadgeDAO badgeDao;
        public BadgeController(IUserDAO userDao, IBadgeDAO badgeDao)
        {
            this.userDao = userDao;
            this.badgeDao = badgeDao;
        }

        [HttpGet]
        [Authorize]
        public IActionResult GetUserBadges()
        {
            int userId = GetCurrentUserId();
            List<string> result = badgesDao.GetBadges(userId);
            return Ok(result);
        }

        private int GetCurrentUserId()
        {
            return userDao.GetUser(base.User.Identity.Name).Id;
        }
    }
}