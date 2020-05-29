using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using OnlineBS.Domain.Entities;
using OnlineBS.Domain.Repositories;
using OnlineBS.Infra.Context;

namespace OnlineBS.Infra.Repositories
{
    public class AnuncioRepository : IAnuncioRepository
    {
        private readonly DataContext _context;

        public AnuncioRepository(DataContext context)
        {
            _context = context;
        }

        public List<Anuncio> Read()
        {
            return _context.Anuncios.ToList();
        }

        public Anuncio Read(Guid id)
        {
            return _context.Anuncios.Find(id);
        }        

        public void Create(Anuncio e)
        {
            _context.Anuncios.Add(e);
            _context.SaveChanges();
        }

        public void Update(Anuncio e)
        {
            _context.Entry(e).State = EntityState.Modified;
            _context.SaveChanges();
        }

        public void Delete(Anuncio e)
        {
            _context.Entry(e).State = EntityState.Deleted;
            _context.SaveChanges();
        }
    }
}