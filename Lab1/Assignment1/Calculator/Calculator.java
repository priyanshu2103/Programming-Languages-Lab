import java.awt.event.*; 
import javax.swing.*; 
import java.awt.*; 
import java.util.ArrayList;

class Calculator{  
	private JFrame jf;                                  /* create a Jframe */               
    private JTextField tf;                              /* create a text field */
    public JTextArea displayArea;                       /* panel of integer buttons */
    private JPanel keyPanel;                            /* panel of operator buttons and STOP button */
    private JPanel operatorPanel;                       /* panel of textfield, which displays result */
    public ArrayList<JButton> keyButtons;               /* contains integer buttons */
    public ArrayList<JButton> operatorButtons;          /* contains operator buttons */
    public JButton badd;
    public JButton bsub;
    public JButton bmul;
    public JButton bdiv;
    public JButton bstop;
    private KeyHighlighter keyHighlighter;              /* object of class that highlights num keys */
    private OperatorHighlighter operatorHighlighter;    /* object of class that highlights operator keys */
    private EvaluateAns evaluateAns;                    /* object of class EvaluateAns that evaluates the displayArea */

    /* add buttons 0-9, 4 operator buttons, 1 "equals to" button and one STOP Button denoted by Z */
    private void addButtonsToPanel()
    {
        displayArea = new JTextArea();
        displayArea.setText("");
        displayArea.setPreferredSize(new Dimension(200,60));
        displayArea.setBackground(Color.LIGHT_GRAY);
        Font font = displayArea.getFont();
        float size = font.getSize() + 5.0f;
        displayArea.setFont(font.deriveFont(size));
        displayArea.setCaretColor(Color.WHITE);

        keyPanel.setLayout(new GridLayout(4,3));
        keyButtons = new ArrayList<>();
        for(int i=0;i<10;i++)
        {
            JButton bnew = new JButton(Integer.toString(i));
            keyButtons.add(bnew);
            keyPanel.add(bnew);
        }
        bstop = new JButton("Z"); 
        keyPanel.add(bstop);
        
        operatorPanel.setLayout(new GridLayout(1,4));
        operatorButtons = new ArrayList<>();
        badd = new JButton("+"); 
        operatorButtons.add(badd);
        operatorPanel.add(badd);

        bsub = new JButton("-"); 
        operatorButtons.add(bsub);
        operatorPanel.add(bsub);

        bmul = new JButton("*"); 
        operatorButtons.add(bmul);
        operatorPanel.add(bmul);

        bdiv = new JButton("/"); 
        operatorButtons.add(bdiv);
        operatorPanel.add(bdiv);

    }

    private void designCalculator()
    {
        jf = new JFrame("Calculator"); 
        keyPanel = new JPanel();                         /* create a panel of numbers */
        operatorPanel = new JPanel();                    /* create a panel of operators */
        addButtonsToPanel();                             /* adds buttons to panels */

        jf.add(displayArea,BorderLayout.PAGE_START);
        jf.add(keyPanel,BorderLayout.CENTER);
        jf.add(operatorPanel,BorderLayout.PAGE_END);
        jf.setResizable(false);
		jf.setSize(700, 700); 
		jf.setVisible(true); 
    }

    private void addKeyListener()
    {
        jf.addKeyListener(new KeyListener()
        {
            @Override
            public void keyTyped(KeyEvent ke) {

            }

            @Override
            public void keyPressed(KeyEvent ke) {
                int keyCode = ke.getKeyCode();

                if(keyCode == KeyEvent.VK_ENTER)
                {
                    for(JButton button : keyButtons)
                    {
                        if(button.getBackground() == Color.GREEN)
                        {
                            displayArea.append(button.getText());
                            evaluateAns.readInput(button.getText());
                            break;
                        }
                    }
                    if(bstop.getBackground()==Color.GREEN)
                        evaluateAns.readInput(bstop.getText());
                }
                else if(keyCode == KeyEvent.VK_SPACE)
                {
                    // Check which functionKey has green background color
                    for(JButton button : operatorButtons)
                    {
                        if(button.getBackground() == Color.ORANGE)
                        {
                            displayArea.append(button.getText());
                            evaluateAns.readInput(button.getText());
                            break;
                        }
                    }
                }
            }

            @Override
            public void keyReleased(KeyEvent ke) {

            }     
        });
    }

    public void calculate(Calculator calc)
    {
        evaluateAns = new EvaluateAns(calc);
        keyHighlighter = new KeyHighlighter(calc);
        operatorHighlighter = new OperatorHighlighter(calc);
        keyHighlighter.start();
        operatorHighlighter.start();
    }

	public static void main(String args[]) 
	{
        Calculator calc = new Calculator(); 
        calc.designCalculator();
        calc.addKeyListener();
        calc.calculate(calc);

        try{ 
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());        /* set look and feel */
		} 
		catch(Exception e){ 
			System.err.println(e.getMessage()); 
		}                       		
    } 
} 
