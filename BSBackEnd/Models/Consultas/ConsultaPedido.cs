using System;

namespace BSBackEnd.Models.Consultas
{
    public class ConsultaPedido
    {
        public Guid Codigo{ get; set; }
        public Guid AnuncioId { get; set; }
        public string DesAnuncio{ get; set; }
    }

}