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
                    return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Dispositivo Desconocido"));
                }
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Unathorized"));
            }

            if (entities.SalaUsuarios.FirstOrDefault(e => e.IdSala == idSala) == null)
            {
                //No se encontro ninguna sala con ese ID
                return Request.CreateResponse(HttpStatusCode.NotFound, new RespuestaError("No se encontro una sala con ese ID"));
            }

            var estudiantes = (from sala in entities.SalaUsuarios
                               where sala.IdSala == idSala
                               select new { sala.IdSala, 
                                            sala.Presente,
                                            sala.Usuarios.Correo,
                                            sala.Usuarios.Matricula,
                                            sala.Usuarios.Nombre}).ToList();

            return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Lista de usuarios de la clase", new { estudiantes }));

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
                    return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Dispositivo Desconocido"));
                }
                IdUsuario = entities.Sesiones.SingleOrDefault(u => u.Token == Token && u.IdDispositivo == Dispositivo).Usuario;
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Unathorized"));
            }

            if (entities.Usuarios.FirstOrDefault(e => e.IdUsuario == id) == null)
            {
                //No se encontro ninguna sala con ese ID
                return Request.CreateResponse(HttpStatusCode.NotFound, new RespuestaError("No se encontro ninguna sala con ese ID"));
            }

            var estudiante = entities.Usuarios.FirstOrDefault(u => u.IdUsuario == id);

            return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Estudiante encontrado", new { estudiante }));
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
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new RespuestaError(e.Message));
            }
        }
        [HttpPost]
        public HttpResponseMessage Login(LoginModel loginModel)
        {
            SATContext entities = new SATContext();
            string Token = string.Empty;
            string IdUsuario = string.Empty;
            string Dispositivo = string.Empty;
            bool EsProfesor = false;
            if (Request.Headers.Contains("dispositivo"))
            {
                string IdDispositivo = Request.Headers.GetValues("dispositivo").FirstOrDefault();
                if (string.IsNullOrEmpty(IdDispositivo))
                {
                    return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Dispositivo Desconocido"));
                }
                Dispositivo = (IdDispositivo);
            }
            else
            {
                //No esta autorizado para entrar
                return Request.CreateResponse(HttpStatusCode.Unauthorized, new RespuestaError("Unathorized"));
            }

            var user = entities.Usuarios.FirstOrDefault(e => e.Correo == loginModel.Correo && e.Password == loginModel.Password);

            //Validar si es estudiante o profesor
            EsProfesor = (entities.RolUsuarios.Any(u => u.IdUsuario == user.IdUsuario && u.IdRol == (int)Roles.Profesor));

            if (user != null)
            {
                string token = GenerarToken(user.IdUsuario, Dispositivo);
                var usuario = new { user.Correo, user.Nombre, user.Matricula, EsProfesor};
                return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Logeado correctamente", new {usuario , token }));
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound, new RespuestaError("Usuario no encontrado"));
            }
        }

        private string GenerarToken(string usuario, string idDispositivo)
        {
            SATContext entities = new SATContext();

            string tokenGenerado = Guid.NewGuid().ToString();

            Sesion sesion = new Sesion
            {
                Usuario = usuario,
                IdDispositivo = idDispositivo,
                Vigencia = DateTime.Now,
                Token = tokenGenerado
            };
            entities.Sesiones.Add(sesion);
            entities.SaveChanges();

            return tokenGenerado;
        }
    }
}
