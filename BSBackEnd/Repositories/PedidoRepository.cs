using BSBackEnd.Models;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System;
using System.Threading.Tasks;
using BSBackEnd.Models.Consultas;

namespace BSBackEnd.Repositories
{
    public interface IPedidoRepository
    {
        List<Pedido> Read(Guid Id);
        void Create(Pedido pedido);
        void Delete(Guid Id);
        void Update(Guid id, Pedido pedido);
    }

    public class PedidoRepository : IPedidoRepository
    {
        private readonly DataContext _context;

        public PedidoRepository(DataContext context)
        {
            _context = context;
        }
        public void Create(Pedido pedido)
        {
            pedido.Id = Guid.NewGuid();
            _context.Pedidos.Add(pedido);
            _context.SaveChanges();
        }

        public void Delete(Guid Id)
        {
            var pedido = _context.Pedidos.Find(Id);
            _context.Entry(pedido).State = EntityState.Deleted;
            _context.SaveChanges();
        }

        public List<Pedido> Read(Guid Id)
        {
            //return _context.Pedidos.Where(Pedido => Pedido.CompradorId == Id).ToList();             
            //var product = await context.Products.Include(x => x.Category).FirstOrDefaultAsync(x => x.Id == id);   exemplo
            return _context.Pedidos.Include(x => x.Anuncio).ToList();
        }

        public void Update(Guid id, Pedido pedido)
        {            
            /*Se for receber apenas os campos, especificar. Se receber o objeto completo pode simplificar
            var _pedido = _context.Pedidos.Find(pedido.Id);
            _pedido.Titulo = pedido.Titulo;
            _pedido.Valor = pedido.Valor;
            _pedido.QtdeDisponivel = pedido.QtdeDisponivel;
            _context.Entry(_pedido).State = EntityState.Modified;       
            _context.SaveChanges();*/     

            /*_context.Entry(pedido).State = EntityState.Modified;   
            _context.SaveChanges();    */

            var _pedido = _context.Pedidos.Find(id);

            _pedido.Qtde = pedido.Qtde;
            _pedido.SolicitaEntrega = pedido.SolicitaEntrega;

            _context.Entry(_pedido).State = EntityState.Modified;   
            _context.SaveChanges();    
        }
    }
}