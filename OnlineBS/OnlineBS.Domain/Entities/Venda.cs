namespace OnlineBS.Domain.Entities
{
    public class Venda : Entity
    {
        public Usuario Comprador { get; set; }      //Usuário que está realizando o pedido de compra
        public Anuncio Anuncio { get; set; }        //Anuncio escolhido
        public int Qtde { get; set; }               //Quantidade solicitada (se existir em estoque)
        public bool SolicitaEntrega { get; set; }   //Se o comprador deseja que entreguem o produto (caso o vendedor forneça entrega)
        
        /*Implementar futuramente*/
        /*-efetivação
                (dono do anúncio confirma que a venda foi efetivada) //informação para classificar vendedor/comprados*/ 
    }
}