using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BSBackEnd.Models
{
    public class Usuario
    {
        public Guid Id { get; set; }

        [Required(ErrorMessage = "Nome obrigatório"), MaxLength(100)]
        public string Nome { get; set; }

        [Required(ErrorMessage = "Email obrigatório"), MaxLength(30), ]
        public string Email { get; set; }

        [Required(ErrorMessage = "Senha obrigatória"), MaxLength(30)]
        public string Senha { get; set; }
        [MaxLength(14)]
        public string CpfCnpj { get; set; }        
        [MaxLength(100)]
        public string Endereco { get; set; }
        [MaxLength(6)]
        public string Numero { get; set; }
        [MaxLength(8)]
        public string Cep { get; set; }
        [MaxLength(50)]
        public string Bairro { get; set; }
        [MaxLength(14)]
        public string Telefone { get; set; }

        public List<Pedido> ComprasRealizadas { get; set; }

        public List<Anuncio> AnunciosRealizados { get; set; }

    }
}