using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models.DTOs
{
    public class ListaEstudiante
    {
        public int IdSala { get; set; }
        public List<bool> Presencia { get; set; }
        public string Correo { get; set; }
        public string Matricula { get; set; }
        public string  Nombre { get; set; }
        public string IdUsuario { get; set; }

    }
}
