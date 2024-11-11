package validation;

public class CheckInput {

    /**
     * check input is String not empty
     *
     * @param input
     * @return null if is null or all space
     */
    public static String checkInputString(String input) {
        String check = input == null ? null : input.trim().replaceAll("\\s+", " ");
        if (check != null && !check.isEmpty()) {
            return check;
        }
        return null;
    }

    public static float checkInputIsFloat(String input) {
        float number = 0.0f;
        if (input != null && !input.isEmpty()) {
            number = Float.parseFloat(input);
        }
        return number;
    }

    public static double checkInputIsDouble(String input) {
        double number = 0.0d;
        if (input != null && !input.isEmpty()) {
            number = Double.parseDouble(input);
        }
        return number;
    }
}
