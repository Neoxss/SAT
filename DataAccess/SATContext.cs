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
            modelBuilder.Entity<Rol>().ToTable("Roles", "UserInfo");
            modelBuilder.Entity<Sesion>().ToTable("Sesiones", "Seguridad");
            modelBuilder.Entity<RolUsuario>().ToTable("Rol_Usuario", "UserInfo");

            Database.SetInitializer<SATContext>(null);
            base.OnModelCreating(modelBuilder);
        }
        public DbSet<Usuario> Usuarios { get; set; }   
        public DbSet<Sala> Salas { get; set; }
        public DbSet<Rol> Roles { get; set; }
        public DbSet<Sesion> Sesiones { get; set; }
        public DbSet<RolUsuario> RolUsuarios { get; set; }

    }
}
