using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BL;
using Model;

namespace Expenses_Management.Controllers
{
    public class ExpensesController : ApiController
    {
        // API for insert Expenses into database
        [HttpPost]
        [Route("api/insertExpense")]
        public SerializeResponse<InsertResponseEntity> insertExpense([FromBody] ExpensesEntity Expenses)
        {
            
            SerializeResponse<InsertResponseEntity> response = new SerializeResponse<InsertResponseEntity>();
            try
            {
                InsertLog.WriteErrrorLog("ExpensesController => insertExpenses => insert " + Expenses);
                insertExpenses insertexpense = new insertExpenses();
                //call insertExpensesInfo method for add expenses
                if (ModelState.IsValid)
                {
                    response = insertexpense.insertExpensesInfo(Expenses);
                }
                else
                { 
                    response.Message = "Enter valid Amount or Expenses Type";
                }
                
            }
            
            catch (Exception ex)
            {
                InsertLog.WriteErrrorLog("ExpensesController => insertExpenses => Exception " + ex.Message + ex.StackTrace);
                response.Message = ex.Message;
            }
            return response;
        }
        // API for Get all Expenses of user from database
        [HttpPost]
        [Route("api/GetExpense")]
        public SerializeResponse<ExpensesEntity> GetExpense([FromBody] ExpensesEntity Expenses)
        {
            SerializeResponse<ExpensesEntity> response = new SerializeResponse<ExpensesEntity>();
            try
            {
                InsertLog.WriteErrrorLog("ExpensesController => GetExpense => Get " + Expenses);
                getExpense getexpense = new getExpense();
                //call GetExpenseInfo method for get expenses
                response = getexpense.GetExpenseInfo(Expenses);
            }
            catch (Exception ex)
            {
                InsertLog.WriteErrrorLog("ExpensesController => GetExpense => Exception " + ex.Message + ex.StackTrace);
                response.Message = ex.Message;
            }
            return response;
        }
        // API for get month vise expenses of user from database
        [HttpPost]
        [Route("api/GetExpensesByMonth")]
        public SerializeResponse<MonthRsponseEntity> GetExpensesByMonth([FromBody] ExpensesEntity Expenses)
        {
            SerializeResponse<MonthRsponseEntity> response = new SerializeResponse<MonthRsponseEntity>();
            try
            {
                
                InsertLog.WriteErrrorLog("ExpensesController => GetExpense => Get " + Expenses);
                getexpensesByMonth getexpensesbyMonth = new getexpensesByMonth();
                //call getExpensesByMonth method for get month vise expenses
                response = getexpensesbyMonth.getExpensesByMonth(Expenses);
            }
            catch (Exception ex)
            {
                InsertLog.WriteErrrorLog("ExpensesController => GetExpense => Exception " + ex.Message + ex.StackTrace);
                response.Message = ex.Message;
            }
            return response;
        }
    }
}
