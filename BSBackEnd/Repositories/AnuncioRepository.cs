using System;
using System.Collections.Generic;
using System.Linq;
using BSBackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace BSBackEnd.Repositories
{
    public interface IAnuncioRepository
    {
        List<Anuncio> Read(Guid Id);
        List<Anuncio> Read(String likeTitle);
        void Create(Anuncio anuncio);
        void Delete(Guid Id);
        void Update(Guid id, Anuncio anuncio);
    }

    public class AnuncioRepository : IAnuncioRepository
    {
        private readonly DataContext _context;

        public AnuncioRepository(DataContext context)
        {
            _context = context;
        }
        public void Create(Anuncio anuncio)
        {
            anuncio.Id = Guid.NewGuid();
            _context.Anuncios.Add(anuncio);
            _context.SaveChanges();
        }

        public void Delete(Guid Id)
        {
            var anuncio = _context.Anuncios.Find(Id);
            _context.Entry(anuncio).State = EntityState.Deleted;
            _context.SaveChanges();
        }

        public List<Anuncio> Read(Guid Id)
        {
            return _context.Anuncios.Where(Anuncio => Anuncio.VendedorId == Id).ToList();   
        }

        public List<Anuncio> Read(String likeTitle) 
        {
            return _context.Anuncios.Where(Anuncio => EF.Functions.Like(Anuncio.Titulo.ToUpper(), "%"+likeTitle.ToUpper()+"%") && Anuncio.QtdeDisponivel > 0).ToList();          
        }         

        public void Update(Guid id, Anuncio anuncio)
        {         

            var _anuncio = _context.Anuncios.Find(id);

            _anuncio.QtdeDisponivel = anuncio.QtdeDisponivel;
            _anuncio.RealizaEntrega = anuncio.RealizaEntrega;

            _context.Entry(_anuncio).State = EntityState.Modified;   
            _context.SaveChanges();    
        }
    }
}