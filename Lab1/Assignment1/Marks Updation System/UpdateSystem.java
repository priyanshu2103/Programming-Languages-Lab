import java.io.*;
import java.util.*;

public class UpdateSystem
{
    private static Scanner scanner = new Scanner(System.in);            
    private Map<String,ArrayList<String>> marksData;        /* hashmap which reads marks of student, with roll as key */               
    private ArrayList<ArrayList<String>> markUpdates;       /* contains list of new marks given by instructors */

    /* constructor */
    public UpdateSystem()
    {
        marksData = new HashMap<>();
        markUpdates = new ArrayList<>();
    }

    /* method which reads the data of individual student from Stud_Info.txt file
       and adds it into marksData map */
    private void readMarks()
    {
        try
        {
            BufferedReader br = new BufferedReader(new FileReader("Stud_Info.txt"));
            
            String line;
            while ((line = br.readLine()) != null)
            {
                String[] tokens = line.split(",");              /* Stud_Info.txt is a comma separated file */
                ArrayList<String> temp = new ArrayList<>();
                for(int i=1;i<tokens.length;i++)
                    temp.add(tokens[i]);
                marksData.put(tokens[0], temp);                 /* student's info corresponding to their roll no */
            }
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
    }

    /* methods which asks user to their credentials, instructors can either be CC, TA1, TA2 */
    private String getTeacherCredentials()
    {
        System.out.println("Enter instructor credentials");
        String teacher = scanner.next();

        if(teacher.equals("CC") || teacher.equals("TA1") || teacher.equals("TA2"))
            return teacher;
        else
        {
            System.out.println("Wrong credential!!!You can only enter either CC, TA1 or TA2");
            return getTeacherCredentials();
        }
    }

    /* method which asks instructor to input the roll no of the student whose marks
       they want to update. User if prompted again if the roll number entered is not in 
       the record */
    private String getRollNumber()
    {
        System.out.println("Enter Roll number of student whose marks is to be updated.");
        String rollNumber = scanner.next();
        
        if(marksData.get(rollNumber) != null)
            return rollNumber;
        else
        {
            System.out.println("This Roll number does not exist in record.Please enter a correct roll number");
            return getRollNumber();
        }
    }

    /* method which takes as input the change in marks to be done */
    private String getMarkChanges()
    {
        System.out.println("Press:");
        System.out.println("1 to increase marks");
        System.out.println("2 to decrease marks");

        int option = scanner.nextInt();
        if(option == 1)
        {
            System.out.println("Increase marks by:");
            int deltaMarks = scanner.nextInt();
            return String.valueOf(deltaMarks);
        }
        else if(option == 2)
        {
            System.out.println("Decrease marks by:");
            int deltaMarks = scanner.nextInt();
            return String.valueOf(-deltaMarks);
        }
        else
        {
            System.out.println("Choose correct option!");
            return getMarkChanges();
        }
    }

    /* this method inserts the details of changes in student's marks to be made and adds it to
       markUpdates arraylist, which will help in updation of records later */
    private void recordMarksUpdate()
    {
        String teacher = getTeacherCredentials();
        String rollNumber = getRollNumber();
        String deltaMarks = getMarkChanges();

        ArrayList<String> temp = new ArrayList<>();
        temp.add(teacher);
        temp.add(rollNumber);
        temp.add(deltaMarks);
        markUpdates.add(temp);
    }

    /* modifies the marksData hashmap with the new data */
    private void updateData(ArrayList<String> record, int deltaMarks, String updatedBy)
    {
        /* if a record is previously modified by "CC", it can only be modified further by "CC" only */
        if (record.get(3).equals("CC") && !updatedBy.equals("CC"))
        {
            return;
        }
        
        int marks = Integer.parseInt(record.get(2));
        marks = marks + deltaMarks;                     /* make the required changes in marks */
        record.set(2, String.valueOf(marks));
        record.set(3, updatedBy);
    }

    /* called by Instructor class, it uses block synchronization to change the marks of 
       students concurrentlye by passing the "updatedBy" parameter */
    public void changeMarksQuery(String rollNumber, int deltaMarks, String updatedBy)
    {
        if(marksData.get(rollNumber) != null)
        {
            synchronized (marksData.get(rollNumber))
            {
                updateData(marksData.get(rollNumber), deltaMarks, updatedBy);
            }
        }
    }

    /* method which writes the changes made by the System to the
       Stud_Info.txt file from marksData hashmap, which contains the new records */
    private void writeChangesToFile()
    {
        try
        {
            FileWriter updatedFile = new FileWriter("Stud_Info.txt");

            for(Map.Entry<String,ArrayList<String>> entry : marksData.entrySet())
            {
                ArrayList<String> temp = new ArrayList<>();
                temp.add(entry.getKey());
                for(String x:entry.getValue())
                    temp.add(x);
                
                String line="";
                for(int i=0;i<temp.size();i++)
                {
                    line+=temp.get(i);
                    if(i != temp.size()-1)
                        line+=",";
                }
                line+="\n";
                updatedFile.write(line);
            }
            updatedFile.close();
        }
        catch(IOException e)
        {
            System.out.println("An error occured while writing changes!");
            e.printStackTrace();
        }

    }

    private void updateMarks()
    {
        Instructor courseCoord = new Instructor(this, "CC", Thread.MAX_PRIORITY);   /* because CC has highest priority */
        Instructor teachAss1 = new Instructor(this, "TA1", Thread.NORM_PRIORITY);
        Instructor teachAss2 = new Instructor(this, "TA2", Thread.NORM_PRIORITY);

        /* add the update queries into individual instructor's buffer */
        for(ArrayList<String> entry : markUpdates)
        {
            String teacher = entry.get(0);
            String rollNumber = entry.get(1);
            String deltaMarks = entry.get(2);

            if(teacher.equals("CC"))
            {
                courseCoord.updateBuffer(rollNumber, deltaMarks);
            }
            else if(teacher.equals("TA1"))
            {
                teachAss1.updateBuffer(rollNumber, deltaMarks);
            }
            else if(teacher.equals("TA2"))
            {
                teachAss2.updateBuffer(rollNumber, deltaMarks);
            }
        }
        markUpdates.clear();            /* no need of this, as the info stored in it has been used */

        /* start threads for concurrency */
        courseCoord.start();
        teachAss1.start();
        teachAss2.start();

        /* wait for all the threads to finish their execution */
        try
        {
            courseCoord.join();
            teachAss1.join();
            teachAss2.join();
        }
        catch(InterruptedException e)
        {
            e.printStackTrace();
        }

        writeChangesToFile();           /* write the final changes to Stud_Info.txt file */
    }

    /* method creates a sorted file by roll number, of Student's data */
    private void sortedRollData()
    {
        try
        {
            FileWriter sortedFile = new FileWriter("Sorted_marks_by_roll.txt");

            readMarks();                                                            /* to ensure we have fresh data */
            TreeMap<String,ArrayList<String>> treeMap = new TreeMap<>(marksData);   /* treemap has keys sorted */
            
            /* iterating the TreeMap which contains keys(roll numbers) sorted,
               writes the data from Stud_Info.txt in a comma separated manner */
            for(Map.Entry<String,ArrayList<String>> entry : treeMap.entrySet())
            {
                String rollNumber = entry.getKey();
                ArrayList<String> temp = entry.getValue();
                String line="";
                line += rollNumber;
                for(String x:temp)
                {
                    line+=",";
                    line+=x;
                }
                line+="\n";
                sortedFile.write(line);
            }

            sortedFile.close();
            System.out.println("Sorted marks file generated");
        }
        catch(IOException e)
        {
            System.out.println("Error occured while creating sorted file");
            e.printStackTrace();
        }
    }

    /* method creates a sorted file by Name, of Student's data */
    private void sortedNameData()
    {
        try
        {
            readMarks();                                                            /* to ensure we have fresh data */
            
            /* create a 2D arraylist from marksData hashmap, which will be used for sorting */
            ArrayList<ArrayList<String>> sortedArray = new ArrayList<>();
            for(Map.Entry<String,ArrayList<String>> entry : marksData.entrySet())
            {
                ArrayList<String> temp = new ArrayList<>();
                temp.add(entry.getKey());
                for(String x:entry.getValue())
                    temp.add(x);
                sortedArray.add(temp);
            }

            /* custom sort method which sorts on the basis of name(which is at index 1 in arraylist) */
            Collections.sort(sortedArray, new Comparator<ArrayList<String>>() {    
                @Override
                public int compare(ArrayList<String> o1, ArrayList<String> o2) {
                    return o1.get(1).compareTo(o2.get(1));
                }               
            });

            /* iterating the sortedArray which contains data sorted by Name,
               writes the data from sortedArray in a comma separated manner */
            FileWriter sortedFile = new FileWriter("Sorted_marks_by_name.txt");
            for(int i=0;i<sortedArray.size();i++)
            {
                String line="";
                for(int j=0;j<sortedArray.get(i).size();j++)
                {
                    line+=sortedArray.get(i).get(j);
                    if(j!=sortedArray.get(i).size()-1)
                        line+=",";
                }
                line+="\n";
                sortedFile.write(line);
            }

            sortedFile.close();
            System.out.println("Sorted marks file generated");
        }
        catch(IOException e)
        {
            System.out.println("Error occured while creating sorted file");
            e.printStackTrace();
        }
    }

    public static void main(String[] args)
    {
        UpdateSystem updateSystem = new UpdateSystem();
        updateSystem.readMarks();

        while(true)
        {
            System.out.println("Press:");
            System.out.println("1 for updating student marks");
            System.out.println("2 for writing changes to marks file");
            System.out.println("3 for generating marks file sorted by Roll number");
            System.out.println("4 for generating marks file sorted by Name");
            System.out.println("Any other key to exit");
            
            int option;
            option = scanner.nextInt();
            
            if(option == 1)
            {
                updateSystem.recordMarksUpdate();           /* record your queries */
            }
            else if(option == 2)
            {
                updateSystem.updateMarks();                 /* make changes in Stud_Info filed based on queries */
            }
            else if(option == 3)
            {
                updateSystem.sortedRollData();              /* generate file sorted by roll no */
            }
            else if(option == 4)
            {
                updateSystem.sortedNameData();              /* generate file sorted by name */
            }
            else
            {
                break;
            }
        }
    }
}