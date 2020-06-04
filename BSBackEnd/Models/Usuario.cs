using System;
using System.ComponentModel.DataAnnotations;

namespace BSBackEnd.Models
{
    public class Usuario
    {
        public Guid Id { get; set; }

        [Required]
        public string Nome { get; set; }

        [Required]
        public string Email { get; set; }

        [Required]
        public string Senha { get; set; }

    }
}