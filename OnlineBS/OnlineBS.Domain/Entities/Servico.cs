using System.Collections.Generic;

namespace OnlineBS.Domain.Entities
{
    public class Servico : Entity
    {
        public string Usuario { get; private set; }
        public string Titulo { get; private set; }
        public string Descricao { get; private set; }
        public Status Status { get; private set; }

        public Servico(string usuario, string titulo, string descricao)
        {
            Usuario = usuario;
            Titulo = titulo;
            Descricao = descricao;
            Status = Status.Aberto;
        }

        public void DefinirServicoComoAberto()
        {
            Status = Status.Aberto;
        }

        public void DefinirServicoComoFechado()
        {
            Status = Status.Fechado;
        }

        public void AlterarTitulo(string titulo) {
            Titulo = titulo;
        }

        public void AlterarDescricao(string descricao) {
            Descricao = descricao;
        }

        //public List<Proposta> Propostas { get; set; }
    }
}