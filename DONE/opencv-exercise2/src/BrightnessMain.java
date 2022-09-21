import org.opencv.core.Core;

public class BrightnessMain {
    public static void main(String[] args) {
        // Load the native OpenCV library
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        new Brightness().run(args);
    }
}
