using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LIBRARY;
using Model;

namespace BL
{
    public class insertUser
    {
        // this method insert users data into database and response an user data withb user id
        public SerializeResponse<UserEntity> insertUserInfo(UserEntity user)
        {
            InsertLog.WriteErrrorLog("insertUser => insertUserInfo => Started");
            ConvertDataTable bl = new ConvertDataTable();
            SerializeResponse<UserEntity> objResponsemessage = new SerializeResponse<UserEntity>();
            // create data set for store data tables set
            DataSet ds = new DataSet();
            SqlDataProvider objSDP = new SqlDataProvider();
            string query = "InsertUser";
            try
            {
                // call connection string
                string Con_str = Connection.constrSMC();
                SqlParameter prm1 = objSDP.CreateInitializedParameter("@Name", DbType.String, user.Name);
                SqlParameter prm2 = objSDP.CreateInitializedParameter("@Email", DbType.String, user.Email);
                SqlParameter prm3 = objSDP.CreateInitializedParameter("@Password", DbType.String, user.Password);
                SqlParameter prm4 = objSDP.CreateInitializedParameter("@Mobile", DbType.String, user.Mobile);
                SqlParameter prm5 = objSDP.CreateInitializedParameter("@Address", DbType.String, user.Address);
                SqlParameter[] Sqlpara = { prm1, prm2, prm3, prm4, prm5};
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
                InsertLog.WriteErrrorLog("insertUser => insertUserInfo => Exception" + ex.Message + ex.StackTrace);
            }
            return objResponsemessage;
        }
    }
}
