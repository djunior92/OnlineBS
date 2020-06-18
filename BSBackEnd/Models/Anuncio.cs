using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BSBackEnd.Models
{
    public class Anuncio
    {
        public Guid Id {get; set;}  
        [Required]
        public Guid VendedorId { get; set; }  
        public Usuario Vendedor { get; set; }             //usuário cadastrante do anúncio       
        [Required(ErrorMessage = "Informe o título do anúncio"), MaxLength(100)]
        public string Titulo { get; set;}                 //titulo do anuncio (ex: nome do produto)
        [Required(ErrorMessage = "Informe a descrição do anúncio"), MaxLength(500)]
        public string Descricao { get; set; }             //descrição das características do item a ser vendido
        [Required(ErrorMessage = "Informe o valor")]
        public decimal Valor { get; set; }                //valor unitário do produto
        [Required(ErrorMessage = "Informe a quantidade disponível em estoque")]
        public int QtdeDisponivel { get; set; }           //quantidade disponível em estoque para venda
        [Required(ErrorMessage = "Informe se realiza entrega")]
        public bool RealizaEntrega { get; set; }         //vendedor realiza entrega? (0/false) Não - (1/true) Sim  
        public string Foto { get; set; }                  //foto do produto a ser vendido              
    }
}                                                                     