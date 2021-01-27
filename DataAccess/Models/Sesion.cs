using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models
{
    public class Sesion
    {
        public int ID { get; set; }
        public string Token { get; set; }
        public DateTime Vigencia { get; set; }
        public int Usuario { get; set; }
    }
}
