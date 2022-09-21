import org.opencv.core.Mat;
import org.opencv.highgui.HighGui;
import org.opencv.imgcodecs.Imgcodecs;
import java.util.Scanner;

class Contrast {
    static int beta = 0;
    public void run(String[] args) {
        String imagePath = args.length > 0 ? args[0] : "./assets/boat.tif";
        //String imagePath = args.length > 0 ? args[0] : "./assets/squares.tif";
        //String imagePath = args.length > 0 ? args[0] : "./assets/mandrill.tif";
        Mat image = Imgcodecs.imread(imagePath);
        if (image.empty()) {
            System.out.println("Empty image: " + imagePath);
            System.exit(0);
        }
        Mat newImage = new Mat(image.rows(), image.cols(), image.type());

        //Function to the user enter with a value for adjust the contrast
        double alpha = 1.0;
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.print("Enter a value between 0 and 9 to adjust the contrast: ");
            alpha = scanner.nextDouble();
        }

        image.convertTo(newImage, -1, alpha, beta);

        HighGui.imshow("Original Image", image);
        HighGui.imshow("New Image", newImage);
        HighGui.waitKey();
        System.exit(0);
    }
}

