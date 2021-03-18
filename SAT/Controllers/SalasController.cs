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
    public class SalasController : BaseController
    {
        [HttpPost]
        public HttpResponseMessage Crear(CrearSalaModel crearSalaModel)
        {
            //Validar que el Host exista
            bool EsProfesor = (entities.RolUsuarios.Any(u => u.IdUsuario == IdUsuario && u.IdRol == (int)Roles.Profesor));

            //Crear sala y guardarla en DB
            if (EsProfesor)
            {
                Sala sala = new Sala(crearSalaModel.Nombre, DateTime.Now, crearSalaModel.Duracion, crearSalaModel.Intervalo, IdUsuario);
                entities.Salas.Add(sala);
                entities.SaveChanges();
                CalcularIntervalos(sala);
                entities.SaveChanges();

                return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Sala creada correctamente", new { sala.IdSala, sala.Nombre }));
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden, new RespuestaError("Solo los profesores pueden crear las salas"));
            }
        }
        public HttpResponseMessage Unirse(int IdSala)
        {
            // TODO: Agregar validación para que el profesor no se una como estudiante
            if (!ValidarSala(IdSala))
            {
                return SalaInvalida();
            }

            Sala sala = entities.Salas.SingleOrDefault(e => e.IdSala == IdSala);

            //Validar si ya paso el tiempo de la sala
            TimeSpan span = DateTime.Now.Subtract(sala.MomentoInicio);
            if (span.TotalMinutes > sala.Duracion)
            {
                return Request.CreateResponse(HttpStatusCode.OK, new RespuestaError("El tiempo de la sala se ha terminado"));
            }

            SalaUsuario salaUsuario = entities.SalaUsuarios.SingleOrDefault(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);
            var Intervalos = ObternerIntervalos(sala.IdSala);
            var clase = new { sala.IdSala, sala.Nombre, sala.MomentoInicio, sala.Duracion, sala.Host, Intervalos };

            // TODO: Eliminar campo Presente de SalaUsuario, agregar dispositivo (para validar que se una siempre desde el mismo), 
            //  Agregar momento de unión

            // Validar si está unido a la sala
            if (salaUsuario == null)
            {
                // Si no está en la sala se procede a unirle                
                salaUsuario = new SalaUsuario { IdSala = IdSala, IdUsuario = IdUsuario };
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
            if (!ValidarSala(IdSala))
            {
                return SalaInvalida();
            }

            bool EstaDentro = entities.SalaUsuarios.Any(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);

            if (EstaDentro)
            {
                SalasIntervalos salaIntervalo = entities.SalasIntervalos.SingleOrDefault(si => si.IdSala == IdSala && si.Inicio <= DateTime.Now && si.Fin >= DateTime.Now);
                if (salaIntervalo != null)
                {
                    bool estaPresente = entities.PresenciaIntervalos.Any(pi => pi.IdSalaIntervalo == salaIntervalo.IdSalaIntervalo && pi.IdUsuario == IdUsuario);
                    if (!estaPresente)
                    {
                        entities.PresenciaIntervalos.Add(new PresenciaIntervalos { IdSalaIntervalo = salaIntervalo.IdSalaIntervalo, IdUsuario = IdUsuario });
                        entities.SaveChanges();
                        return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Presente!", ""));
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.BadRequest, new RespuestaError("Ya estas presente!"));
                    }
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

        private bool ValidarSala(int IdSala)
        {
            return entities.Salas.Any(e => e.IdSala == IdSala);
        }

        private HttpResponseMessage SalaInvalida()
        {
            return Request.CreateResponse(HttpStatusCode.OK, new RespuestaError("El id de la sala no existe"));
        }

        private void CalcularIntervalos(Sala sala)
        {
            DateTime momentoInicio = sala.MomentoInicio;
            DateTime intervaloActual = momentoInicio.AddMinutes(sala.Duracion - momentoInicio.Minute);
            List<SalasIntervalos> intervalos = new List<SalasIntervalos>();

            while (momentoInicio < intervaloActual && momentoInicio.AddMinutes(sala.Intervalo) <= intervaloActual)
            {
                momentoInicio = momentoInicio.AddMinutes(sala.Intervalo);
                intervalos.Add(new SalasIntervalos { IdSala = sala.IdSala, Inicio = momentoInicio, Fin = momentoInicio.AddMinutes(2) });
            }

            entities.SalasIntervalos.AddRange(intervalos);
        }

        private List<int> ObternerIntervalos(int idSala)
        {
            DateTime ahora = DateTime.Now;
            IEnumerable<SalasIntervalos> intervalos = entities.SalasIntervalos.Where(si => si.IdSala == idSala && si.Inicio > ahora).AsEnumerable();
            return intervalos.Select(i => Convert.ToInt32(i.Inicio.Subtract(ahora).TotalSeconds)).ToList();
        }
    }
}
