import javax.swing.*;
import java.awt.*;
import java.util.concurrent.TimeUnit;


public class OperatorHighlighter extends Thread
{
    private Calculator calc;

    public OperatorHighlighter(Calculator calc)
    {
        this.calc = calc;
    }

    public void run()
    {
        while(true)
        {
            for(JButton button : calc.operatorButtons)
            {
                button.setBackground(Color.YELLOW);
                try {
                    TimeUnit.SECONDS.sleep(2);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                button.setBackground(null);
            }
        }
    }
}