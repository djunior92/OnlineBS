using System;
using System.Collections.Generic;
using OnlineBS.Domain.Entities;

namespace OnlineBS.Domain.Repositories
{
    public interface IAnuncioRepository
    {
        List<Anuncio> Read();
        Anuncio Read(Guid id);
        void Create(Anuncio e);
        void Update(Anuncio e);
        void Delete(Anuncio e);
    }
}