namespace OnlineBS.Domain.Commands
{
    public class CreateServicoCommand : ICommand
    {
        public string Usuario { get; set; }
        public string Titulo { get; set; }
        public string Descricao { get; set; }

        public CreateServicoCommand(string usuario, string titulo, string descricao)
        {
            Usuario = usuario;
            Titulo = titulo;
            Descricao = descricao;
        }

        public bool Validate()
        {
            if (Usuario == null || Titulo == null || Descricao == null)
                return false;

            if (Titulo.Length < 3 || Descricao.Length < 10)
                return false;

            return true;
        }
    }
}