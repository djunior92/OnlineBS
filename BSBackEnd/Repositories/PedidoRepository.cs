using BSBackEnd.Models;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System;

namespace BSBackEnd.Repositories
{
    public interface IPedidoRepository
    {
        List<Pedido> Read(Guid Id);
        List<Pedido> ReadVendas(Guid Id);
        void Create(Pedido pedido);
        void Delete(Guid Id);
        void Update(Guid id, Pedido pedido);

        //função para verificar se o "comprador" não tentou burlar o sistema
        //A função verifica se o vendedor disponibiliza entrega 
        bool DisponibilidadeEntrega(Pedido pedido);
        //função para verificar se o "comprador" não tentou burlar o sistema
        //A função verifica se a quantidade informada existe em estoque
        bool QuantidadeValida(Pedido pedido);

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
            pedido.DataPedido = DateTime.Now;            
            _context.Pedidos.Add(pedido);
            pedido.Anuncio.QtdeDisponivel -= pedido.Qtde;
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
            return _context.Pedidos.Include(x => x.Anuncio).Where(Pedido => Pedido.CompradorId == Id).OrderByDescending(p => p.DataPedido).ToList();
        }

        public List<Pedido> ReadVendas(Guid Id)
        {
            return _context.Pedidos.Include(x => x.Anuncio)
            .Where(pedido => pedido.Anuncio.VendedorId == Id).OrderByDescending(p => p.DataPedido).ToList();
        }

        public void Update(Guid id, Pedido pedido)
        {           
            var _pedido = _context.Pedidos.Find(id);

            _pedido.Qtde = pedido.Qtde;
            _pedido.SolicitaEntrega = pedido.SolicitaEntrega;

            _context.Entry(_pedido).State = EntityState.Modified;
            _context.SaveChanges();
        }

        public bool DisponibilidadeEntrega(Pedido pedido)
        {
            var _anuncio = _context.Anuncios.Where(Anuncio => Anuncio.Id == pedido.AnuncioId).First();

            if (_anuncio.RealizaEntrega == true)
                return true;    //permite cadastrar o peddo
            else
            {   //verifica se o anuncio foi cadastrado como não realizar entrega e o comprador solicitou entrega (tentou burlar o sistem)
                if (_anuncio.RealizaEntrega == false && pedido.SolicitaEntrega == true)
                    return false;   //não permite cadastrar o peddo
                else
                    return true;    //permite cadastrar o peddo
            }
        }

        public bool QuantidadeValida(Pedido pedido)
        {
            var _anuncio = _context.Anuncios.Where(Anuncio => Anuncio.Id == pedido.AnuncioId).First();

            if (_anuncio.QtdeDisponivel >= pedido.Qtde && pedido.Qtde > 0) //verifica também se a quantidade informada não é negativa
                return true;    //quantidade suficiente
            else
                return false;
        }


    }
}