using DataAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace SAT.Controllers
{
    public class UsuariosController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage ListaEstudiantes(int idSala)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            string Dispositivo = string.Empty;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                Dispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (string.IsNullOrEmpty(Dispositivo))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Dispositivo Desconocido");
                }
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Unathorized");
            }

            if (entities.SalaUsuarios.FirstOrDefault(e => e.IdSala == idSala) == null)
            {
                //No se encontro ninguna sala con ese ID
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, "No se encontro una sala con ese ID");
            }

            var usuarios = (from sala in entities.SalaUsuarios
                               where sala.IdSala == idSala
                               select new { sala.IdSala, 
                                            sala.Presente,
                                            sala.Usuarios.Correo,
                                            sala.Usuarios.Matricula,
                                            sala.Usuarios.Nombre}).ToList();

            return Request.CreateResponse(HttpStatusCode.OK, usuarios);
        }
        [HttpGet]
        public HttpResponseMessage ObtenerUsuarioPorId(string id)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            string Dispositivo = string.Empty;
            if (Request.Headers.Contains("token") && Request.Headers.Contains("dispositivo"))
            {
                Token = Request.Headers.GetValues("token").FirstOrDefault();
                Dispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (string.IsNullOrEmpty(Dispositivo))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Dispositivo Desconocido");
                }
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Unathorized");
            }

            if (entities.Usuarios.FirstOrDefault(e => e.IdUsuario == id) == null)
            {
                //No se encontro ninguna sala con ese ID
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, "No se encontro ninguna sala con ese ID");
            }

            var usuario = entities.Usuarios.FirstOrDefault(u => u.IdUsuario == id);

            return Request.CreateResponse(HttpStatusCode.OK, usuario);
        }

        [HttpPost]
        public HttpResponseMessage Post(Usuario usuario)
        {

            //Validar que no se creen usuarios repetidos
            try
            {
                using (SATContext entities = new SATContext())
                {
                    entities.Usuarios.Add(usuario);
                    entities.SaveChanges();
                    return Request.CreateResponse(HttpStatusCode.OK, "success");
                }
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, e);
            }
        }
        [HttpPost]
        public HttpResponseMessage Login(LoginModel loginModel)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            string Dispositivo = string.Empty;
            if (Request.Headers.Contains("dispositivo"))
            {
                string IdDispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (string.IsNullOrEmpty(IdDispositivo))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Dispositivo Desconocido");
                }
                Dispositivo = (IdDispositivo);
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateErrorResponse(HttpStatusCode.Unauthorized, "Unathorized");
            }

            var user = entities.Usuarios.FirstOrDefault(e => e.Correo == loginModel.Correo && e.Password == loginModel.Password);
            if (user != null)
            {
                string token = GenerarToken(user.IdUsuario, Dispositivo);
                return Request.CreateResponse(HttpStatusCode.OK, new { token });
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, "Usuario no encontrado");
            }
        }

        private string GenerarToken(string usuario, string idDispositivo)
        {
            SATContext entities = new SATContext();
            bool existe = false;

            string tokenGenerado = Guid.NewGuid().ToString();
            
            Sesion sesion = new Sesion();
            sesion.Usuario = usuario;
            sesion.IdDispositivo = idDispositivo;
            sesion.Vigencia = DateTime.Now;
            sesion.Token = tokenGenerado;
            entities.Sesiones.Add(sesion);
            entities.SaveChanges();

            return tokenGenerado;
        }
    }
}
