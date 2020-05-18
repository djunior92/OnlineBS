using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using OnlineBS.Domain.Entities;
using OnlineBS.Domain.Repositories;
using OnlineBS.Infra.Context;

namespace OnlineBS.Infra.Repositories
{
    public class ServicoRepository : IServicoRepository
    {
        private readonly DataContext _context;

        public ServicoRepository(DataContext context)
        {
            _context = context;
        }

        public void Create(Servico e)
        {
            _context.Servicos.Add(e);
            _context.SaveChanges();
        }

        public void Delete(Servico e)
        {
            _context.Entry(e).State = EntityState.Deleted;
            _context.SaveChanges();
        }

        public List<Servico> Read()
        {
            return _context.Servicos.ToList();
        }

        public List<Servico> Read(Status status)
        {
            return _context.Servicos.Where(e => e.Status == status).ToList();
        }

        public List<Servico> Read(string usuario, Status status)
        {
            return _context.Servicos.Where(e => e.Usuario == usuario && e.Status == status).ToList();
        }

        public List<Servico> Read(string usuario)
        {
            return _context.Servicos
                .Where(e => e.Usuario == usuario)
                .OrderBy(e => e.Status)
                .ToList();
        }

        public Servico Read(Guid id)
        {
            return _context.Servicos.Find(id);
        }

        public void Update(Servico e)
        {
            _context.Entry(e).State = EntityState.Modified;
            _context.SaveChanges();
        }
    }
}