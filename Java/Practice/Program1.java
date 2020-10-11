import java.util.*;

class Multi extends Thread
{
    public void run()
    {
        System.out.println("thread is running...");
    }
}

class Multi3 implements Runnable{
    public void run()
    {
        System.out.println("New Thread is running...");
        System.out.println("It's id is "+Thread.currentThread().getId());
    }
}

class Program1{
    public static void main(String[] args)
    {
        // Multi t1=new Multi();
        // t1.start();
        System.out.println("ID of the main thread is "+Thread.currentThread().getId());
        Multi3 m1=new Multi3();
        Thread t1 =new Thread(m1);
        Multi3 m2=new Multi3();
        Thread t2 =new Thread(m2);
        Multi3 m3=new Multi3();
        Thread t3 =new Thread(m3);
        Multi3 m4=new Multi3();
        Thread t4 =new Thread(m4);
        t1.start();
        t2.start();
        t3.start();
        t4.start();
        // Set<Thread> threadSet = Thread.getAllStackTraces().keySet();
        System.out.println("Lol "+Thread.activeCount());
    }
}