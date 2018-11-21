using System;
using System.IO;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ReactAspnet.Models
{
    // DB context and relative models were created using nuget package manager console by executing the below command
    // Scaffold-DbContext "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\Nilesh\Source\Repos\ReactAspnet\Database\SampleDatabase.mdf;Integrated Security=True;Database=[SampleDB];" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -Tables Website, WebsiteVisitDetails -f
    public partial class SampleDatabaseContext : DbContext
    {
        public virtual DbSet<Website> Website { get; set; }
        public virtual DbSet<WebsiteVisitDetails> WebsiteVisitDetails { get; set; }

        public SampleDatabaseContext(DbContextOptions<SampleDatabaseContext> options) : base(options) { }

        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    if (!optionsBuilder.IsConfigured)
        //    {
        //        var database = @"C:\Users\Nilesh\Source\Repos\ReactAspnet\Database\SampleDatabase.mdf"; // Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Database\SampleDatabase.mdf");
        //        var connString = $"Data Source = (LocalDB)\\MSSQLLocalDB;AttachDbFilename={database};Database=[SampleDB];Integrated Security = True; Connect Timeout = 30";
        //        // warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
        //        optionsBuilder.UseSqlServer(connString);
        //    }
        //}

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
