namespace OnlineBS.Domain.Commands
{
    public interface ICommand
    {
        bool Validate();
    }
}