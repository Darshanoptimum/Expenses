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
    public class getexpensesByMonth
    {
        // this method return month vise expenses
        public SerializeResponse<MonthRsponseEntity> getExpensesByMonth(ExpensesEntity expenses)
        {
            InsertLog.WriteErrrorLog("getexpensesByMonth => getExpensesByMonth => Started");
            ConvertDataTable bl = new ConvertDataTable();
            SerializeResponse<MonthRsponseEntity> objResponsemessage = new SerializeResponse<MonthRsponseEntity>();
            // create data set for store data tables set
            DataSet ds = new DataSet();
            SqlDataProvider objSDP = new SqlDataProvider();
            string query = "GetExpensesByMonth";
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
                    objResponsemessage.ArrayOfResponse = bl.ListConvertDataTable<MonthRsponseEntity>(ds.Tables[0]);
                    objResponsemessage.Message = Convert.ToString(ds.Tables[0].Rows[0]["Result"]);
                    // convert secound data table into response array
                    objResponsemessage.ID = Convert.ToInt32(ds.Tables[0].Rows[0]["User_Id"]);
                }
            }
            catch (Exception ex)
            {
                objResponsemessage.Message = "500|Exception Occurred";
                InsertLog.WriteErrrorLog("getexpensesByMonth => getExpensesByMonth => Exception" + ex.Message + ex.StackTrace);
            }
            return objResponsemessage;
        }
    }
}
