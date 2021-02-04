using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class Sesion
    {
        [Key, Column("ID_Sesion")]
        public int ID { get; set; }
        public string Token { get; set; }
        public DateTime Vigencia { get; set; }
        [Column("ID_Dispositivo")]
        public int IdDispositivo { get; set; }
        public string Usuario { get; set; }
    }
}
