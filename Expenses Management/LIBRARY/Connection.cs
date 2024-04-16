using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LIBRARY
{
    public static class Connection
    {
        public static string constrSMC()
        {
            string conn = "data source=DESKTOP-R5CTQN3\\SQLEXPRESS; database=Expense_Management; integrated security=SSPI";
            return conn;
        }
    }
}
