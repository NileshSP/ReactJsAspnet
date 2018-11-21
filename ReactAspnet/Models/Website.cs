using System;
using System.Collections.Generic;

namespace ReactAspnet.Models
{
    public partial class Website
    {
        public Website()
        {
            WebsiteVisitDetails = new HashSet<WebsiteVisitDetails>();
        }

        public int WebsiteId { get; set; }
        public string Url { get; set; }

        public ICollection<WebsiteVisitDetails> WebsiteVisitDetails { get; set; }
    }
}
