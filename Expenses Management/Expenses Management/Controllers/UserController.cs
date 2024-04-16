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
    public class UserController : ApiController
    {
        //  API for insert users data into database
        [HttpPost]
        [Route("api/UserRegister")]
        public SerializeResponse<UserEntity> UserRegister([FromBody] UserEntity user)
        {
            SerializeResponse<UserEntity> response= new SerializeResponse<UserEntity>();
            try
            {
                InsertLog.WriteErrrorLog("UserController => UserRegister => Register " + user);
                insertUser insertUser = new insertUser();
                //call insertUserInfo method for add users data
                response = insertUser.insertUserInfo(user);
            }
            catch (Exception ex)
            {
                InsertLog.WriteErrrorLog("UserController => UserRegister => Exception " + ex.Message+ex.StackTrace);
                response.Message= ex.Message;
            }
            return response;
        }
        [HttpPost]
        [Route("api/UserLogin")]
        public SerializeResponse<UserEntity> UserLoginAPI([FromBody] UserEntity user)
        {
            SerializeResponse<UserEntity> response = new SerializeResponse<UserEntity>();
            try
            {
                InsertLog.WriteErrrorLog("UserController => UserRegister => Register " + user);
                UserLogin userLogin = new UserLogin();
                //call insertUserInfo method for add users data
                response = userLogin.UserLoginInfo(user);
            }
            catch (Exception ex)
            {
                InsertLog.WriteErrrorLog("UserController => UserRegister => Exception " + ex.Message + ex.StackTrace);
                response.Message = ex.Message;
            }
            return response;
        }
    }
}
