using System;
using System.Linq;
using BSBackEnd.Models;

namespace BSBackEnd.Repositories
{
    public interface IUsuarioRepository
    {
        Usuario Read(string email, string senha);
        void Create(Usuario usuario);
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
    }
}