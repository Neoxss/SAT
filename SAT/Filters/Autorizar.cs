using System.Linq;
using System.Net;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace SAT.Filters
{
    public class Autorizar : AuthorizationFilterAttribute
    {
        public DataAccess.Models.Roles Rol { get; set; }
        public override void OnAuthorization(HttpActionContext actionContext)
        {
            // Obteniendo la propiedad IdUsuario (desde el baseController)
            var idUsuario = ((Controllers.BaseController)actionContext.ControllerContext.Controller).IdUsuario;
            // Obteniendo los roles del usuario en base de datos
            var rolesUsuario = new DataAccess.SATContext().RolUsuarios.Where(ru => ru.IdUsuario == idUsuario).Select(ru => ru.IdRol).ToArray();

            // Si el usuario no posee el rol requerido, devolver excepción
            if (!rolesUsuario.Contains((int)Rol))
            {
                actionContext.Response = new System.Net.Http.HttpResponseMessage
                {
                    StatusCode = HttpStatusCode.Forbidden,
                    ReasonPhrase = "No cuenta con los privilegios para acceder a esta función"
                };
            }

            base.OnAuthorization(actionContext);
        }
    }
}