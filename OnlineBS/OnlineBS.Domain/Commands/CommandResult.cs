namespace OnlineBS.Domain.Commands
{
    public class CommandResult : ICommandResult
    {
        public string Status { get; private set; }
        public string Message { get; private set; }
        public object Data { get; private set; }

        public CommandResult(string status, string message, object data)
        {
            Status = status;
            Message = message;
            Data = data;
        }

        public CommandResult(string status, string message)
        {
            Status = status;
            Message = message;
            Data = null;
        }
    }
}