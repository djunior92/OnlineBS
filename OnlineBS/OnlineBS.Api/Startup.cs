using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

using Microsoft.EntityFrameworkCore;
using OnlineBS.Infra.Context;
using Microsoft.Extensions.Configuration;
using OnlineBS.Domain.Repositories;
using OnlineBS.Infra.Repositories;

namespace OnlineBS.Api
{
    public class Startup
    {
        public IConfiguration Configurantion { get; }

        public Startup(IConfiguration configurantion)
        {
            Configurantion = configurantion;
        }
        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit https://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();
            string strConn = Configurantion.GetConnectionString("BDServico");
            services.AddDbContext<DataContext>(options => options.UseSqlServer(strConn));
        
            services.AddTransient<IServicoRepository, ServicoRepository>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseEndpoints(endpoints => endpoints.MapControllers());
        }
    }
}
