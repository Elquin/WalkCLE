using SampleApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SampleApi.DAL
{
    public interface ICheckinDAO
    {
        bool StoreCheckin(Checkin checkin);
    }
}
