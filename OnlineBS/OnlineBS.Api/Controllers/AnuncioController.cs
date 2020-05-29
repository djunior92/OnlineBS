using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using OnlineBS.Domain.Commands;
using OnlineBS.Domain.Entities;
using OnlineBS.Domain.Repositories;

namespace OnlineBS.Api.Controllers
{
    [ApiController]
    [Route("v1/anuncio")]
    public class AnuncioController : ControllerBase
    {
        [HttpGet]
        [Route("")]
        public List<Anuncio> Get([FromServices]IAnuncioRepository repository)
        {
            return repository.Read();
        }

        /*[HttpPost]
        [Route("")]
        public void Post([FromBody]CreateAnuncioCommand cmd , [FromServices]IHandler handler)
        {
            handler.Handle(cmd);
        }*/
    }
}