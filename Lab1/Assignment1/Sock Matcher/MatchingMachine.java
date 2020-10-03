public class MatchingMachine
{
    private boolean white_sock;         
    private boolean black_sock;
    private boolean blue_sock;
    private boolean grey_sock;
    private ShelfManager shelfManager;

    public MatchingMachine(ShelfManager shelfManager)
    {
        this.white_sock = false;
        this.black_sock = false;
        this.blue_sock = false;
        this.grey_sock = false;
        this.shelfManager = shelfManager;       /* instance of ShelfManager used for calling putOnShelf() method */
    }

    /* we only need bool variables for matching socks. If bool of white sock is false, it means
    no white sock is in Matching Machine's buffer. If white socks come now, bool would become true.
    If bool is true and a white sock comes, then it's a pair and it would be sent to shelf manager.
    Since only one pair can be formed at a time, it is declared a synchronized function */
    public synchronized void matchPairs(int sockID)
    {
        if(sockID == 1)
        {
            if(white_sock)
            {
                shelfManager.putOnShelf(sockID);
            }
            else
                white_sock = true;
        }
        else if(sockID == 2)
        {
            if(black_sock)
            {
                shelfManager.putOnShelf(sockID);
            }
            else
                black_sock = true;
        }
        else if(sockID == 3)
        {
            if(blue_sock)
            {
                shelfManager.putOnShelf(sockID);
            }
            else
                blue_sock = true;
        }
        else
        {
            if(grey_sock)
            {
                shelfManager.putOnShelf(sockID);
            }
            else
                grey_sock = true;
        }
    }
}