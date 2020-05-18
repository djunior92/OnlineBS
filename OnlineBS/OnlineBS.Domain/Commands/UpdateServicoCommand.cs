using System;

namespace OnlineBS.Domain.Commands
{
    public class UpdateTituloServicoCommand : ICommand
    {
        public Guid Id { get; set; }
        public string Usuario { get; set; }
        public string Titulo { get; set; }

        public UpdateTituloServicoCommand(Guid id, string usuario, string titulo)
        {
            Id = id;
            Usuario = usuario;
            Titulo = titulo;
        }

        public bool Validate()
        {
            if (Usuario == null || Titulo == null)
                return false;

            if (Titulo.Length < 3)
                return false;

            return true;
        }
    }
}