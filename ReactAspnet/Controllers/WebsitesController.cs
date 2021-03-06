﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using ReactAspnet.Models;

namespace ReactAspnet.Controllers
{
    [Route("api/[controller]")]
    public class WebsitesController : Controller
    {
        private readonly SampleDatabaseContext _context;

        public WebsitesController(SampleDatabaseContext context)
        {
            _context = context;
        }

        [HttpGet("[action]/{searchDate?}/{topNumber?}/{columns?}")]
        public async Task<IActionResult> Index(string columns = "WebsiteId,Url,TotalVisits,VisitDate", string searchDate = null, int? topNumber = null)
        {
            try
            {
                DateTime dateValue;
                string getFinalDate = (searchDate is null
                                        ? _context.WebsiteVisitDetails.Max(s => s.VisitDate).GetValueOrDefault().ToShortDateString() // get max searchDate from DB
                                        : searchDate
                                      );

                if (DateTime.TryParse(getFinalDate.ToString(), out dateValue))
                {
                    IQueryable websites = _context.WebsiteVisitDetails
                                            .Where(s => s.VisitDate == dateValue)
                                            .GroupBy(g => g.WebsiteId)
                                            .Select(a => new { WebsiteId = a.Key, TotalVisits = a.Sum(x => x.TotalVisits) })
                                            .OrderByDescending(o => o.TotalVisits)
                                            .Take(topNumber ?? 5)
                                            .Join(_context.Website
                                                , left => left.WebsiteId
                                                , right => right.WebsiteId
                                                , (left, right) => new Websites
                                                {
                                                    WebsiteId = left.WebsiteId,
                                                    Url = right.Url,
                                                    TotalVisits = left.TotalVisits,
                                                    VisitDate = dateValue.Date
                                                })
                                            .Select(CreateNewStatement<Websites>(columns)) // nullify values for not required columns
                                            .AsQueryable();

                    // eliminate columns with null values for final output
                    var finalResult = JsonConvert.SerializeObject(websites, Formatting.Indented, new JsonSerializerSettings { DefaultValueHandling = DefaultValueHandling.Ignore });

                    return Ok(await Task.Run(() => finalResult));
                }
                else
                {
                    return NotFound("search date not valid");
                }
            }
            catch (Exception ex)
            {
                return NotFound(ex);
            }
        }

        private Func<T, T> CreateNewStatement<T>(string fields)
        {
            // input parameter "o"
            var xParameter = Expression.Parameter(typeof(T), "o");

            // new statement "new T()"
            var xNew = Expression.New(typeof(T));

            // create initializers
            var bindings = fields.Split(',').Select(o => o.Trim())
                .Select(o => {

                    // property "Field1"
                    var mi = typeof(T).GetProperty(o);

                    // original value "o.Field1"
                    var xOriginal = Expression.Property(xParameter, mi);

                    // set value "Field1 = o.Field1"
                    return Expression.Bind(mi, xOriginal);
                }
            );

            // initialization "new T { Field1 = o.Field1, Field2 = o.Field2 }"
            var xInit = Expression.MemberInit(xNew, bindings);

            // expression "o => new T { Field1 = o.Field1, Field2 = o.Field2 }"
            var lambda = Expression.Lambda<Func<T, T>>(xInit, xParameter);

            // compile to Func<T, T>
            return lambda.Compile();
        }

        public class Websites
        {
            public int WebsiteId { get; set; }
            public string Url { get; set; }
            public int? TotalVisits { get; set; }
            public DateTime? VisitDate { get; set; }
        }

    }
}
