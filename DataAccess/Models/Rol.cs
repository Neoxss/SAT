using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class Rol
    {
        [Column("ID_Rol")]
        public int ID { get; set; }
        public string Descripcion { get; set; }

    }
}
