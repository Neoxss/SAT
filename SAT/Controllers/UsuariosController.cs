using DataAccess;
using DataAccess.Models;
using SAT.Filters;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace SAT.Controllers
{
    public class UsuariosController : BaseController
    {

        [Autorizar(Rol = Roles.Profesor)]
        [HttpGet]
        public HttpResponseMessage ListaEstudiantes(int idSala)
        {
            Sala sala = entities.Salas.SingleOrDefault(s => s.IdSala == idSala);
            if (sala == null)
            {
                //No se encontro ninguna sala con ese ID
                return Request.CreateResponse(HttpStatusCode.NotFound, new RespuestaError("No se encontro una sala con ese ID"));
            }
            else if (sala.Host != IdUsuario)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound, new RespuestaError("No es dueño de esta sala"));
            }

            List<bool> a = new List<bool>();
            var estudiantes = (from s in entities.SalaUsuarios
                               where s.IdSala == idSala
                               select new
                               {
                                   s.IdSala,
                                   presente = a,
                                   s.Usuarios.Correo,
                                   s.Usuarios.Matricula,
                                   s.Usuarios.Nombre,
                                   s.Usuarios.IdUsuario
                               }).ToList();

            estudiantes.ForEach(e => e.presente.AddRange((from si in entities.SalasIntervalos
                                                          join prein in entities.PresenciaIntervalos
                                                          on si.IdSalaIntervalo equals prein.IdSalaIntervalo
                                                          into lj
                                                          from pi in lj.DefaultIfEmpty()
                                                          where si.IdSala == idSala && pi.IdUsuario == e.IdUsuario
                                                          select pi != null).ToList()));

            return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Lista de usuarios de la clase", new { estudiantes }));

        }

        [Autorizar(Rol = Roles.Profesor)]
        [HttpGet]
        public HttpResponseMessage ObtenerUsuarioPorId(string id)
        {
            var estudiante = entities.Usuarios.SingleOrDefault(u => u.IdUsuario == id);

            if (estudiante == null)
            {
                //No se encontro ninguna sala con ese ID
                return Request.CreateResponse(HttpStatusCode.NotFound, new RespuestaError("No se encontro ninguna sala con ese ID"));
            }

            return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Estudiante encontrado", new { estudiante }));
        }

        [HttpPost]
        public HttpResponseMessage CrearUsuario(Usuario usuario)
        {
            //Este metodo es un metodo para fines de pruebas.
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
            var user = entities.Usuarios.SingleOrDefault(e => e.Correo == loginModel.Correo && e.Password == loginModel.Password);

            if (user != null)
            {
                //Validar si es estudiante o profesor
                bool esProfesor = (entities.RolUsuarios.Any(u => u.IdUsuario == user.IdUsuario && u.IdRol == (int)Roles.Profesor));

                string token = GenerarToken(user.IdUsuario, Dispositivo);
                var usuario = new { user.IdUsuario, user.Correo, user.Nombre, user.Matricula, esProfesor };
                return Request.CreateResponse(HttpStatusCode.OK, new Respuesta<object>("Logeado correctamente", new { usuario, token }));
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound, new RespuestaError("Usuario no encontrado"));
            }
        }

        private string GenerarToken(string usuario, string idDispositivo)
        {
            // Generar token "random"
            string tokenGenerado = Guid.NewGuid().ToString();

            // Buscar sesión existente
            Sesion sesion = entities.Sesiones.SingleOrDefault(s => s.Usuario == usuario);

            // Si existe una sesión anterior, actualizar token
            if (sesion != null)
            {
                sesion.Token = tokenGenerado;
                sesion.Vigencia = DateTime.Now.AddHours(24);

                entities.Entry<Sesion>(sesion).State = EntityState.Modified;
            }
            // Si no existe una sesión, crearla
            else
            {
                sesion = new Sesion
                {
                    Usuario = usuario,
                    IdDispositivo = idDispositivo,
                    Token = tokenGenerado,
                    Vigencia = DateTime.Now.AddHours(24)
                };

                entities.Sesiones.Add(sesion);
            }

            entities.SaveChanges();
            return tokenGenerado;
        }
    }
}
