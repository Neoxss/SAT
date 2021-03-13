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
        private SATContext entities = new SATContext();

        [HttpPost]
        public HttpResponseMessage Crear(CrearSalaModel crearSalaModel)
        {
            bool EsProfesor = false;
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            string Dispositivo = string.Empty;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                Dispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (string.IsNullOrEmpty(Dispositivo))
                {
                    return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Dispositivo Desconocido"));
                }
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Unathorized"));
            }

            //Validar que el Host exista

            EsProfesor = (entities.RolUsuarios.Any(u => u.IdUsuario == IdUsuario && u.IdRol == (int)Roles.Profesor));

            //Crear sala y guardarla en DB
            if (EsProfesor)
            {
                Sala sala = new Sala(crearSalaModel.Nombre, DateTime.Now, crearSalaModel.Duracion, crearSalaModel.Intervalo, crearSalaModel.Host);
                entities.Salas.Add(sala);
                entities.SaveChanges();
                CalcularIntervalos(sala);
                entities.SaveChanges();

                return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Sala creada correctamente", new { sala.IdSala }));
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden, new RespuestaError("Solo los profesores pueden crear las salas"));
            }
        }
        public HttpResponseMessage Unirse(int IdSala)
        {
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            bool EstaDentro = false;
            string Dispositivo = string.Empty;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                Dispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (string.IsNullOrEmpty(Dispositivo))
                {
                    return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Dispositivo Desconocido"));
                }
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("No autorizado"));
            }

            Sala sala = entities.Salas.SingleOrDefault(e => e.IdSala == IdSala);
            //Validar si la sala existe
            if (sala == null)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new RespuestaError("El id de la sala no existe"));
            }

            //Validar si ya paso el tiempo de la sala
            TimeSpan span = DateTime.Now.Subtract(sala.MomentoInicio);
            if (span.TotalMinutes > sala.Duracion)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new RespuestaError("El tiempo de la sala se ha terminado"));
            }

            EstaDentro = entities.SalaUsuarios.Any(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);
            var Intervalos = ObternerIntervalos(sala.IdSala);
            var clase = new { sala.IdSala, sala.Nombre, sala.MomentoInicio,sala.Duracion, sala.Host, Intervalos};

            if (!EstaDentro)
            {
                SalaUsuario salaUsuario = new SalaUsuario { IdSala = IdSala, IdUsuario = IdUsuario };
                entities.SalaUsuarios.Add(salaUsuario);
                entities.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.Created, new Respuesta<object>("Se ha unido a la sala #" + IdSala + " satisfactoriamente", new { clase }));
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Ya esta dentro de la sala", new { clase }));
            }
        }

        public HttpResponseMessage Presente(int IdSala)
        {
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            bool EstaDentro = false;
            bool EstaPresente = false;
            string Dispositivo = string.Empty;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                Dispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (string.IsNullOrEmpty(Dispositivo))
                {
                    return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Dispositivo Desconocido"));
                }
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Unathorized"));
            }

            Sala sala = entities.Salas.SingleOrDefault(e => e.IdSala == IdSala);
            //Validar si la sala existe
            if (sala == null)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new RespuestaError("El id de la sala no existe"));
            }

            EstaDentro = entities.SalaUsuarios.Any(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);
            
            if (EstaDentro)
            {
                SalasIntervalos salaIntervalo = entities.SalasIntervalos.SingleOrDefault(si => si.IdSala == IdSala && si.Inicio <= DateTime.Now && si.Fin >= DateTime.Now);
                PresenciaIntervalos presenciaIntervalos = entities.PresenciaIntervalos.SingleOrDefault(pi => pi.IdSalaIntervalo == salaIntervalo.IdSalaIntervalo && pi.IdUsuario == IdUsuario);
                if(salaIntervalo != null && presenciaIntervalos == null)
                {
                    entities.PresenciaIntervalos.Add(new PresenciaIntervalos { IdSalaIntervalo = salaIntervalo.IdSalaIntervalo, IdUsuario = IdUsuario });
                    entities.SaveChanges();
                    return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Presente!", new { }));
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, new RespuestaError("Ahora no es momento de decir presente... Atienda!"));
                }

            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, new RespuestaError("No pertenece a esta sala"));
            }



        }

        private void CalcularIntervalos(Sala sala)
        {
            DateTime a = sala.MomentoInicio;
            DateTime b = a.AddMinutes(sala.Duracion - a.Minute);
            List<SalasIntervalos> c = new List<SalasIntervalos>();

            while (a < b && a.AddMinutes(sala.Intervalo) <= b)
            {
                a = a.AddMinutes(sala.Intervalo);
                c.Add(new SalasIntervalos { IdSala = sala.IdSala, Inicio = a, Fin = a.AddMinutes(2) });
            }

            entities.SalasIntervalos.AddRange(c);
        }

        private List<int> ObternerIntervalos(int idSala)
        {
            DateTime ahora = DateTime.Now;
            IEnumerable<SalasIntervalos> intervalos = entities.SalasIntervalos.Where(si => si.IdSala == idSala && si.Inicio > ahora).AsEnumerable();
            return intervalos.Select(i => Convert.ToInt32(i.Inicio.Subtract(ahora).TotalSeconds)).ToList();
        }
    }
}
