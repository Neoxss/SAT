using DataAccess;
using DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace SAT.Controllers
{
    public class UsuariosController : ApiController
    {
        [HttpGet]
        public IHttpActionResult Get()
        {
            using (SATContext entities = new SATContext())
            {
                List<Usuario> usuarios = entities.Usuarios.ToList();
                return Ok(usuarios);
            }
        }
        [HttpGet]
        public Usuario Get(int id)
        {
            using (SATContext entities = new SATContext())
            {
                return entities.Usuarios.FirstOrDefault(e => e.ID == id.ToString());
            }
        }

        [HttpPost]
        public IHttpActionResult Post(Usuario usuario)
        {
            try
            {
                using (SATContext entities = new SATContext())
                {
                    entities.Usuarios.Add(usuario);
                    entities.SaveChanges();
                    return Ok();
                }
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }
        [HttpPost]
        public IHttpActionResult Login(LoginModel loginModel)
        {
            try
            {
                using (SATContext entities = new SATContext())
                {

                    var user = entities.Usuarios.FirstOrDefault(e => e.Correo == loginModel.Correo && e.Password == loginModel.Password );
                    if(user != null)
                    {
                        string token = generarToken(user.ID, loginModel.IdDispositivo);
                        return Ok(new { token });
                    }
                    else
                    {
                        return NotFound();
                    }
                }
            }
            catch (Exception e)
            {
                return Ok(e);
            }
        }

        //True token generado, si no, no se genera el token
        private string generarToken(string usuario, int idDispositivo)
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
