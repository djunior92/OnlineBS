namespace OnlineBS.Domain.Entities
{
    public class Anuncio : Entity
    {
        public Usuario Vendedor { get; set; }             //usuário cadastrante do anúncio
        public string Foto { get; set; }                  //foto do produto a ser vendido
        public string Titulo { get; set;}                 //titulo do anuncio (ex: nome do produto)
        public string Descricao { get; set; }             //descrição das características do item a ser vendido
        public decimal Valor { get; set; }                //valor unitário do produto
        public int QtdeDisponivel { get; set; }           //quantidade disponível em estoque para venda
        public bool realizaEntrega { get; set; }          //vendedor realiza entrega?
        /*public TipoRetirada TipoRetirada { get; set; }    //Forma(s) que o vendedor disponibiliza o produto - Tipo de retirada: 
                                                                            //0-retirada no local|
                                                                            //1-entrega a domicílio|
                                                                            //2-permite retirada e também realiza entrega*/
    }
}


