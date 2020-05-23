using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace OnlineBS.Infra.Migrations
{
    public partial class CreateTables : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Servicos",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Usuario = table.Column<string>(nullable: false),
                    Titulo = table.Column<string>(maxLength: 100, nullable: false),
                    Descricao = table.Column<string>(nullable: false),
                    Status = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Servicos", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Usuario",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Login = table.Column<string>(maxLength: 30, nullable: false),
                    Senha = table.Column<string>(maxLength: 30, nullable: false),
                    Nome = table.Column<string>(maxLength: 100, nullable: false),
                    Endereco = table.Column<string>(maxLength: 100, nullable: false),
                    Telefone = table.Column<string>(maxLength: 15, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usuario", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Anuncio",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    VendedorId = table.Column<Guid>(nullable: true),
                    Foto = table.Column<string>(nullable: false),
                    Titulo = table.Column<string>(maxLength: 100, nullable: false),
                    Descricao = table.Column<string>(maxLength: 500, nullable: false),
                    Valor = table.Column<decimal>(nullable: false),
                    QtdeDisponivel = table.Column<int>(nullable: false),
                    realizaEntrega = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Anuncio", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Anuncio_Usuario_VendedorId",
                        column: x => x.VendedorId,
                        principalTable: "Usuario",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Venda",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    CompradorId = table.Column<Guid>(nullable: true),
                    AnuncioId = table.Column<Guid>(nullable: true),
                    Qtde = table.Column<int>(nullable: false),
                    SolicitaEntrega = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Venda", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Venda_Anuncio_AnuncioId",
                        column: x => x.AnuncioId,
                        principalTable: "Anuncio",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Venda_Usuario_CompradorId",
                        column: x => x.CompradorId,
                        principalTable: "Usuario",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Anuncio_VendedorId",
                table: "Anuncio",
                column: "VendedorId");

            migrationBuilder.CreateIndex(
                name: "IX_Servicos_Usuario",
                table: "Servicos",
                column: "Usuario");

            migrationBuilder.CreateIndex(
                name: "IX_Venda_AnuncioId",
                table: "Venda",
                column: "AnuncioId");

            migrationBuilder.CreateIndex(
                name: "IX_Venda_CompradorId",
                table: "Venda",
                column: "CompradorId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Servicos");

            migrationBuilder.DropTable(
                name: "Venda");

            migrationBuilder.DropTable(
                name: "Anuncio");

            migrationBuilder.DropTable(
                name: "Usuario");
        }
    }
}
