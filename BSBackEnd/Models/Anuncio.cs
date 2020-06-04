using System;
using System.ComponentModel.DataAnnotations;

namespace BSBackEnd.Models
{
    public class Anuncio
    {
        public Guid Id {get; set;}
        public Guid VendedorId { get; set; }                //usuário cadastrante do anúncio        
        [Required]
        public string Titulo { get; set;}                 //titulo do anuncio (ex: nome do produto)
        [Required]
        public decimal Valor { get; set; }                //valor unitário do produto
        [Required]
        public int QtdeDisponivel { get; set; }           //quantidade disponível em estoque para venda
       
        /*
        public string Descricao { get; set; }             //descrição das características do item a ser vendido
        public TipoEntrega RealizaEntrega { get; set; }          //vendedor realiza entrega? 0-Não/1-Sim
        public string Foto { get; set; }                  //foto do produto a ser vendido        
        //public TipoRetirada TipoRetirada { get; set; }    //Forma(s) que o vendedor disponibiliza o produto - Tipo de retirada: 
        //                                                                    //0-retirada no local|
        //                                                                    //1-entrega a domicílio|
        //                                                                    //2-permite retirada e também realiza entrega

        public List<Venda> Vendas { get; set; }*/       
    }
}                                                                     