using System;
using System.Collections.Generic;
using OnlineBS.Domain.Entities;

namespace OnlineBS.Domain.Repositories
{
    public interface IPropostaRepository
    {
        List<Proposta> Read(Guid servicoId);
        Proposta Read(Guid servicoId, Guid id);
        void Create(Proposta e);
        void Update(Proposta e);
        void Delete(Proposta e);
    }
}