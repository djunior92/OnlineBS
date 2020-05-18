using System;
using System.Collections.Generic;
using OnlineBS.Domain.Entities;

namespace OnlineBS.Domain.Repositories
{
    public interface IServicoRepository
    {
        List<Servico> Read();
        List<Servico> Read(Status status);
        List<Servico> Read(string usuario, Status status);
        List<Servico> Read(string usuario);
        Servico Read(Guid id);
        void Create(Servico e);   
        void Update(Servico e);  
        void Delete(Servico e);   
    }
}