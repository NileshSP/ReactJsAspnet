using System;
using System.IO;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ReactAspnet.Models
{
    // DB context and relative models were created using nuget package manager console by executing the below command
    // Scaffold-DbContext "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename={relativeRootPath}\App_Data\SampleDatabase.mdf;Integrated Security=True;Database=SampleDatabase;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -Tables Website, WebsiteVisitDetails -f
    public partial class SampleDatabaseContext : DbContext
    {
        public virtual DbSet<Website> Website { get; set; }
        public virtual DbSet<WebsiteVisitDetails> WebsiteVisitDetails { get; set; }

        public SampleDatabaseContext(DbContextOptions<SampleDatabaseContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Website>(entity =>
            {
                entity.Property(e => e.Url).IsRequired();
            });

            modelBuilder.Entity<WebsiteVisitDetails>(entity =>
            {
                entity.Property(e => e.VisitDate).HasColumnType("date");

                entity.HasOne(d => d.Website)
                    .WithMany(p => p.WebsiteVisitDetails)
                    .HasForeignKey(d => d.WebsiteId);
            });
        }
    }
}
