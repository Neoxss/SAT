using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DataAccess.Models
{
    public class Sala
    {
        public Sala(string nombre, DateTime momentoInicio, int duracion, string host)
        {
            Nombre = nombre;
            MomentoInicio = momentoInicio;
            Duracion = duracion;
            Host = host;
        }
        public Sala() { }

        [Key, Column("ID")]
        public int IdSala { get; set; }
        public string Nombre { get; set; }
        [Column("MomentoIncio")]
        public DateTime MomentoInicio { get; set; }
        public int Duracion { get; set; }
        public string Host { get; set; }
        public int Intervalo { get; set; }
    }
}
