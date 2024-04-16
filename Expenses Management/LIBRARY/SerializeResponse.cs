using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class SerializeResponse<T>
    {
        
        private List<T> _ArrayOfResponse;
     
        private string _Message;
        private Int32 _ID;
        public SerializeResponse()
        {
            _ID = 0;
            _ArrayOfResponse = new List<T>();
          
        }

        
        public List<T> ArrayOfResponse
        {
            get { return _ArrayOfResponse; }
            set { _ArrayOfResponse = value; }
        }
        
        public string Message
        {
            get { return _Message; }
            set { _Message = value; }
        }

        public Int32 ID
        {
            get { return _ID; }
            set { _ID = value; }
        }


    }
}
