using Microsoft.AspNetCore.Mvc;
using PruebaTecnicaNetCore.Models;
using PruebaTecnicaNetCore.Models.DTOs;
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

        [HttpGet("{code}")]
        public async Task<ActionResult<Articulo>> GetArticleByCode(string code)
        {
            var article = await _articleRepo.GetArticleByCode(code);
            return Ok(article);
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Articulo>>> GetAllArticles()
        {
            var articles = await _articleRepo.GetAllArticles();
            return Ok(articles);
        }

        [HttpPost]
        public async Task<ActionResult<Articulo>> AddNewArticle(Articulo articulo)
        {
            var response = await _articleRepo.AddNewArticle(articulo);

            if (!response.Success)
            {
                return BadRequest(new { error = response.Message });

            }
            else
            {
                return Created("Product", response.Data);
            }
        }

        [HttpPut("edit")]
        public async Task<ActionResult<Articulo>> UpdateArticle(ArticuloDTO articulo)
        {
            var response = await _articleRepo.UpdateArticle(articulo);

            if (!response.Success)
            {
                return BadRequest(new { error = response.Message });
            }
            else
            {
                return Ok(response);
            }
        }

        [HttpDelete("delete/{code}")]
        public async Task<ActionResult> DeleteArticleByCode(string code)
        {
            var response = await _articleRepo.DeleteArticleByCode(code);

            if (!response.Success)
            {
                return BadRequest(new { error = response.Message });
            }
            else
            {
                return NoContent();
            }
        }
    }
}
