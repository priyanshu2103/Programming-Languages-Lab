import java.util.*;

public class Instructor extends Thread
{
    private UpdateSystem updateSystem;
    private ArrayList<ArrayList<String>> updateRecords;                 /* contains info about roll no and updated marks */

    /* constructor */
    Instructor(UpdateSystem updateSystem, String name, int priority)
    {
        this.updateSystem = updateSystem;
        setName(name);                      /* assigns name to the thread */
        setPriority(priority);              /* assigns priority to the thread */
        updateRecords = new ArrayList<>();
    }

    /* adds the update queries to instructor's local buffer */
    public void updateBuffer(String rollNumber, String deltaMarks)
    {
        ArrayList<String> temp = new ArrayList<>();
        temp.add(rollNumber);
        temp.add(deltaMarks);
        updateRecords.add(temp);
    }

    public void run()
    {
        for(int i=0;i<updateRecords.size();i++)
        {
            updateSystem.changeMarksQuery(updateRecords.get(i).get(0), Integer.parseInt(updateRecords.get(i).get(1)),
                                          getName());
        }
        updateRecords.clear();
    }
}