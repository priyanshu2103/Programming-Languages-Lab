import java.io.*;
import java.util.concurrent.*;
import java.util.*;


public class SockMatcher
{
    private int num_robots;                     /* number of robotic arms */        
    private List<Integer> socks;                /* contains list of socks */
    private List<Semaphore> locks;              /* to allow concurrent access, we place a semaphore on each sock */        
    private MatchingMachine matchingMachine;    /* simulates the matching of socks */
    private ShelfManager shelfManager;          /* variable to access output of shelf manager */
    private List<RobotArm> robotArms;           /* list contains object of RoboArm class (which corresponds to each robotic arm) */
    private Random rand;                        /* random number generator, each arm will pick random sock */

    /* function starts all the robotic arms concurrently and returns
    when no sock is left to be picked. Finally outputs the pairs formed */
    private void startSystem()
    {
        try
        {
            for(RobotArm robot:robotArms)
                robot.start();
            
            for(RobotArm robot:robotArms)
                robot.join();
            
            shelfManager.output();
        }
        catch (InterruptedException ex)
        {
            System.out.println(ex);
        }
    }

    /* makes a list of semaphores corresponding to each sock. Each sock can be
    accessed by only one arm, so we initialize the semaphore constructor by 1 */
    private void initializelocks()
    {
        locks = new ArrayList<>();
        for(int i=0;i<socks.size();i++)
        {
            Semaphore sem = new Semaphore(1);
            locks.add(sem);
        }
    }

    /* makes a list of objects of RobotArm class. Each robot of this class will
    be given a unique ID. */
    private void createRoboticArms()
    {
        robotArms = new ArrayList<>();
        for(int i=0;i<num_robots;i++)
        {
            RobotArm robot = new RobotArm(matchingMachine, this, i+1);
            robotArms.add(robot);
        }
    }

    /* constructor of SockMatcher class. Initializes the number of robotic arms and 
    the list of socks(taken from input). Instances of ShelfManager and MatchingMachine class
    created to access various methods. Also, locks are initialized */
    private SockMatcher(int numOfRobots, List<Integer> Socks)
    {
        num_robots = numOfRobots;
        socks = Socks;

        shelfManager = new ShelfManager();
        matchingMachine = new MatchingMachine(shelfManager);

        createRoboticArms();
        initializelocks();

        rand = new Random();
    }

    /* this is piece of code which concurrently many threads would be able to execute and hence
    synchronization needs to be done. Each robotic arm will select a sock randomly and check if it's
    already taken or not(implemented using semaphore). If it's occupied, this function will be called
    recursively. */
    public int getSock()
    {
        int rand_int;
        boolean flag = false;

        /* this block needs to be in synchronization because socks size may be changed by different
        thread, resulting in some unreasonable random sock ID */
        synchronized (this)
        {
            if(socks.size() > 0)
            {   
                rand_int = rand.nextInt(socks.size());
                flag = locks.get(rand_int).tryAcquire();            /* checks if a sock can be acquired or not */
            }
            else
                return -1;
        }
        // flag = locks.get(rand_int).tryAcquire();

        /* after acquiring the sock, remove it from the socks list */
        if(flag && rand_int<socks.size())
        {   
            int sockID = socks.get(rand_int);
            socks.remove(rand_int);
            locks.remove(rand_int);
            return sockID;
            // int sockID;
            // synchronized (socks)
            // {
            //     sockID = socks.get(rand_int);
            //     socks.remove(rand_int);
            // }
            // return sockID;
        }
        else
            return this.getSock();
    }

    /* Entry point of code */
    public static void main(String []args) throws FileNotFoundException
    {
        /* read the file that contains the input data which is num of robots and
        the socks of various types as an input array */
        try
        {
            File file = new File("input.txt");                    
            Scanner scanner = new Scanner(file);

            int numOfRobots = scanner.nextInt();
            List<Integer> Socks = new ArrayList<>();
            while(scanner.hasNextInt())
            {
                Socks.add(scanner.nextInt());
            }

            SockMatcher sockMatcher = new SockMatcher(numOfRobots,Socks);
            sockMatcher.startSystem();
        }
        catch(FileNotFoundException ex)
        {
            System.out.println("Input file not found");
        }
    }
}