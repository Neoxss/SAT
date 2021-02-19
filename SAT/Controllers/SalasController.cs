using DataAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace SAT.Controllers
{
    public class SalasController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Crear()
        {
            SATContext entities = new SATContext();
            bool EsProfesor = false;
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            int Dispositivo = 0;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                string IdDispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (IdDispositivo == null)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Dispositivo Desconocido");
                }
                Dispositivo = int.Parse(IdDispositivo);
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Unathorized");
            }

            //TODO: Agregar los Roles como Enum en el proyecto
            EsProfesor = (entities.RolUsuarios.Any(u => u.IdUsuario == IdUsuario && u.IdRol == (int) Roles.Profesor));

            //Crear sala y guardarla en DB
            if (EsProfesor)
            {
                Sala sala = new Sala("Sala del Profesor X", DateTime.Now, 120, IdUsuario);
                entities.Salas.Add(sala);
                entities.SaveChanges();

                return Request.CreateResponse(HttpStatusCode.OK, sala.IdSala);
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden, "Solo los profesores pueden crear las salas");
            }
        }
        public HttpResponseMessage Unirse(int IdSala)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            bool EstaDentro = false;
            int Dispositivo = 0;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                string IdDispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (IdDispositivo == null)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Dispositivo Desconocido");
                }
                Dispositivo = int.Parse(IdDispositivo);
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Unathorized");
            }

            Sala sala = entities.Salas.SingleOrDefault(e => e.IdSala == IdSala);
            //Validar si la sala existe
            if (sala == null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.OK, "El id de la sala no existe");
            }

            EstaDentro = entities.SalaUsuarios.Any(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);

            if (!EstaDentro)
            {
                SalaUsuario salaUsuario = new SalaUsuario();
                salaUsuario.IdSala = IdSala;
                salaUsuario.IdUsuario = IdUsuario;
                entities.SalaUsuarios.Add(salaUsuario);
                entities.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, "Se ha unido a la sala #" +IdSala+" satisfactoriamente");
            }
            return Request.CreateResponse(HttpStatusCode.OK, "Ya esta dentro");
        }

        public HttpResponseMessage Presente(int IdSala)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            bool EstaDentro = false;
            int Dispositivo = 0;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                string IdDispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (IdDispositivo == null)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Dispositivo Desconocido");
                }
                Dispositivo = int.Parse(IdDispositivo);
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Unathorized");
            }

            Sala sala = entities.Salas.SingleOrDefault(e => e.IdSala == IdSala);
            //Validar si la sala existe
            if (sala == null)
            {
                return Request.CreateErrorResponse(HttpStatusCode.OK, "El id de la sala no existe");
            }

            SalaUsuario salaUsuario = entities.SalaUsuarios.FirstOrDefault(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);
            EstaDentro = entities.SalaUsuarios.Any(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);

            //Validar si no se encontro al usuario
            if (salaUsuario == null) 
            {
                return Request.CreateErrorResponse(HttpStatusCode.OK, "El id de la sala no existe");
            }

            //Validar si ya esta dentro de la sala
            if (salaUsuario != null && EstaDentro)
            {
                return Request.CreateResponse(HttpStatusCode.OK, "Ya esta Presente en la sala");
            }

            return Request.CreateResponse(HttpStatusCode.OK, "Presente!");
        }
    }
}
