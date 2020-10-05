public class CalcDesign
{
    public static void main(String [] args)
    {
        Calculator calc = new Calculator();                                     /* create an object of Calculator class */
        KeyHighlighter keyHighlighter = new KeyHighlighter();                   /* create an object of KeyHighlighter class */
        OperatorHighlighter operatorHighlighter = new OperatorHighlighter();    /* create an object of OperatorHighlighter class */
        calc.makeLayout();                                            
        keyHighlighter.start();
        operatorHighlighter.start();
    }
}