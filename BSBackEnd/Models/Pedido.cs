using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BSBackEnd.Models
{
    public class Pedido
    {
        public Guid Id { get; set; }
        [Required]
        public Guid CompradorId { get; set; }        //Usuário que está realizando o pedido de compra             
        public Usuario Comprador { get; set; }       //Usuário que está realizando o pedido de compra        
        [Required]
        public Guid AnuncioId { get; set; }          //Anuncio escolhido    
        public Anuncio Anuncio { get; set; }         //Anuncio escolhido    
        [Required(ErrorMessage = "Quantidade obrigatória")]
        public int Qtde { get; set; }                //Quantidade solicitada (se existir em estoque)
        [Required(ErrorMessage = "Informe se deseja entrega")]
        public bool SolicitaEntrega { get; set; }    //Se o comprador deseja que entreguem o produto (caso o vendedor forneça entrega)
        [Required]
        public DateTime DataPedido { get; set; }
    }
}



