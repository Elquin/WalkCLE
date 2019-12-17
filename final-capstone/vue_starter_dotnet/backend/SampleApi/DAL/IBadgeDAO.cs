using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SampleApi.DAL
{
    public interface IBadgeDAO
    {
        List<string> GetBadges(int userId);
    }
}
