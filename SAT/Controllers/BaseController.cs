using DataAccess;
using SAT.Filters;
using System.Linq;
using System.Web.Http;

namespace SAT.Controllers
{
    [ValidarDispositivo]
    [Autenticar]
    public class BaseController : ApiController
    {
        protected SATContext entities = new SATContext();
        public string Dispositivo
        {
            get
            {
                return Request.Headers.GetValues("dispositivo").Single();
            }
        }
        public string IdUsuario
        {
            get
            {
                string token = Request.Headers.GetValues("token").SingleOrDefault();
                return entities.Sesiones.SingleOrDefault(s => s.Token == token)?.Usuario;
            }
        }
    }
}