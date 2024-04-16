using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class SerializeResponse1<T>
    {
        
        private List<T> _ArrayOfResponse;
     
        private string _Message;
        private Int32 _Closing_Balance;
        private Int32 _ID;
        public SerializeResponse1()
        {
            _ID = 0;
            _Closing_Balance = 0;
            _ArrayOfResponse = new List<T>();
          
        }

        
        public List<T> ArrayOfResponse
        {
            get { return _ArrayOfResponse; }
            set { _ArrayOfResponse = value; }
        }
        public Int32 ID
        {
            get { return _ID; }
            set { _ID = value; }
        }
        public Int32 Closing_Balance
        {
            get { return _Closing_Balance; }
            set { _Closing_Balance = value; }
        }
        public string Message
        {
            get { return _Message; }
            set { _Message = value; }
        }

        


    }
}
