using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess.Models
{
    public class SalasIntervalos
    {
        [Key, Column("ID_Sala_Intervalo")]
        public int IdSalaIntervalo { get; set; }
        [Column("ID_Sala")]
        public int IdSala { get; set; }
        public DateTime Inicio { get; set; }
        public DateTime Fin { get; set; }

    }
}
