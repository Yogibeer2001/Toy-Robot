THE TOY ROBOT


The Toy Robot is very popular in Melbourne. The problem involves making a robot move around a table without falling off.

This solution attempts to show SOLID programming principals and is designed to be simple yet scalable.


HOW TO RUN

clone the repo with "git clone https://github.com/Yogibeer2001/Toy-Robot.git"

Ensure you have at least v2.2.2 of ruby installed. You can check by running ruby -v in your terminal/console. Ruby can be downloaded at https://www.ruby-lang.org/en/downloads/
With ruby installed navigate to the downloaded file with your terminal
Once in the folder type ruby invade.rb and the program will run

The app itself
 I decided to split the code in 4 section

 -table
 -directions
 -robot
 -commands

 this separation was chosen to make it easily scalable and easy to add new things

The modulo allows for rotating through any given amount of directions which allows scaleability
 There is now a directions class and the robot rotates through directions.length (which is a method inside the directions). This allows the directions to be changed without causing the robot to fail. (Say someone added north-east to directions. This is now no problem and would require no change to the robot class).


The solution is attempted to be done 'The Ruby Way' by incorporating many small functions that can be easily isolated, tested and re-used.

to the robot
the robot needs to be placed on the 5x5 table (starting with 0x0) first before any other Command (except "EXIT") will work
the robot is limited to his little world (dimensions of the table)
you only can have one robot
you dont like you robot? you can destroy him anytime with "SELFDESTRUCT" Command
you want to go home and cry, just type "EXIT"

unfortunatly sound is only supported on MAC but could be later also support windows and linux systems
