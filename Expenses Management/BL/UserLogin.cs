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
    public class UserLogin
    {
        public SerializeResponse<UserEntity> UserLoginInfo(UserEntity user)
        {
            InsertLog.WriteErrrorLog("UserLogin => UserLoginInfo => Started");
            ConvertDataTable bl = new ConvertDataTable();
            SerializeResponse<UserEntity> objResponsemessage = new SerializeResponse<UserEntity>();
            // create data set for store data tables set
            DataSet ds = new DataSet();
            SqlDataProvider objSDP = new SqlDataProvider();
            string query = "UserLogin";
            try
            {
                // call connection string
                string Con_str = Connection.constrSMC();
                SqlParameter prm1 = objSDP.CreateInitializedParameter("@Name", DbType.String, user.Name);
                SqlParameter prm2 = objSDP.CreateInitializedParameter("@Email", DbType.String, user.Email);
                SqlParameter prm3 = objSDP.CreateInitializedParameter("@Password", DbType.String, user.Password);

                SqlParameter[] Sqlpara = { prm1, prm2, prm3 };
                // call sql helper class method for execute stored proc
                ds = SqlHelper.ExecuteDataset(Con_str, query, Sqlpara);
                if (ds?.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    // convert data table into response array
                    objResponsemessage.ArrayOfResponse = bl.ListConvertDataTable<UserEntity>(ds.Tables[0]);
                    objResponsemessage.ID = Convert.ToInt32(ds.Tables[0].Rows[0]["User_Id"]);
                    objResponsemessage.Message = Convert.ToString(ds.Tables[0].Rows[0]["result"]);
                }

            }

            catch (Exception ex)
            {
                objResponsemessage.Message = "500|Exception Occurred";
                InsertLog.WriteErrrorLog("UserLogin => UserLoginInfo => Exception" + ex.Message + ex.StackTrace);
            }
            return objResponsemessage;
        }
    }
}
