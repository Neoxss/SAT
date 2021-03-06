﻿using DataAccess.Models;
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
            modelBuilder.Entity<SalaUsuario>().ToTable("Salas_Usuarios", "Proceso");
            modelBuilder.Entity<SalasIntervalos>().ToTable("Salas_Intervalos", "Proceso");
            modelBuilder.Entity<PresenciaIntervalos>().ToTable("Presencia_Intervalos", "Proceso");


            Database.SetInitializer<SATContext>(null);
            base.OnModelCreating(modelBuilder);
        }
        public DbSet<Usuario> Usuarios { get; set; }   
        public DbSet<Sala> Salas { get; set; }
        public DbSet<Rol> Roles { get; set; }
        public DbSet<Sesion> Sesiones { get; set; }
        public DbSet<RolUsuario> RolUsuarios { get; set; }
        public DbSet<SalaUsuario> SalaUsuarios { get; set; }
        public DbSet<SalasIntervalos> SalasIntervalos { get; set; }
        public DbSet<PresenciaIntervalos> PresenciaIntervalos { get; set; }
    }
}
