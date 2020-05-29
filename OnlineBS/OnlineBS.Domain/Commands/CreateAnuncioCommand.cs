using OnlineBS.Domain.Entities;

namespace OnlineBS.Domain.Commands
{
    public class CreateAnuncioCommand : ICommand
    {
        public Usuario Vendedor { get; set; }
        public string Titulo { get; set; }
        public string Descricao { get; set; }       
        public decimal Valor { get; set; }                
        public int QtdeDisponivel { get; set; }          
        public TipoEntrega RealizaEntrega { get; set; }      
        public string Foto { get; set; }                  

        public CreateAnuncioCommand(Usuario vendedor, string titulo, string descricao, decimal valor,
                                        int qtdeDisponivel, TipoEntrega realizaEntrega, string foto)
        {
            Vendedor = vendedor;
            Titulo = titulo;
            Descricao = descricao;
            Valor = valor;
            QtdeDisponivel = qtdeDisponivel;
            RealizaEntrega = realizaEntrega;
            Foto = foto;   
        }

        public bool Validate()
        {
            if (Vendedor == null || Titulo == null || Descricao == null || Valor == 0 || QtdeDisponivel == 0 
                    || QtdeDisponivel == 0 || Foto == null)
                return false;

            if (Titulo.Length < 3 || Descricao.Length < 10)
                return false;

            return true;
        }
    }
}