import java.time.*;
import java.time.format.*;
import java.util.*;

class Test
{
    private static final int ITERATIONS = 1000000;
    public static void main(String[] args) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
            "EEE MMM dd HH:mm:ss zzz yyyy", Locale.ENGLISH);
        String value = "Tue Jan 01 00:19:32 CET 1901";
        int total = 0;

        long start = System.nanoTime();
        for (int i = 0; i < ITERATIONS; i++) {
            LocalDateTime parsed = LocalDateTime.parse(value, formatter);
            // Just to avoid the parsing being elided by a cunning JIT
            total += parsed.getYear();
        }
        long end = System.nanoTime();

        // Just to make sure total is really used
        System.out.println(total);
        System.out.println("Nanos per parse: " + (end - start) / ITERATIONS);
    }
}