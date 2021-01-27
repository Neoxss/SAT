using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class Usuario
    {
        public string ID { get; set; }
        public string Nombre { get; set; }
        public string Matricula { get; set; }
        public string Correo { get; set; }
        public string Password { get; set; }

    }
}
