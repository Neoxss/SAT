using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class SATContext: DbContext
    {
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Usuario>().ToTable("Usuarios", "UserInfo");
            modelBuilder.Entity<Sala>().ToTable("Salas", "Proceso");

            Database.SetInitializer<SATContext>(null);
            base.OnModelCreating(modelBuilder);
        }
        public DbSet<Usuario> Usuarios { get; set; }   
        public DbSet<Sala> Salas { get; set; }   
    }
}
