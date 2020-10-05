import javax.swing.*;
import java.awt.*;
import java.util.concurrent.TimeUnit;


public class KeyHighlighter extends Thread
{
    private Calculator calc;

    public KeyHighlighter(Calculator calc)
    {
        this.calc = calc;
    }

    public void run()
    {
        while(true)
        {
            for(JButton button : calc.keyButtons)
            {
                button.setBackground(Color.GREEN);
                try {
                    TimeUnit.SECONDS.sleep(2);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                button.setBackground(null);
            }

            calc.bstop.setBackground(Color.GREEN);
            try {
                TimeUnit.SECONDS.sleep(2);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            calc.bstop.setBackground(null);

        }
    }
}