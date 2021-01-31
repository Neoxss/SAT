using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class Sala
    {
        public Sala(string nombre, string momentoInicio, string duracion, string host)
        {
            Nombre = nombre;
            MomentoInicio = momentoInicio;
            Duracion = duracion;
            Host = host;
        }

        public int ID { get; set; }
        public string Nombre { get; set; }
        [Column("MomentoIncio")]
        public string MomentoInicio { get; set; }
        public string Duracion { get; set; }
        public string Host { get; set; }

    }
}
