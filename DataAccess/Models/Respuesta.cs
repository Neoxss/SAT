using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class Respuesta<T>
    {
        public Respuesta(string mensaje, T data)
        {
            Mensaje = mensaje;
            Data = data;
        }

        public string Mensaje { get; set; }
        public T Data { get; set; }
    }
}
