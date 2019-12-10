using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using SampleApi.DAL;
using SampleApi.Models;

namespace SampleApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LocationsController : Controller
    {
        private ILocationDAO dao;
        public LocationsController(ILocationDAO dao)
        {
            this.dao = dao;
        }

        [HttpGet]
        public ActionResult<List<Location>> GetLocations()
        {
            List<Location> locations = dao.GetAllLocations();

            return Ok(locations);
        }

        [HttpGet("{id}", Name = "GetLocationById")]
        public ActionResult<Location> GetLocationById(int id)
        {
            Location location = dao.GetLocation(id);

            if (location == null)
            {
                return NotFound();
            }

            return Ok(location);
        }
    }
}