public class ShelfManager
{
    private int whiteSock;          /* contains count of white sock pairs */
    private int blackSock;          /* contains count of black sock pairs */
    private int blueSock;           /* contains count of blue sock pairs */
    private int greySock;           /* contains count of grey sock pairs */

    public ShelfManager()
    {
        this.whiteSock = 0;
        this.blackSock = 0;
        this.blueSock = 0;
        this.greySock = 0;
    }

    /* increments the number of sock pairs */
    public void putOnShelf(int sockID)
    {
        if(sockID == 1)
            whiteSock++;
        else if(sockID == 2)
            blackSock++;
        else if(sockID == 3)
            blueSock++;
        else
            greySock++;
    }

    /* after all robot threads are closed, this function is called to display the 
    pairs of socked formed finally */
    public void output()
    {
        System.out.println();
        System.out.println("Process of picking socks is complete!!");
        System.out.println("Total No of pairs present are: ");
        System.out.println("White Socks: " + whiteSock);
        System.out.println("Black Socks: " + blackSock);
        System.out.println("Blue Socks: " + blueSock);
        System.out.println("Grey Socks: " + greySock);
    }
}