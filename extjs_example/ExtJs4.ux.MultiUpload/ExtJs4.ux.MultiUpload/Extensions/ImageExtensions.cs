using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;

namespace ExtJs4.ux.MultiUpload.Extensions
{
    public static class ImageExtensions
    {
        public static byte[] GetBytes(this Image image)
        {
            using (var stream = new MemoryStream())
            {
                image.Save(stream, ImageFormat.Jpeg);
                return stream.ToArray();
            }
        }

        public static Image ToImage(this byte[] image)
        {
            using (var stream = new MemoryStream(image))
            {
                return Image.FromStream(stream);
            }
        }
    }
}
