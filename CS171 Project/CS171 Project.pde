import g4p_controls.*; // this imports the library used for the text boxes in the project
GTextField txf1;
GTextField txf2;
GTextField txf3;
GTextField txf4;  //these statements initalize the text boxes used in the project
GTextField txf5;
String monke; 
String failrate; // this stores the failrate inputted by the user
String keypressmin;  // these variables store the range of time taken for each keypress
String keypressmax;
double num = 0.0;
double prob = 0; 
String fraction;  // this variable stores the amount of keys that the monkey could possibly press
double answer1 = 0, answer2 = 0,answer3 = 0, averageans =0; // these variables store answers
double failure1, failure2, failure3;  //this failure variable helps make the simulation more accurate but only if the user wishes to use it 
PImage background;
PImage monke1, monke2;
double finalkeycount = 0.0000000000000000000000001;
public void setup() 
{
  size(1000, 400);
  background = loadImage("banana.jpg"); //this loads the background image
  //monke1 = loadImage("monke2.gif");
  //monke2 = loadImage("monke1.gif");
  txf1 = new GTextField(this, 100, 75, 300, 70);
  txf1.setPromptText("Input text now");
  txf1.setText(""); 
  txf2 = new GTextField(this, 550, 45, 100, 20); //these lines of code resizes and positions the textboxes to where i need them
  txf2.setPromptText("Input fail rate");
  txf2.setText("20");  //code source https://discourse.processing.org/t/get-user-input-with-textbox-class/16150/9 i have modified its display output to suit my needs and have added more text boxes for user variables     
  txf3 = new GTextField(this, 550, 175, 100, 20); // this source was the main inspiration to use g4p for my text input
  txf3.setPromptText("minimum");
  txf3.setText("3");                         // i used this code as a method of text input for the project, it led me to the g4p library and helped with many aspects of the project
  txf4 = new GTextField(this, 720, 175, 100, 20);
  txf4.setPromptText("maximum");
  txf4.setText("10"); 
  txf5 = new GTextField(this, 550, 105, 100, 20);
  txf5.setPromptText("Number of Keys");  
  txf5.setText("62"); 
}

public void handleTextEvents(GEditableTextControl textcontrol, GEvent event) 
{
  if(txf1 == textcontrol && event == GEvent.ENTERED)
  {
    monke = txf1.getText();          //code source https://discourse.processing.org/t/get-user-input-with-textbox-class/16150/9 i have modified its display output to suit my needs and have added more text boxes for user variables
    num = monke.length();            // i used this code as a method of text input for the project, it led me to the g4p library and helped with many aspects of the project
    failrate = txf2.getText();
    keypressmin =txf3.getText();
    keypressmax =txf4.getText();
    fraction=txf5.getText(); //<>//
  }
  int failnum = int(failrate);
  int keynum1 = int(keypressmin);
  int keynum2 = int(keypressmax);
  int fractionnum = int(fraction);
  finalkeycount = finalkeycount + fractionnum;
  
    if (keyPressed && key == ENTER) 
    {
    monke = txf1.getText();          
    num = monke.length();
    failrate = txf2.getText();
    keypressmin =txf3.getText();
    keypressmax =txf4.getText();
    fraction=txf5.getText();
    answer1=0;
    answer2=0;
    answer3=0;
    averageans=0;
    
    
    //this a main part of the project, this is what finds the probability of the monkeys generating the text
    prob = Math.pow(1/finalkeycount , monke.length());
    
     /*this the other main part of the project, its what does most of the calculations for the answers from each 'monkey'
      it does it 3 times to help with answer variety it takes the length of the string, then uses that for the duration the for loop
      its used the keymin and max to help determine the time taken, and the failrate variable resets the loop if the monkey makes a mistake*/
     
    for(int counter =0;counter<monke.length();counter++)
    {
      failure1=random(100);
      if(failure1<failnum) // failure rate is a user set value
      {counter=0;}
      answer1 = answer1+random(keynum1,keynum2);
    }
    for(int counter =0;counter<monke.length();counter++)
    {
      failure2=random(100);
      if (failure2<failnum)
      {counter = 0;}
      answer2 = answer2+random(keynum1,keynum2);     
    }
    for(int counter =0;counter<monke.length();counter++)
    {
      failure3=random(100);
      if (failure3<failnum)
      {counter = 0;}
      answer3 = answer3+random(keynum1,keynum2); 
    }
    answer1 = answer1/60;
    answer2 = answer2/60; //this converts the answers to minutes. it makes it more manageable for the output
    answer3 = answer3/60;
    averageans = (answer1+answer2+answer3)/3; //this finds the average of the 3 monkeys answers
    
    println(monke);
    println(prob);
    println(keypressmin+" "+keypressmax);  //used this for testing in the console
    println(failnum+"% failrate"); //they did actaully help catch a major bug so i left them in so you could see them at work
    System.out.println("monke 1 time "+answer1);
    System.out.println("monke 2 time "+answer2);
    System.out.println("monke 3 time "+answer3);
    
    }
    
}
public void draw() 
{
  background(background);
   fill(0,0,0);
  rect(0,0,1000,35);
  rect(500,0,500,400);
  fill(255,0,0);
  rect(500,200,500,5);
  fill(255,255,0);
  textSize(28);
  text("the funky monkey theorem calculator",27,27);
  textSize(12);
  text("Warning, A high failure rate can take a long time",520,35);
  textSize(12);
  text("Input the rate of failure for each individual keypress for the monkeys",520,20);
  textSize(12);
  text("Input how long you estimate it would take for a monke to press a key on the keyboard ",520,150);
  text("E.g 3 to 10 seconds, so 3 goes in the left box and 10 on the right",520,165);            // all of these print statements help with the projects UI and displays the provided answers
  textSize(12);
  text("input the amount of keys on the monkeys keyboard ",520,85);
   //text("(PLEASE DO NOT REMOVE THE DECIMAL POINT) ",520,100);
  //image(monke1,0,200,200,200);
  //image(monke2,860,0,140,140);
  textSize(12);
  text("the probability of this text being generated is",510,225);
  textSize(20);
  text(prob+"",510,245);
  textSize(18);
    text("Time taken by monkey 1: "+answer1+ " minutes",510,280);
    textSize(18);
    text("Time taken by monkey 2: "+answer2+ " minutes",510,310);
    textSize(18);    
    text("Time taken by monkey 3: "+answer3+ " minutes",510,340);
    textSize(18);    
    text("Average time taken: "+averageans+ " minutes",510,370);
}
