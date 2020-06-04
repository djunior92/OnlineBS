using BSBackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace BSBackEnd.Repositories
{
    public class DataContext: DbContext
    {
        public DataContext(DbContextOptions options) : base(options) { }

        public DbSet<Anuncio> Anuncios { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
    }
}