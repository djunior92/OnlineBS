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

            /*modelBuilder.Entity<Usuario>().ToTable("Usuario");
            modelBuilder.Entity<Usuario>().Property(e => e.Id);     
            modelBuilder.Entity<Usuario>().Property(e => e.Email).HasMaxLength(30).IsRequired();
            modelBuilder.Entity<Usuario>().Property(e => e.Senha).HasMaxLength(30).IsRequired();
            modelBuilder.Entity<Usuario>().Property(e => e.Nome).HasMaxLength(100).IsRequired();
            modelBuilder.Entity<Usuario>().Property(e => e.Endereco).HasMaxLength(100).IsRequired();
            modelBuilder.Entity<Usuario>().Property(e => e.Telefone).HasMaxLength(15);

            modelBuilder.Entity<Anuncio>().ToTable("Anuncio");
            modelBuilder.Entity<Anuncio>().Property(e => e.Id);   
            //modelBuilder.Entity<Anuncio>().Property(e => e.Vendedor).IsRequired();  //.HasForeignKey
            modelBuilder.Entity<Anuncio>().Property(e => e.Foto).IsRequired();
            modelBuilder.Entity<Anuncio>().Property(e => e.Titulo).HasMaxLength(100).IsRequired();
            modelBuilder.Entity<Anuncio>().Property(e => e.Descricao).HasMaxLength(500).IsRequired();
            modelBuilder.Entity<Anuncio>().Property(e => e.Valor).IsRequired();
            modelBuilder.Entity<Anuncio>().Property(e => e.QtdeDisponivel).IsRequired();
            //modelBuilder.Entity<Anuncio>().Property(e => e.realizaEntrega).IsRequired();

            modelBuilder.Entity<Pedido>().ToTable("Venda");
            modelBuilder.Entity<Pedido>().Property(e => e.Id);   
            modelBuilder.Entity<Pedido>().HasForeignKey(p => p.AnuncioId); ou
            //modelBuilder.Entity<Pedido>()
            //    .HasOne<Anuncio>(e => e.Anuncio)
            //    .WithMany(a => a.Pedidos)
            //    .HasForeignKey(e => e.AnuncioAtualId)
            //    .HasConstraintName("FK_Pedido_Anuncio");

            modelBuilder.Entity<Pedido>().Property(e => e.Qtde).IsRequired();
            modelBuilder.Entity<Pedido>().Property(e => e.SolicitaEntrega).IsRequired();*/  
            
        }
    }
}