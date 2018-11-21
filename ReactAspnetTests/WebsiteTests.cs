using NUnit.Framework;
using ReactAspnet.Controllers;
using ReactAspnet.Models;
using Microsoft.EntityFrameworkCore;

namespace ReactAspnetTests
{
    public class WebsiteTests
    {
        private readonly WebsitesController _reactAspnet;

        public WebsiteTests()
        {
            _reactAspnet = new WebsitesController(new SampleDatabaseContext((new DbContextOptionsBuilder<SampleDatabaseContext>()).Options));
        }

        [Test]
        public void WebsitesController_Index_ReturnJson()
        {
            var result = _reactAspnet.Index(null, null, null);
            Assert.NotNull(result);
            Assert.True(result.Result.ToString().Trim() != "");
        }
    }
}