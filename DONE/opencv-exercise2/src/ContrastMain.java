import org.opencv.core.Core;

public class ContrastMain {
    public static void main(String[] args) {
        // Load the native OpenCV library
        System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
        new Contrast().run(args);
    }
}
