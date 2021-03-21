using DataAccess;
using DataAccess.Models;
using DataAccess.Models.DTOs;
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

            var estudiantes = (from s in entities.SalaUsuarios
                               where s.IdSala == idSala
                               select new ListaEstudiante
                               {
                                   IdSala = s.IdSala,
                                   Correo = s.Usuarios.Correo,
                                   Matricula = s.Usuarios.Matricula,
                                   Nombre = s.Usuarios.Nombre,
                                   IdUsuario = s.Usuarios.IdUsuario
                               }).ToList();

            estudiantes.ForEach(e =>
            {
                e.Presencia = new List<bool>();

                e.Presencia.AddRange((from si in entities.SalasIntervalos
                                      join prein in entities.PresenciaIntervalos
                                      on new { si.IdSalaIntervalo, e.IdUsuario } equals
                                         new { prein.IdSalaIntervalo, prein.IdUsuario }

                                      into lj
                                      from pi in lj.DefaultIfEmpty()
                                      where si.IdSala == idSala
                                      select pi != null).ToList());
            });

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
                bool EsProfesor = (entities.RolUsuarios.Any(u => u.IdUsuario == user.IdUsuario && u.IdRol == (int)Roles.Profesor));

                string token = GenerarToken(user.IdUsuario, Dispositivo);
                var usuario = new { user.IdUsuario, user.Correo, user.Nombre, user.Matricula, EsProfesor };
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
