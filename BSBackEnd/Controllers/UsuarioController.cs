using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using BSBackEnd.Models;
using BSBackEnd.Models.ViewModels;
using BSBackEnd.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace BSBackEnd.Controllers
{
    [ApiController]
    [Route("usuario")]
    public class UsuarioController : ControllerBase
    {
        [HttpPost]
        [Route("")]
        public IActionResult Create([FromBody] Usuario model, [FromServices] IUsuarioRepository repository)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            repository.Create(model);

            return Ok();
        }

        [HttpPost]
        [Route("login")]
        public IActionResult Login([FromBody] UsuarioLogin model, [FromServices] IUsuarioRepository repository)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            Usuario usuario = repository.Read(model.Email, model.Senha);
            if (usuario == null)
                return Unauthorized();

            usuario.Senha = "";
            return Ok(new
            {
                usuario = usuario,
                token = GenerateToken(usuario)
            });
        }

        [HttpPut("{id}")]
        public IActionResult Update(string id, [FromBody] Usuario model, [FromServices] IUsuarioRepository repository)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            repository.Update(new Guid(id), model);
            return Ok();
        }

        private string GenerateToken(Usuario usuario)
        {
            var TokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes("UmTokenMuitoGrandeEDiferenteParaNinguemDescobrir");


            var descriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    //ClaimTypes.Role - Ex: adicionar função/cargo do usuário para validações/permissões
                    new Claim(ClaimTypes.Name, usuario.Id.ToString()),
                }),
                Expires = DateTime.UtcNow.AddHours(5),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature
                )
            };

            var token = TokenHandler.CreateToken(descriptor);
            return TokenHandler.WriteToken(token);

        }

    }
}