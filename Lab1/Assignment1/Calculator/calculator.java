import java.awt.event.*; 
import javax.swing.*; 
import java.awt.*; 

class calculator extends JFrame implements KeyListener {  
	private JFrame jf;                                  /* create a Jframe */               
    private JTextField tf;                              /* create a text field */
    private JPanel displayPanel;                        /* panel of integer buttons */
    private JPanel keyPanel;                            /* panel of operator buttons and STOP button */
    private JPanel operatorPanel;                       /* panel of textfield, which displays result */
    private JButton[] keyButtons = new JButton[10];     /* contains integer buttons */
    private JButton beq;
    private JButton badd;
    private JButton bsub;
    private JButton bmul;
    private JButton bdiv;
    private JButton bstop;

    /* add buttons 0-9, 4 operator buttons, 1 "equals to" button and one STOP Button denoted by Z */
    public void addButtonsToPanel()
    {
        tf = new JTextField(36);
        tf.setEditable(false);
        displayPanel.add(tf);

        keyPanel.setLayout(new GridLayout(4,3,3,3));
        for(int i=0;i<10;i++)
        {
            JButton bnew = new JButton(Integer.toString(i));
            bnew.setPreferredSize(new Dimension(5,5));
            bnew.addKeyListener(this);
            bnew.setBackground(Color.GRAY);
            keyButtons[i] = bnew;
            keyPanel.add(bnew);
        }
        
        operatorPanel.setLayout(new GridLayout(1,6,3,3));
        badd = new JButton("+"); 
        badd.setPreferredSize(new Dimension(40,40));
        badd.addKeyListener(this);
        badd.setBackground(Color.GRAY);
        operatorPanel.add(badd);

        bsub = new JButton("-"); 
        bsub.setPreferredSize(new Dimension(40,40));
        bsub.addKeyListener(this);
        bsub.setBackground(Color.GRAY);
        operatorPanel.add(bsub);

        bmul = new JButton("*"); 
        bmul.setPreferredSize(new Dimension(40,40));
        bmul.addKeyListener(this);
        bmul.setBackground(Color.GRAY);
        operatorPanel.add(bmul);

        bdiv = new JButton("/"); 
        bdiv.setPreferredSize(new Dimension(40,40));
        bdiv.addKeyListener(this);
        bdiv.setBackground(Color.GRAY);
        operatorPanel.add(bdiv);

        beq = new JButton("="); 
        beq.setPreferredSize(new Dimension(40,40));
        beq.addKeyListener(this);
        beq.setBackground(Color.GRAY);
        operatorPanel.add(beq);

        bstop = new JButton("Z"); 
        bstop.setPreferredSize(new Dimension(40,40));
        bstop.addKeyListener(this);
        bstop.setBackground(Color.GRAY);
        operatorPanel.add(bstop);

    }

    public void designCalculator()
    {
        jf = new JFrame("calculator"); 
        displayPanel = new JPanel();                     /* create a panel of numbers */
        keyPanel = new JPanel();                         /* create a panel of operators */
        operatorPanel = new JPanel();                    /* create a panel of display field */
        addButtonsToPanel();                             /* adds buttons to panels */

        jf.add(displayPanel,BorderLayout.PAGE_START);
        jf.add(keyPanel,BorderLayout.CENTER); 
        jf.add(operatorPanel,BorderLayout.PAGE_END);
        jf.setResizable(false);
		jf.setSize(700, 700); 
		jf.setVisible(true); 
    }

    public void startCalculating()
    {
        int flag = 0;
        while(true)
        {
            if(flag==0)
            {
                for(int i=0;i<10;i++)
                {
                    keyButtons[i].setBackground(Color.GREEN);
                    try
                    {
                        Thread.sleep(2000);
                    }
                    catch(Exception ex)
                    {
                        System.out.println(ex);
                    }
                    keyButtons[i].setBackground(Color.GRAY);
                }
                bstop.setBackground(Color.GREEN);
                try
                {
                    Thread.sleep(2000);
                }
                catch(Exception ex)
                {
                    System.out.println(ex);
                }
                bstop.setBackground(Color.GRAY);
                flag=1;
            }
            else
            {
                // 3s highlight cell
                break;
            }
        }
    }

	public static void main(String args[]) 
	{
        calculator calc = new calculator(); 
        calc.designCalculator();
        calc.startCalculating();
        try{ 
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());        /* set look and feel */
		} 
		catch(Exception e){ 
			System.err.println(e.getMessage()); 
		}                       		
    } 
    
	public void keyPressed(KeyEvent e) 
	{ 
        int keyCode = e.getKeyCode();
        System.out.println(keyCode);
    }
    
    public void keyReleased(KeyEvent e)
    {

    }

    public void keyTyped(KeyEvent e)
    {
        
    }
} 
