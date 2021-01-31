using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class RolUsuario
    {
        [Key, Column("ID_Usuario" ,Order = 0) ]
        public string IdUsuario { get; set; }
        [Key, Column("ID_Rol",Order = 1)]
        public int IdRol { get; set; }
    }
}
