using Dapper;
using Microsoft.Data.SqlClient;
using PruebaTecnicaNetCore.Models;
using PruebaTecnicaNetCore.Models.DTOs;
using PruebaTecnicaNetCore.Repository.Interfaces;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace PruebaTecnicaNetCore.Repository.Repositories
{
    public class ArticleRepository : IArticleRepository
    {
        private readonly DbContext _context;
        public ArticleRepository(DbContext context)
        {
            _context = context;
        }

        public async Task<Articulo> GetArticleByCode(string code)
        {
            using IDbConnection db = _context.CreateConnection();

            var query = "SELECT * FROM [dbo].[Articulos] WHERE Codigo = @Codigo";

            return await db.QueryFirstOrDefaultAsync<Articulo>(query, new { Codigo = code });
        }

        public async Task<IEnumerable<Articulo>> GetAllArticles()
        {
            using IDbConnection db = _context.CreateConnection();
            return await db.QueryAsync<Articulo>("spGetAllArticles", commandType: CommandType.StoredProcedure);
        }

        public async Task<DbResponse<Articulo>> AddNewArticle(Articulo articulo)
        {
            using IDbConnection db = _context.CreateConnection();
            var parameters = new DynamicParameters();
            parameters.Add("@Codigo", articulo.Codigo);
            parameters.Add("@Nombre", articulo.Nombre);
            parameters.Add("@Tipo", articulo.Tipo);
            parameters.Add("@Marca", articulo.Marca);
            parameters.Add("@Precio", articulo.Precio);

            try
            {
                Articulo newArticle = await db.QuerySingleOrDefaultAsync<Articulo>
                    ("spAddNewArticle", parameters, commandType: CommandType.StoredProcedure);

                return new DbResponse<Articulo>
                {
                    Success = true,
                    Data = newArticle
                };
            }
            catch (SqlException ex)
            {
                return new DbResponse<Articulo>
                {
                    Success = false,
                    Message = ex.Message
                };
            }
        }

        public async Task<DbResponse<Articulo>> UpdateArticle(ArticuloDTO articulo)
        {
            using IDbConnection db = _context.CreateConnection();
            var parameters = new DynamicParameters();
            parameters.Add("@ID", articulo.ID);
            parameters.Add("@Nombre", articulo.Nombre);
            parameters.Add("@Tipo", articulo.Tipo);
            parameters.Add("@Marca", articulo.Marca);
            parameters.Add("@Precio", articulo.Precio);

            try
            {
                Articulo updatedArticle = await db.QuerySingleOrDefaultAsync<Articulo>
                    ("spUpdateArticle", parameters, commandType: CommandType.StoredProcedure);

                return new DbResponse<Articulo>
                {
                    Success = true,
                    Message = "Article updated.",
                    Data = updatedArticle
                };
            }
            catch (SqlException ex)
            {
                return new DbResponse<Articulo>
                {
                    Success = false,
                    Message = ex.Message
                };
            }
        }

        public async Task<DbResponse<Articulo>> DeleteArticleByCode(string code)
        {
            using IDbConnection db = _context.CreateConnection();

            try
            {
                await db.ExecuteAsync("spDeleteArticle", new { Codigo = code }, commandType: CommandType.StoredProcedure);

                return new DbResponse<Articulo>
                {
                    Success = true
                };
            }
            catch (SqlException ex)
            {
                return new DbResponse<Articulo>
                {
                    Success = false,
                    Message = ex.Message
                };
            }
        }
    }
}
