package pt.isel.i2122pib.opencv;

import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.highgui.HighGui;
import org.opencv.imgcodecs.Imgcodecs;

public class Main {

    private static final String defaultFile = "./data/barries.tif";

    public static void main(String[] args) {
        // Load the native library.
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        new MatMaskOperationsRun().run(args);
    }

    static class MatMaskOperationsRun {
        public void run(String[] args) {
            String filename = defaultFile;
            int img_codec = Imgcodecs.IMREAD_COLOR;
            if (args.length != 0) {
                filename = args[0];
                if (args.length >= 2 && args[1].equals("G"))
                    img_codec = Imgcodecs.IMREAD_GRAYSCALE;
            }

            Mat src = Imgcodecs.imread(filename, img_codec);
            if (src.empty()) {
                System.out.println("Can't open image [" + filename + "]");
                System.out.println("Program Arguments: [image_path -- default " + defaultFile + "] [G -- grayscale]");
                System.exit(-1);
            }

            HighGui.namedWindow("Output", HighGui.WINDOW_AUTOSIZE);

            // BRIGHTNESS
            for (double i=-255; i<=255; i=i+20) {
                Mat dst0 = contrBrigh(src, new Mat(), 1, i);
                System.out.println("Current brightness level: " + i);
                HighGui.imshow( "Output", dst0 );
                HighGui.waitKey(1);
            }

            // CONTRAST
            for (double i=0; i<=3; i=i+0.1) {
                Mat dst0 = contrBrigh(src, new Mat(), i, 0);
                System.out.println("Current contrast multiplier: " + i);
                HighGui.imshow( "Output", dst0 );
                HighGui.waitKey(1);
            }

            System.exit(0);
        }

        public static double truncateToLimit(double x) {
            return x > 255.0 ? 255.0 : (x < 0.0 ? 0.0 : x);
        }

        public Mat contrBrigh(Mat myImage, Mat Result, double contrast, double brightness) {
            myImage.convertTo(myImage, CvType.CV_8U);
            int nChannels = myImage.channels();
            Result.create(myImage.size(), myImage.type());

            for (int j = 1; j < myImage.rows() - 1; ++j) {
                for (int i = 1; i < myImage.cols() - 1; ++i) {
                    double sum[] = new double[nChannels];
                    for (int k = 0; k < nChannels; ++k) {
                        double center = (myImage.get(j, i)[k]);
                        sum[k] = truncateToLimit((center*contrast)+brightness);
                    }
                    Result.put(j, i, sum);
                }
            }

            return Result;
        }
    }
}
