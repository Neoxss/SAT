using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace SAT.Filters
{
    public class Autenticar : ActionFilterAttribute
    {
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            var token = actionContext.Request.Headers.GetValues("token").SingleOrDefault();
            // Verificando si la acción es en login
            if (actionContext.ActionDescriptor.ActionName == "Login")
            {
                // No hacer nada
            }
            // Verificando que el header contenga el token
            else if (String.IsNullOrEmpty(token))
            {
                // Si no lo tiene devolver una excepción y no ejecutar la acción
                actionContext.Response = new System.Net.Http.HttpResponseMessage
                {
                    StatusCode = HttpStatusCode.Unauthorized,
                    ReasonPhrase = "No ha suministrado el token"
                };
            }
            else
            {
                // Obteniendo el dispositivo
                var dispositivo = actionContext.Request.Headers.GetValues("dispositivo").Single();

                // Verificando que el token sea válido o esté vigente
                var sesion = new DataAccess.SATContext().Sesiones.SingleOrDefault(s => s.Token == token);
                if (sesion == null || sesion.Vigencia < DateTime.Now)
                {
                    actionContext.Response = new System.Net.Http.HttpResponseMessage
                    {
                        StatusCode = HttpStatusCode.Unauthorized,
                        ReasonPhrase = "El token de sesion es invalido o ha expirado"
                    };
                }
                // Si el token es válido y se encuentra vigente, verificar si el dispositivo coincide
                else if (sesion.IdDispositivo != dispositivo)
                {
                    actionContext.Response = new System.Net.Http.HttpResponseMessage
                    {
                        StatusCode = HttpStatusCode.Unauthorized,
                        ReasonPhrase = "Dispositivo no autorizado"
                    };
                }
            }

            base.OnActionExecuting(actionContext);
        }
    }
}