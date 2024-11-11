package until;

import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.Collection;

public class UploadFile {
    private static final long serialVersionUID = 1L;
    private static final long MAX_TOTAL_SIZE = 10 * 1024 * 1024; // 10MB

    /**
     * Processes all file parts after upload, skipping non-file parts.
     *
     * @param fileParts file parts uploaded by the user
     * @param imageFile name of the file input tag
     * @return String image in Base64 format with a delimiter (';') between images
     * @throws IOException in case of an error
     */
    public static String processFileParts(Collection<Part> fileParts, String imageFile) throws IOException {
        long totalSize = 0;
        StringBuilder base64Images = new StringBuilder();

        for (Part filePart : fileParts) {
            // Check if this part is a file upload (i.e., it has a valid file name)
            if (filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty() && filePart.getName().equals(imageFile)) {
                String dile = filePart.getSubmittedFileName();
                System.out.println("File name: " + filePart.getSubmittedFileName());
                String contentType = filePart.getContentType();
                try (InputStream inputStream = filePart.getInputStream()) {
                    // Convert image to Base64 format
                    String base64Image = convertImageToBase64(inputStream, contentType, totalSize);
                    base64Images.append(base64Image).append(";");
                    totalSize += filePart.getSize();
                }
            }
        }

        return base64Images.toString();
    }

    /**
     * Converts an image input stream to a Base64-encoded string.
     *
     * @param inputStream the input stream of the image
     * @param contentType the MIME type of the file
     * @param totalSize the current total size of uploaded files
     * @return String the Base64-encoded image
     * @throws IOException if an error occurs or file size exceeds the limit
     */
    public static String convertImageToBase64(InputStream inputStream, String contentType, long totalSize) throws IOException {
        // Check if the content type is not an image
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IOException("File is not an image.");
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;
        long currentSize = 0;

        // Read the data from the inputStream and write it to the outputStream
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            currentSize += bytesRead;
            if (currentSize + totalSize > MAX_TOTAL_SIZE) {
                throw new IOException("Total file size exceeds 10MB.");
            }
            outputStream.write(buffer, 0, bytesRead);
        }

        // Convert the byte array to a Base64-encoded string
        return Base64.getEncoder().encodeToString(outputStream.toByteArray());
    }
}
