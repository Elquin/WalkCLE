using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace SampleApi.Controllers
{
    public class BadgeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}