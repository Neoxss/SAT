using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess.Models
{
    public class Sala
    {
        public Sala(string nombre, DateTime momentoInicio, int duracion, int intervalo, string host)
        {
            Nombre = nombre;
            MomentoInicio = momentoInicio;
            Duracion = duracion;
            Host = host;
            Intervalo = intervalo;
        }
        public Sala() { }

        [Key, Column("ID_Sala")]
        public int IdSala { get; set; }
        public string Nombre { get; set; }
        [Column("MomentoIncio")]
        public DateTime MomentoInicio { get; set; }
        public int Duracion { get; set; }
        [ForeignKey("Usuario")]
        public string Host { get; set; }
        public int Intervalo { get; set; }

        [JsonIgnore]
        public virtual Usuario Usuario { get; set; }
    }
}
