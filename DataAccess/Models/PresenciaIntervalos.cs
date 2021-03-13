using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess.Models
{
    public class PresenciaIntervalos
    {
        [Key, Column("ID_Presencia_Intervalo")]
        public int IdPresenciaIntervalo { get; set; }
        [Column("ID_Usuario")]
        public string IdUsuario { get; set; }
        [Column("ID_Sala_Intervalo")]
        public int IdSalaIntervalo { get; set; }
    }
}
