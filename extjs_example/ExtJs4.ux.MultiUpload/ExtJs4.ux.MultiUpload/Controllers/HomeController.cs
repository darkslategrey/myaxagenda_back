using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using ExtJs4.ux.MultiUpload.Extensions;

namespace ExtJs4.ux.MultiUpload.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Upload(FormCollection form)
        {
            if (Request.Files.Count == 0) return Content("no files");

            var file = Request.Files[0];
            var id = Guid.NewGuid();

            if (file != null && file.ContentLength > 0)
            {
                var path = GetPath(id);

                file.SaveAs(path);
            }

            return Content(id.ToString());
        }

        public ActionResult Thumb(Guid id)
        {
            var path = GetPath(id);

            if (!System.IO.File.Exists(path)) Content("image not found");

            var image = Image.FromFile(path);
            var thumb = ResizeImage(image, new Size(100, 100));
            var thumbBytes = thumb.GetBytes();

            return File(thumbBytes, "image");
        }

        private string GetPath(Guid id)
        {
            return Path.Combine(Server.MapPath("~/App_Data/uploads"), string.Format("{0}.jpg", id));
        }

        private Image ResizeImage(Image imgToResize, Size size)
        {
            int sourceWidth = imgToResize.Width;
            int sourceHeight = imgToResize.Height;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)size.Width / (float)sourceWidth);
            nPercentH = ((float)size.Height / (float)sourceHeight);

            if (nPercentH < nPercentW)
                nPercent = nPercentH;
            else
                nPercent = nPercentW;

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap b = new Bitmap(destWidth, destHeight);
            using (Graphics g = Graphics.FromImage((Image)b))
            {
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
            }

            return (Image)b;
        }
    }
}
