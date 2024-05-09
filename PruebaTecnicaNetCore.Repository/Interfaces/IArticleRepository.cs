using System.Collections.Generic;
using System.Threading.Tasks;
using PruebaTecnicaNetCore.Models;
using PruebaTecnicaNetCore.Models.DTOs;

namespace PruebaTecnicaNetCore.Repository.Interfaces
{
    public interface IArticleRepository
    {
        Task<Articulo> GetArticleByCode(string code);
        Task<IEnumerable<Articulo>> GetAllArticles();
        Task<DbResponse<Articulo>> AddNewArticle(Articulo product);
        Task<DbResponse<Articulo>> UpdateArticle(ArticuloDTO product);
        Task<DbResponse<Articulo>> DeleteArticleByCode(string code);
    }
}
