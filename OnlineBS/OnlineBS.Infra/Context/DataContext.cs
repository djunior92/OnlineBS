using Microsoft.EntityFrameworkCore;
using OnlineBS.Domain.Entities;

namespace OnlineBS.Infra.Context
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) { }

        public DbSet<Servico> Servicos { get; set; }
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Servico>().ToTable("Servicos");
            modelBuilder.Entity<Servico>().Property(e => e.Id);
            modelBuilder.Entity<Servico>().Property(e => e.Titulo).HasMaxLength(100).IsRequired();//.HasColumnType("varchar(100)");
            modelBuilder.Entity<Servico>().Property(e => e.Descricao).IsRequired();
            modelBuilder.Entity<Servico>().Property(e => e.Status).IsRequired();
            modelBuilder.Entity<Servico>().Property(e => e.Usuario).IsRequired();
            modelBuilder.Entity<Servico>().HasIndex(e => e.Usuario);

            modelBuilder.Entity<Usuario>().ToTable("Usuario");
            modelBuilder.Entity<Usuario>().Property(e => e.Id);     
            modelBuilder.Entity<Usuario>().Property(e => e.Login).HasMaxLength(30).IsRequired();
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
            modelBuilder.Entity<Anuncio>().Property(e => e.realizaEntrega).IsRequired();

            modelBuilder.Entity<Venda>().ToTable("Venda");
            modelBuilder.Entity<Venda>().Property(e => e.Id);   
            //modelBuilder.Entity<Venda>().Property(e => e.Comprador).IsRequired(); 
            //modelBuilder.Entity<Venda>().Property(e => e.Anuncio).IsRequired(); 
            /*modelBuilder.Entity<Venda>()
                .HasOne<Anuncio>(e => e.Anuncio)
                .WithMany(a => a.Vendas)
                .HasForeignKey(e => e.AnuncioAtualId)
                .HasConstraintName("FK_Venda_Anuncio");*/

            modelBuilder.Entity<Venda>().Property(e => e.Qtde).IsRequired();
            modelBuilder.Entity<Venda>().Property(e => e.SolicitaEntrega).IsRequired();                    
        }
    }
}