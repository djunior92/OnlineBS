namespace OnlineBS.Domain.Entities
{
    public class Proposta : Entity
    {
        public string Usuario { get; set; }
        public string MyProperty { get; set; }
        public decimal Valor { get; set; }
        public bool Aceito { get; set; }

        public Servico Servico { get; set; }
    }
}