import java.util.Scanner;
import org.opencv.core.Mat;
import org.opencv.highgui.HighGui;
import org.opencv.imgcodecs.Imgcodecs;

class Brightness {
    static double alpha = 1;
    public void run(String[] args) {
        //String imagePath = args.length > 0 ? args[0] : "./assets/boat.tif";
        //String imagePath = args.length > 0 ? args[0] : "./assets/squares.tif";
        String imagePath = args.length > 0 ? args[0] : "./assets/mandrill.tif";
        Mat image = Imgcodecs.imread(imagePath);
        if (image.empty()) {
            System.out.println("Empty image: " + imagePath);
            System.exit(0);
        }
        Mat newImage = new Mat(image.rows(), image.cols(), image.type());

        //Function to the user enter with a value for increase or decrease brightness
        int beta = 0;
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.println("For brighter images, enter values between 0 and +255");
            System.out.println("For darker images, enter values between -255 and 0");
            System.out.print("Enter the value: ");
            beta = scanner.nextInt();
        }

        image.convertTo(newImage, -1, alpha, beta);

        HighGui.imshow("Original Image", image);
        HighGui.imshow("New Image", newImage);
        HighGui.waitKey();
        System.exit(0);
    }
}