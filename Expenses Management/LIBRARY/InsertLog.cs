using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class InsertLog
    {
        public static void WriteErrrorLog(string exception)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory + "\\ErrorLog\\ErrorLog_" + DateTime.Now.ToString("dd-MM-yyyy") + ".txt";
            if (!Directory.Exists(path.Substring(0, path.LastIndexOf('\\'))))
            {
                Directory.CreateDirectory(path.Substring(0, path.LastIndexOf('\\')));
            }
            if (!File.Exists(path))
            {
                File.Create(path).Close();
            }
            TextWriter tw = new StreamWriter(path, true);
            tw.WriteLine("------------------------------------------" + DateTime.Now.ToString() + "------------------------------------------");
            tw.WriteLine(exception);
            tw.Close();
        }
    }
}
