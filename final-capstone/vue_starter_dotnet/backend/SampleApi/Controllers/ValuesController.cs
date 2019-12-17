using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SampleApi.DAL;
using SampleApi.Models;

namespace SampleApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        private IUserDAO userDao;
        public ValuesController(IUserDAO userDao)
        {
            this.userDao = userDao;
        }

        /// <summary>
        /// Gets a collection of values. The requestor must be authenticated.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Authorize]
        public IActionResult GetUsername()
        {
            UsernameObj u = new UsernameObj();
            u.Usernname = base.User.Identity.Name;
            return Ok(u);
        }

        /// <summary>
        /// Gets a special message. The requestor must be a user.
        /// </summary>
        /// <returns></returns>
        //[HttpGet("special")]
        //[Authorize(Roles = "User")]
        //public IActionResult RequestToken()
        //{
        //    var result = "If you see this then you are a user.";
        //    return Ok(result);
        //}
        
    }
}