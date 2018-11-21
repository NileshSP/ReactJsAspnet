using System;
using System.Collections.Generic;

namespace ReactAspnet.Models
{
    public partial class WebsiteVisitDetails
    {
        public int WebsiteVisitDetailsId { get; set; }
        public int WebsiteId { get; set; }
        public int? TotalVisits { get; set; }
        public DateTime? VisitDate { get; set; }

        public Website Website { get; set; }
    }
}
