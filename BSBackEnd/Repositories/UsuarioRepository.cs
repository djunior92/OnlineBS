using System;
using System.Linq;
using BSBackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace BSBackEnd.Repositories
{
    public interface IUsuarioRepository
    {
        Usuario Read(string email, string senha);
        void Create(Usuario usuario);
        void Update(Guid id, Usuario usuario);
    }

    public class UsuarioRepository : IUsuarioRepository
    {
        private readonly DataContext _context;

        public UsuarioRepository(DataContext context)
        {
            _context = context;
        }

        public void Create(Usuario usuario)
        {
            usuario.Id = Guid.NewGuid();
            _context.Usuarios.Add(usuario);
            _context.SaveChanges();
        }

        public Usuario Read(string email, string senha)
        {
            return _context.Usuarios.SingleOrDefault(
                usuario => usuario.Email == email && usuario.Senha == senha
            );
        }

        public void Update(Guid id, Usuario usuario)
        {
            var _usuario = _context.Usuarios.Find(id);

            _usuario.Nome = _usuario.Nome;
            _usuario.CpfCnpj = _usuario.CpfCnpj;
            _usuario.Endereco = _usuario.Endereco;
            _usuario.Numero = _usuario.Numero;
            _usuario.Cep = _usuario.Cep;
            _usuario.Bairro = _usuario.Bairro;
            _usuario.Telefone = _usuario.Telefone;

            _context.Entry(_usuario).State = EntityState.Modified;
            _context.SaveChanges();
        }
    }
}