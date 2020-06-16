using System.Text;
using BSBackEnd.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;

namespace BSBackEnd
{
    public class Startup
    {
    public IConfiguration Configuration { get; set; }  
    public Startup(IConfiguration configuration){
        Configuration = configuration;
    }

    public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();

            var key = Encoding.ASCII.GetBytes("UmTokenMuitoGrandeEDiferenteParaNinguemDescobrir");

            services.AddAuthentication(options => {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;

            })
            .AddJwtBearer( options => {
                options.RequireHttpsMetadata = false;
                options.SaveToken = true;
                options.TokenValidationParameters = new TokenValidationParameters {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false,
                };
            });


            ///*Local*/services.AddDbContext<DataContext>(options => options.UseInMemoryDatabase("BDOnlineBS"));
            /*PostgreSQL*/services.AddDbContext<DataContext>(options => options.UseNpgsql(Configuration.GetConnectionString("Heroku")));  
            ///*SQL SERVER*/services.AddDbContext<DataContext>(options => options.UseSqlServer(Configuration.GetConnectionString("BDSQLSERVER")));
            
            //services.AddSingleton - por aplicação
            //services.AddTransient - por transação 
            services.AddTransient<IUsuarioRepository, UsuarioRepository>();
            services.AddTransient<IAnuncioRepository, AnuncioRepository>();
            services.AddTransient<IPedidoRepository, PedidoRepository>();            
        }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints(endpoints => endpoints.MapControllers());
        }
    }
}
