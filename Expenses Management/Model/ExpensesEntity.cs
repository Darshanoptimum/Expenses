using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class ExpensesEntity
    {
        public int Ex_Id { get; set; }
        public int User_Id { get; set; }
        public string Email { get; set; }
        [Required]
        
        public string Ex_Type { get; set; }
        public string Date { get; set; }

        [Range(1, Int32.MaxValue - 1, ErrorMessage ="Amount is Not Valid"),Required]
        public int Amount { get; set; }
        public int Balance_Amount { get; set; }

    }
}
