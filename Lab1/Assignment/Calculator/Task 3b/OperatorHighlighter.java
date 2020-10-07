import javax.swing.*;
import java.awt.*;
import java.util.concurrent.TimeUnit;

/* made a separate class which runs as a separate thread to 
   highlight the operator buttons. This thread sleeps for fixed time, which
   is taken 1 SECOND to maintain color for 1 second. While this thread is sleeping,
   if a keyEvent happens, it is detected by the main thread. */
public class OperatorHighlighter extends Thread
{
    Calculator calc = new Calculator();
    public void run()
    {
        while(true)
        {
            /* periodicallly highlight every operator button for 1 second */
            for(JButton button : calc.operatorButtons)
            {
                button.setBackground(Color.YELLOW);
                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                button.setBackground(null);
            }
        }
    }
}