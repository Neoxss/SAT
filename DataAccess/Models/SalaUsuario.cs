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
    public class SalaUsuario
    {

        [Key, Column("ID_Salas_Usuarios")]
        public int IdSalasUsuarios { get; set; }
        [Column("ID_Sala")]
        [ForeignKey("Salas")]
        public int IdSala { get; set; }
        [Column("ID_Usuario")]
        [ForeignKey("Usuarios")]
        public string IdUsuario { get; set; }
        public bool Presente { get; set; }


        [JsonIgnore]
        public virtual Usuario Usuarios { get; set; }
        [JsonIgnore]
        public virtual Sala Salas { get; set; }
    }
}
