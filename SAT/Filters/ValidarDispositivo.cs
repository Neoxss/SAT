using System.Linq;
using System.Net;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace SAT.Filters
{
    public class ValidarDispositivo : ActionFilterAttribute
    {
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            var dispositivo = actionContext.Request.Headers.GetValues("dispositivo").SingleOrDefault();
            // Verificando que el header contenga el dispositivo
            if (string.IsNullOrEmpty(dispositivo))
            {
                //Si no lo tiene devolver una excepción y no ejecutar la acción
                actionContext.Response = new System.Net.Http.HttpResponseMessage
                {
                    StatusCode = HttpStatusCode.Unauthorized,
                    ReasonPhrase = "No ha suministrado el dispositivo"
                };
            }

            base.OnActionExecuting(actionContext);
        }
    }
}