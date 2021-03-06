﻿using SampleApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SampleApi.DAL
{
    public interface ILocationDAO
    {
        List<Location> GetAllLocations();
        Location GetLocation(int id);
    }
}
