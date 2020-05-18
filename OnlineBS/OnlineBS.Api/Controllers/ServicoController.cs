using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using OnlineBS.Domain.Commands;
using OnlineBS.Domain.Entities;
using OnlineBS.Domain.Repositories;

namespace OnlineBS.Api.Controllers
{
    [ApiController]
    [Route("v1/servico")]
    public class ServicoController : ControllerBase
    {
        [HttpGet]
        [Route("")]
        public List<Servico> Get([FromServices]IServicoRepository repository)
        {
            return repository.Read();
        }

        /*[HttpPost]
        [Route("")]
        public void Post([FromBody]CreateServicoCommand cmd , [FromServices]IHandler handler)
        {
            handler.Handle(cmd);
        }*/
    }
}