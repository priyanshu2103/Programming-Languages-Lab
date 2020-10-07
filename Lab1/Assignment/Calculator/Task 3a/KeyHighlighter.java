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
            /* if static variable flag is 0, it means we need to pick up integers */
            if(calc.flag==0)
            {
                /* periodicallly highlight every integer button 1 second */
                for(JButton button : calc.keyButtons)
                {
                    button.setBackground(Color.GREEN);
                    try {
                        TimeUnit.SECONDS.sleep(1);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    button.setBackground(null);
                    if(calc.clicked==1)
                    {
                        calc.clicked=0;
                        break;
                    }
                }
            }
            /* if static variable flag is 1, it means we need to pick up operators */
            else
            {
                calc.bclear.setBackground(Color.YELLOW);
                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                calc.bclear.setBackground(null);
                if(calc.clicked==1)
                {
                    calc.clicked=0;
                    continue;
                }

                calc.beq.setBackground(Color.YELLOW);
                try {
                    TimeUnit.SECONDS.sleep(1);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                calc.beq.setBackground(null);
                if(calc.clicked==1)
                {
                    calc.clicked=0;
                    continue;
                }

                for(JButton button : calc.operatorButtons)
                {
                    button.setBackground(Color.YELLOW);
                    try {
                        TimeUnit.SECONDS.sleep(1);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    button.setBackground(null);
                    if(calc.clicked==1)
                    {
                        calc.clicked=0;
                        break;
                    }
                }
            }
        }
    }
}
