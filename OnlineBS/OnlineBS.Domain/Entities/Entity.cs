using System;

namespace OnlineBS.Domain.Entities
{
    public abstract class Entity
    {
        public Guid Id { get; private set; }

        public Entity()
        {
            Id = Guid.NewGuid();
        }
    }
}