using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SampleApi.Models
{
    /// <summary>
    /// Represents a location in the system.
    /// </summary>
    public class Location
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string ShortDescription { get; set; }

        public string LongDescription { get; set; }

        public decimal Latitude { get; set; }

        public decimal Longitude { get; set; }

        public string Address { get; set; }

        public string Image { get; set; }

        public List<string> Categories { get; set; }

        public string PhoneNumber { get; set; }

        public int PriceLevel { get; set; }

        public string WebsiteURL { get; set; }

        public string GoogleURL { get; set; }

    }
}
