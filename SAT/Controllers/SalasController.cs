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

            if (Request.Headers.Contains("usuario"))
            {
                Token = Request.Headers.GetValues("usuario").First();
                IdUsuario = entities.Usuarios.SingleOrDefault(u => u.Nombre == Token).ID;
            }

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

            if (Request.Headers.Contains("usuario"))
            {
                Token = Request.Headers.GetValues("usuario").First();
                IdUsuario = entities.Usuarios.SingleOrDefault(u => u.Nombre == Token).ID;
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
    }
}
