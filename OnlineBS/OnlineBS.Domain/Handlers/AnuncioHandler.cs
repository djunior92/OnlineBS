using OnlineBS.Domain.Commands;
using OnlineBS.Domain.Entities;
using OnlineBS.Domain.Repositories;

namespace OnlineBS.Domain.Handlers
{
    public class AnuncioHandler :
        IHandler<CreateAnuncioCommand>
    {

        private readonly IAnuncioRepository _repository;

        public AnuncioHandler(IAnuncioRepository repository)
        {
            _repository = repository;
        }

        public ICommandResult Handle(CreateAnuncioCommand command)
        {
            if(!command.Validate())
                return new CommandResult("error", "Falha ao criar um anúncio", command);
        
            var anuncio = new Anuncio(command.Vendedor, command.Titulo, command.Descricao, command.Valor, command.QtdeDisponivel, 
                                        command.RealizaEntrega, command.Foto);
            
            _repository.Create(anuncio);

            return new CommandResult("success", "Anúncio criado com sucesso", anuncio);
        }
    }
}