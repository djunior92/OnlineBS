using System;
using System.Threading.Tasks;
using BSBackEnd.Models;
using BSBackEnd.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BSBackEnd.Controllers
{
    [Authorize]
    [ApiController]
    [Route("pedido")]
    public class PedidoController : ControllerBase
    {
        //[AllowAnonymous] - permite login anônimo (sem token)
        [HttpGet]
        public IActionResult Read([FromServices] IPedidoRepository repository)
        {
            var Id = new Guid(User.Identity.Name);
            var pedidos = repository.Read(Id);
            return Ok(pedidos);
        }

        [HttpGet("vendas")]
        public IActionResult ReadVendas([FromServices] IPedidoRepository repository)
        {
            var Id = new Guid(User.Identity.Name);
            var pedidos = repository.ReadVendas(Id);
            return Ok(pedidos);
        }

        [HttpPost]
        public IActionResult Create([FromBody] Pedido model, [FromServices] IPedidoRepository repository)
        {
            if (!ModelState.IsValid ||
                repository.DisponibilidadeEntrega(model) == false ||
                repository.QuantidadeValida(model) == false
                )
                return BadRequest();

            model.CompradorId = new Guid(User.Identity.Name);

            repository.Create(model);
            return Ok();
        }

        [HttpPut("{id}")]
        public IActionResult Update(string id, [FromBody] Pedido model, [FromServices] IPedidoRepository repository)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            repository.Update(new Guid(id), model);
            return Ok();
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(string id, [FromServices] IPedidoRepository repository)
        {
            repository.Delete(new Guid(id));
            return Ok();
        }

    }
}