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
        Usuario Read(Guid id);
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

        public Usuario Read(Guid id)
        {
            return _context.Usuarios.Find(id);
        }

        public void Update(Guid id, Usuario usuario)
        {
            var _usuario = _context.Usuarios.Find(id);

            _usuario.Email = usuario.Email;
            _usuario.Senha = usuario.Senha;
            _usuario.Nome = usuario.Nome;
            _usuario.CpfCnpj = usuario.CpfCnpj;
            _usuario.Endereco = usuario.Endereco;
            _usuario.Numero = usuario.Numero;
            _usuario.Cep = usuario.Cep;
            _usuario.Bairro = usuario.Bairro;
            _usuario.Telefone = usuario.Telefone;

            _context.Entry(_usuario).State = EntityState.Modified;
            _context.SaveChanges();
        }
    }
}