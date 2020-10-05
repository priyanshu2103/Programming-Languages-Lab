import javax.swing.*;
import java.awt.*;
import java.util.concurrent.TimeUnit;

/* made a separate class which runs as a separate thread to 
   highlight the integers keys. This thread sleeps for fixed time, which
   is taken 1 SECOND to maintain color for 1 second. While this thread is sleeping,
   if a keyEvent happens, it is detected by the main thread. */
public class KeyHighlighter extends Thread
{
    Calculator calc = new Calculator();
    public void run()
    {
        while(true)
        {
            /* periodicallly highlight every interger button, equals to and clear button for 1 second */
            for(JButton button : calc.keyButtons)
            {
                button.setBackground(Color.GREEN);
                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                button.setBackground(null);
            }

            calc.bclear.setBackground(Color.GREEN);
            try {
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            calc.bclear.setBackground(null);

            calc.beq.setBackground(Color.GREEN);
            try {
                TimeUnit.SECONDS.sleep(1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            calc.beq.setBackground(null);

        }
    }
}