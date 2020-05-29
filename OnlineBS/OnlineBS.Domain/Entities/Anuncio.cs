using System.Collections.Generic;

namespace OnlineBS.Domain.Entities
{
    public class Anuncio : Entity
    {
        private object vendedor;

        public Anuncio(object vendedor, string titulo, string descricao, decimal valor, int qtdeDisponivel, 
                        TipoEntrega realizaEntrega, string foto)
        {
            this.vendedor = vendedor;
            Titulo = titulo;
            Descricao = descricao;
            Valor = valor;
            QtdeDisponivel = qtdeDisponivel;
            RealizaEntrega = realizaEntrega;
            Foto = foto;
        }

        public Usuario Vendedor { get; set; }             //usuário cadastrante do anúncio
        public string Titulo { get; set;}                 //titulo do anuncio (ex: nome do produto)
        public string Descricao { get; set; }             //descrição das características do item a ser vendido
        public decimal Valor { get; set; }                //valor unitário do produto
        public int QtdeDisponivel { get; set; }           //quantidade disponível em estoque para venda
        public TipoEntrega RealizaEntrega { get; set; }          //vendedor realiza entrega? 0-Não/1-Sim
        public string Foto { get; set; }                  //foto do produto a ser vendido        
        /*public TipoRetirada TipoRetirada { get; set; }    //Forma(s) que o vendedor disponibiliza o produto - Tipo de retirada: 
                                                                            //0-retirada no local|
                                                                            //1-entrega a domicílio|
                                                                            //2-permite retirada e também realiza entrega*/

        public List<Venda> Vendas { get; set; }                                                                            
    }
}


