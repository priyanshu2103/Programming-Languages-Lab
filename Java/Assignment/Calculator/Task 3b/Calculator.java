import java.awt.event.*; 
import javax.swing.*; 
import java.awt.*; 
import java.util.ArrayList;

class Calculator{  
	static JFrame jf;                                  /* create a Jframe */               
    static JTextArea displayArea;                      /* area to display calculations */
    static ArrayList<JButton> keyButtons;              /* contains integer buttons */
    static ArrayList<JButton> operatorButtons;         /* contains operator buttons */
    static JButton badd;
    static JButton bsub;
    static JButton bmul;
    static JButton bdiv;
    static JButton beq;
    static JButton bclear;

    /* add buttons 0-9, 4 operator buttons, 1 CLEAR button and one EQUALS Button denoted by = to our frame */
    private static void addButtonsToPanel()
    {

        /* setting properties of display area */
        displayArea = new JTextArea();
        displayArea.setText("");
        displayArea.setPreferredSize(new Dimension(200,60));
        displayArea.setBackground(Color.LIGHT_GRAY);
        Font font = displayArea.getFont();
        float size = font.getSize() + 7.0f;
        displayArea.setFont(font.deriveFont(size));


        /* created a grid layout panel for integer keys and clear, equal key
           added integer buttons and clear,equal button to keyButton array used for
           highlighting keys later with GREEN color */
        JPanel keyPanel = new JPanel();
        keyPanel.setLayout(new GridLayout(4,3));
        keyButtons = new ArrayList<>();
        for(int i=0;i<10;i++)
        {
            JButton bnew = new JButton(Integer.toString(i));
            keyButtons.add(bnew);
            keyPanel.add(bnew);
        }
        bclear = new JButton("C"); 
        keyPanel.add(bclear);
        beq = new JButton("="); 
        keyPanel.add(beq);
        
        /* created a grid layout panel for operator keys(+,-,*,/)
           added operator buttons to operatorBUtton array used for
           highlighting keys later with YELLOW color */
        JPanel operatorPanel = new JPanel();
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

        /* added display area, keyPanel and operatorPanel to frame */
        jf.add(displayArea,BorderLayout.PAGE_START);
        jf.add(keyPanel,BorderLayout.CENTER);
        jf.add(operatorPanel,BorderLayout.PAGE_END);

    }

    /* method to detect key pressed by the user
       Key Listener interface contains 3 methods out of which
       we only require keyPressed method */
    private static void addKeyListener()
    {
        jf.addKeyListener(new KeyListener()
        {
            @Override
            public void keyPressed(KeyEvent ke) {
                int keyCode = ke.getKeyCode();                          /* detects the key which is pressed */

                /* if ENTER is pressed, we need to see which integer key or equal/clear
                   is chosen which can be detected by seeing which button is GREEN */
                if(keyCode == KeyEvent.VK_ENTER)
                {
                    for(JButton button : keyButtons)
                    {
                        if(button.getBackground() == Color.GREEN)
                        {
                            displayArea.append(button.getText());       /* add the selected key to calculator display */           
                            EvaluateAns.readInput(button.getText());    /* send this selected key for evaluation */
                            break;
                        }
                    }
                    if(beq.getBackground()==Color.GREEN)
                        EvaluateAns.readInput(beq.getText());
                    if(bclear.getBackground()==Color.GREEN)
                        EvaluateAns.readInput(bclear.getText());
                }

                /* if SPACE is pressed, we need to see which operator key
                   is chosen which can be detected by seeing which button is YELLOW */
                if(keyCode == KeyEvent.VK_SPACE)
                {
                    for(JButton button : operatorButtons)
                    {
                        if(button.getBackground() == Color.YELLOW)
                        {
                            displayArea.append(button.getText());
                            EvaluateAns.readInput(button.getText());
                            break;
                        }
                    }
                }
            }

            @Override
            public void keyReleased(KeyEvent ke) {

            }     
            @Override
            public void keyTyped(KeyEvent ke) {
                
            }
        });
    }

	public static void makeLayout() 
	{
        jf = new JFrame("Calculator");              /* create a new frame */ 
        jf.setResizable(false);                     
        jf.setSize(700, 700);

        addButtonsToPanel();
        addKeyListener();

        jf.setVisible(true);                        /* makes the frame visible */
        jf.setFocusable(true);

        try{ 
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());        /* set look and feel */
		} 
		catch(Exception e){ 
			System.err.println(e.getMessage()); 
		}                       		
    } 
} 
