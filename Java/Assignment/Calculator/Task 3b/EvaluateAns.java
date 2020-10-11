import java.util.Stack;

public class EvaluateAns
{
    /* Returns true if 'op2' has higher or same precedence as 'op1',
       otherwise returns false. */
    public static boolean checkPrecedence(char op1, char op2)
    {
        if ((op1 == '*' || op1 == '/') && (op2 == '+' || op2 == '-'))
            return false;
        else
            return true;
    }

    /* returns the result of <a op b> */
    public static int operation(char op, int a, int b)
    {
        switch (op)
        {
            case '+':
                return a+b;
            case '-':
                return a-b;
            case '*':
                return a*b;
            case '/':
                if (b==0)
                {
                    throw new
                            UnsupportedOperationException("Cannot divide by zero");
                }
                return a/b;
        }
        return 0;
    }

    public static void evaluate()
    {
        String query = Calculator.displayArea.getText();          /* getting the query string that needs to be evaluated */
        Stack<Integer> keys = new Stack<>();                /* stack contains integers */
        Stack<Character> operators = new Stack<>();         /* stack contains operators */

        for (int i = 0; i < query.length(); i++)
        {
            /* since the query can contain more than 1 digit numbers, we convert it into
               string and then get the integer value from that string */
            if (query.charAt(i) >= '0' && query.charAt(i) <= '9')
            {
                StringBuilder stringBuilder = new StringBuilder();
                while (i < query.length() && query.charAt(i) >= '0' && query.charAt(i) <= '9')
                {
                    stringBuilder.append(query.charAt(i));
                    i++;
                }
                keys.push(Integer.parseInt(stringBuilder.toString()));
            }

            if(i>=query.length())
                break;

            /* we put the operators in stack according to their precedence order (BODMAS) */
            if (query.charAt(i) == '+' || query.charAt(i) == '-' || query.charAt(i) == '*' || query.charAt(i) == '/')
            {
                while (!operators.empty() && checkPrecedence(query.charAt(i), operators.peek()))
                    keys.push(operation(operators.pop(), keys.pop(), keys.pop()));
                operators.push(query.charAt(i));
            }
        }
        
        /* take one operator at a time from operator stack and find it's value, and push the new value in stack */
        while (!operators.empty())
            keys.push(operation(operators.pop(), keys.pop(), keys.pop()));

        int res = keys.pop();
        Calculator.displayArea.setText(Integer.toString(res));
    }

    public static void readInput(String input){
        if(input.equals("="))
        {
            evaluate();
        }
        if(input.equals("C"))
        {
            Calculator.displayArea.setText("");
        }
    }
    
}