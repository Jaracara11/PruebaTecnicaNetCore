using Microsoft.AspNetCore.Mvc;
using PruebaTecnicaNetCore.Models;
using PruebaTecnicaNetCore.Repository.Interfaces;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PruebaTecnicaNetCore.Controllers
{
    [Route("api/articles")]
    [ApiController]
    public class ArticleController : ControllerBase
    {
        private readonly IArticleRepository _articleRepo;

        public ArticleController(IArticleRepository articleRepo)
        {
            _articleRepo = articleRepo;
        }
       
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Articulo>>> GetAllArticles()
        {
            var articles = await _articleRepo.GetAllArticles();
            return Ok(articles);
        }
    }
}
