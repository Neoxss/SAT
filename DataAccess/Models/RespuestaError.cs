using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class RespuestaError
    {
        public RespuestaError(string mensaje)
        {
            Mensaje = mensaje;
        }

        public string Mensaje { get; set; }

    }
}
