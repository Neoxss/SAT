using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class Usuario
    {
        [Key, Column("ID_Usuario")]
        public string IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Matricula { get; set; }
        public string Correo { get; set; }
        public string Password { get; set; }


    }
}
