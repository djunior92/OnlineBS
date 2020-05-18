using OnlineBS.Domain.Commands;

namespace OnlineBS.Domain.Handlers
{
    public interface IHandler<T> 
    {
        ICommandResult Handle(T command);
    }
}