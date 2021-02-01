using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class SalaUsuario
    {

        [Key, Column("ID_Sala", Order = 0)]
        public int IdSala { get; set; }
        [Key, Column("ID_Usuario", Order = 1)]
        public string IdUsuario { get; set; }
        public bool Presente { get; set; }
    }
}
