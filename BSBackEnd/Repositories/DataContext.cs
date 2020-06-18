using BSBackEnd.Models;
using Microsoft.EntityFrameworkCore;

namespace BSBackEnd.Repositories
{
    public class DataContext: DbContext
    {
        public DataContext(DbContextOptions options) : base(options) { }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Anuncio> Anuncios { get; set; }        
        public DbSet<Pedido> Pedidos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder) 
        {
            modelBuilder.Entity<Pedido>()
            .HasOne(u => u.Comprador).WithMany(u => u.ComprasRealizadas).IsRequired().OnDelete(DeleteBehavior.Restrict);
            //modelBuilder.Entity<Anuncio>()
            //.HasOne(u => u.Vendedor).WithMany(u => u.AnunciosRealizados).IsRequired().OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Pedido>()
            .HasOne(pt => pt.Comprador)
            .WithMany(p => p.ComprasRealizadas)
            .HasForeignKey(pt => pt.CompradorId);                   
        }
    }
}