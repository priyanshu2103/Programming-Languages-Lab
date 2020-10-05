import java.util.Stack;

public class EvaluateAns
{
    private Calculator calc;

    public EvaluateAns(Calculator calc)
    {
        this.calc = calc;
    }

    public void readInput(String input){
        System.out.println(0);
        if(input.equals("Z"))
        {
            evaluate();
        }
    }

    public void evaluate()
    {
        String query = calc.displayArea.getText();

        Stack<Integer> keys = new Stack<>();

        Stack<Character> operators = new Stack<>();

        for (int i = 0; i < query.length(); i++)
        {
            if (query.charAt(i) >= '0' && query.charAt(i) <= '9')
            {
                StringBuilder stringBuilder = new StringBuilder();

                while (i < query.length() && query.charAt(i) >= '0' && query.charAt(i) <= '9')
                    stringBuilder.append(query.charAt(i++));
                keys.push(Integer.parseInt(stringBuilder.toString()));
            }
            if(i>=query.length())
                break;

            if (query.charAt(i) == '+' || query.charAt(i) == '-' ||
                    query.charAt(i) == '*' || query.charAt(i) == '/')
            {
                while (!operators.empty() && hasPrecedence(query.charAt(i), operators.peek()))
                    keys.push(applyOperation(operators.pop(), keys.pop(), keys.pop()));

                operators.push(query.charAt(i));
            }
        }


        
        while (!operators.empty())
            keys.push(applyOperation(operators.pop(), keys.pop(), keys.pop()));

        int answer = keys.pop();

        // Print the answer on the displayArea
        calc.displayArea.setText(Integer.toString(answer));
        System.out.println(answer);
    }

    // Returns true if 'op2' has higher or same precedence as 'op1',
    // otherwise returns false.
    public static boolean hasPrecedence(char op1, char op2)
    {

        if ((op1 == '*' || op1 == '/') && (op2 == '+' || op2 == '-'))
            return false;
        else
            return true;
    }

    // A utility method to apply an operator 'op' on operands 'a'
    // and 'b'. Return the result.
    public static int applyOperation(char operator, int b, int a)
    {
        switch (operator)
        {
            case '+':
                return a + b;
            case '-':
                return a - b;
            case '*':
                return a * b;
            case '/':
                if (b == 0)
                    throw new
                            UnsupportedOperationException("Cannot divide by zero");
                return a / b;
        }
        return 0;
    }
}