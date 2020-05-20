namespace OnlineBS.Domain.Entities
{
    public class Usuario : Entity       //Cadastro de usuário (o mesmo usuário pode comprar e vender produtos)
    {
        public string Login { get; set; }
        public string Senha { get; set; }
        public string Nome { get; set; }
        public string Endereco { get; set; } 
        public string Telefone { get; set; }
        /*Implementar futuramente:*/
        /*-nota_média_como_vendedor
                "após um comprador solicitar uma venda, o pedido ficará aguardando efetivação. Após o vendedor
                confirmar que o produto foi vendido (para sumir de uma listagem de pedidos aguardando a liberação
                no perfil dele) o usuário comprador poderá avaliar o vendedor.
                Caso ele não avalie porque esqueceu, não impactará negativamente na nota do vendedor pois
                só entrará nessa estatística as vendas que o usuário comprador teve interesse em dar nota"
        -vendas reportadas
                "quantidades de vendas que o usuário anunciou e não atendeu o comprador. Nesse caso não há
                nota, se a venda não se concretizar o usuário comprador pode reportar a venda
                servindo como avaliação para outros usuários que o usuário não atendeu o pedido que disponibilizou
                no anuncio"
        -compras realizadas
                "quando o vendedor anuncia um produto e um comprador realiza o pedido(venda) o vendedor recebe
                em uma listagem um item solicitado para a venda. Após ela se concretizar o vendedor tem a opção de
                efetivar o pedido (caso tenha dado certo) ou reportar o comprador (caso o comprador não apareça).
                Quando o vendedor efetiva a venda, ela some de sua listagem e com isso o comprador passa a ter
                mais uma compra realizada."
        -compras reportadas
                "são casos em que o usuário solicitou a compra mas não apareceu para retirar/não atendeu o entregador.
                Com isso o vendedor pode reportar o usuário manchando sua reputação como comprador."*/
    }
}

