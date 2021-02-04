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
        public IHttpActionResult Crear()
        {
            SATContext entities = new SATContext();
            bool EsProfesor = false;
            string Token = string.Empty;
            string IdUsuario = string.Empty;

            if (Request.Headers.Contains("token"))
            {
                Token = Request.Headers.GetValues("token").First();
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token).Usuario;
            }
            else
            {
                return Unauthorized();
            }

            //TODO: Agregar los Roles como Enum en el proyecto
            EsProfesor = (entities.RolUsuarios.Any(u => u.IdUsuario == IdUsuario && u.IdRol == 2));

            //Crear sala y guardarla en DB
            if (EsProfesor && !string.IsNullOrEmpty(Token))
            {
                try
                {
                    Sala sala = new Sala("Sala del Profesor X", "", "", IdUsuario);
                    entities.Salas.Add(sala);
                    entities.SaveChanges();

                    //TODO: Transformar el UserName en Token 
                    //TODO: TERMINAR EL MVP
                    //TODO: Estandarizar los Request y Estandarizar los response

                    return Ok(sala.ID);
                }
                catch (Exception e)
                {
                    return Ok(e);
                }
            }
            return NotFound();
        }
        public IHttpActionResult Unirse(int IdSala)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            bool EstaDentro = false;

            if (Request.Headers.Contains("token"))
            {
                Token = Request.Headers.GetValues("token").First();
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token).Usuario;
            }
            else
            {
                return Unauthorized();
            }

            EstaDentro = entities.SalaUsuarios.Any(e => e.IdSala == IdSala && e.IdUsuario == IdUsuario);

            if (!EstaDentro)
            {
                SalaUsuario salaUsuario = new SalaUsuario();
                salaUsuario.IdSala = IdSala;
                salaUsuario.IdUsuario = IdUsuario;
                entities.SalaUsuarios.Add(salaUsuario);
                entities.SaveChanges();
                return Ok();
            }
            return NotFound();
        }

        public IHttpActionResult Presente(PresenteModel presenteModel)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            bool EstaDentro = false;

            if (Request.Headers.Contains("token"))
            {
                Token = Request.Headers.GetValues("token").First();
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token).Usuario;
            }
            else
            {
                return Unauthorized();
            }

            EstaDentro = entities.SalaUsuarios.Any(e => e.IdSala == presenteModel.IdSala && e.IdUsuario == IdUsuario);

            if (EstaDentro)
            {
                SalaUsuario salaUsuario = new SalaUsuario();
                salaUsuario.IdSala = presenteModel.IdSala;
                salaUsuario.IdUsuario = IdUsuario;
                salaUsuario.Presente = presenteModel.Presente;
                entities.SalaUsuarios.Add(salaUsuario);
                entities.SaveChanges();
                return Ok();
            }
            return NotFound();
        }
    }
}
