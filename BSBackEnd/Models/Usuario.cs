using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BSBackEnd.Models
{
    public class Usuario
    {
        public Guid Id { get; set; }

        [Required, MaxLength(100)]
        public string Nome { get; set; }

        [Required, MaxLength(30)]
        public string Email { get; set; }

        [Required, MaxLength(30)]
        public string Senha { get; set; }

        public List<Pedido> ComprasRealizadas { get; set; }

        public List<Anuncio> AnunciosRealizados { get; set; }

    }
}