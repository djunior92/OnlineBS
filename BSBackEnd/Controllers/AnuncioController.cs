using System;
using BSBackEnd.Models;
using BSBackEnd.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BSBackEnd.Controllers
{
    [Authorize]
    [ApiController]
    [Route("anuncio")]
    public class AnuncioController: ControllerBase
    {
        //[AllowAnonymous] - permite login anônimo (sem token)
        [HttpGet]
        public IActionResult Read([FromServices]IAnuncioRepository repository)
        {
            var Id = new Guid(User.Identity.Name);

            var anuncios = repository.Read(Id);
            return Ok(anuncios);
        }

        [HttpPost]
        public IActionResult Create([FromBody]Anuncio model, [FromServices]IAnuncioRepository repository){
            if(!ModelState.IsValid)
                return BadRequest();

            model.VendedorId = new Guid(User.Identity.Name);

            repository.Create(model);
            return Ok();
        }

        [HttpPut("{id}")]
        public IActionResult Update(string id, [FromBody]Anuncio model, [FromServices]IAnuncioRepository repository)
        {
            if(!ModelState.IsValid)
                return BadRequest();

                repository.Update(new Guid(id), model);
                return Ok();
        }   

        [HttpDelete("{id}")]
        public IActionResult Delete(string id, [FromServices]IAnuncioRepository repository)
        {
                repository.Delete(new Guid(id));
                return Ok();
        }              

    }
}