public class RobotArm extends Thread
{
    private MatchingMachine matchingMachine;            /* instance of MatchingMachine used for calling matchPairs() method */
    private SockMatcher sockMatcher;                    /* instance of SockMatcher used for picking a sock using getSock() method */
    private int roboID;                                 /* unique ID of robotic arm */
    private String[] sockColor = new String[4];         /* array which maps sockID to their color */

    /* constructor */
    public RobotArm(MatchingMachine matchingMachine, SockMatcher sockMatcher, int roboID)
    {
        this.matchingMachine = matchingMachine;
        this.sockMatcher = sockMatcher;
        this.roboID = roboID;
        sockColor[0]="White";sockColor[1]="Black";sockColor[2]="Blue";sockColor[3]="Grey";
    }

    @Override
    public void run()
    {
        /* each robotic Arm will be picking socks until socks run out.
        when sockID is returned -1, it means all socks has been picked */
        while(true)
        {
            int sockID = sockMatcher.getSock();
            if(sockID == -1)
            {
                System.out.println("Robot Arm " + roboID + " has stopped!");
                break;
            }
            
            System.out.println("Robot Arm " + roboID + " picked " + sockColor[sockID-1] + " sock");
            matchingMachine.matchPairs(sockID);
        }
    }
}