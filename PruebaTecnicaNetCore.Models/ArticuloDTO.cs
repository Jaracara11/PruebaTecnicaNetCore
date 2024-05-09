using System.ComponentModel.DataAnnotations;

namespace PruebaTecnicaNetCore.Models.DTOs
{
    public class ArticuloDTO
    {
        [Range(1, int.MaxValue, ErrorMessage = "Este campo es requerido.")]
        public int ID { get; set; }

        [Required]
        [StringLength(100, MinimumLength = 3)]
        public string Nombre { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 3)]
        public string Tipo { get; set; }

        [Required]
        [StringLength(50, MinimumLength = 2)]
        public string Marca { get; set; }

        [Required]
        [Range(0.01, 99999999)]
        public decimal Precio { get; set; }
    }
}
