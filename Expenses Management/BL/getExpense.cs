using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LIBRARY;
using Model;

namespace BL
{
    public class getExpense
    {
        // this method return all expenses of user and if email is null then retuen all expenses table
        public SerializeResponse<ExpensesEntity> GetExpenseInfo(ExpensesEntity expenses)
        {
            InsertLog.WriteErrrorLog("getExpense => GetExpenseInfo => Started");
            ConvertDataTable bl = new ConvertDataTable();
            SerializeResponse<ExpensesEntity> objResponsemessage = new SerializeResponse<ExpensesEntity>();
            // create data set for store data tables set
            DataSet ds = new DataSet();
            SqlDataProvider objSDP = new SqlDataProvider();
            string query = "GetAllExpenses";
            try
            {
                // call connection string
                string Con_str = Connection.constrSMC();
                SqlParameter prm1 = objSDP.CreateInitializedParameter("@Email", DbType.Int32, expenses.Email);
                SqlParameter[] Sqlpara = { prm1 };
                // call sql helper class method for execute stored proc
                ds = SqlHelper.ExecuteDataset(Con_str, query, Sqlpara);
                if (ds?.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    // convert first data table into response array
                    objResponsemessage.ArrayOfResponse = bl.ListConvertDataTable<ExpensesEntity>(ds.Tables[0]);
                    objResponsemessage.Message = Convert.ToString(ds.Tables[0].Rows[0]["Result"]);
                    // convert secound data table into response array
                    objResponsemessage.ID = Convert.ToInt32(ds.Tables[0].Rows[0]["User_Id"]);
                    
                }
            }
            catch (Exception ex)
            {
                objResponsemessage.Message = "500|Exception Occurred";
                InsertLog.WriteErrrorLog("getExpense => GetExpenseInfo => Exception" + ex.Message + ex.StackTrace);
            }
            return objResponsemessage;
        }
    }
}
