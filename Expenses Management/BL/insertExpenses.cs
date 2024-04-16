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
    public class insertExpenses
    {
        // this method insert user expenses into database and response an expenses with user balance
        public SerializeResponse<InsertResponseEntity> insertExpensesInfo(ExpensesEntity expenses)
        {
            InsertLog.WriteErrrorLog("insertExpenses=>insertExpensesInfo=>Started");
            ConvertDataTable bl = new ConvertDataTable();
            SerializeResponse<InsertResponseEntity> objResponsemessage = new SerializeResponse<InsertResponseEntity>();
            // create data set for store data tables set
            DataSet ds = new DataSet();
            SqlDataProvider objSDP = new SqlDataProvider();
            string query = "insertExpenses";
            try
            {
                // call connection string
                string Con_str = Connection.constrSMC();
                SqlParameter prm1 = objSDP.CreateInitializedParameter("@User_Id", DbType.Int32, expenses.User_Id);
                SqlParameter prm2 = objSDP.CreateInitializedParameter("@Ex_Type", DbType.String, char.ToUpper(expenses.Ex_Type[0]) + expenses.Ex_Type.Substring(1));
                SqlParameter prm3 = objSDP.CreateInitializedParameter("@Amount", DbType.String, expenses.Amount);
                SqlParameter[] Sqlpara = { prm1, prm2, prm3 };
                // call sql helper class method for execute stored proc
                ds = SqlHelper.ExecuteDataset(Con_str, query, Sqlpara);

                if (ds?.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    // convert data table into response array
                    objResponsemessage.ArrayOfResponse = bl.ListConvertDataTable<InsertResponseEntity>(ds.Tables[0]);
                    objResponsemessage.ID = Convert.ToInt32(ds.Tables[0].Rows[0]["User_Id"]);
                    objResponsemessage.Message = Convert.ToString(ds.Tables[0].Rows[0]["Result"]);
                }

            }

            catch (Exception ex)
            {
                objResponsemessage.Message = "500|Exception Occurred";
                InsertLog.WriteErrrorLog("insertExpenses=>insertExpensesInfo=>Exception" + ex.Message + ex.StackTrace);
            }
            return objResponsemessage;
        }
    }
}
