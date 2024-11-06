what is the point of this program?
the point is to automate the pomodoro technique. i forget the person responsible for creating this productivity technique but it works so i want to translate it into an application for my own use. this idea was born out of me writing down my pomodoros in my notebook but failing to time myself. what i need is an application that times me and forces me to take my little breaks in between sprints.

how does the pomodoro technique work?
each task you have to accomplish is referred to as a "pomodoro". this word means tomato in italian. anyways, the basic idea is for you to list your pomodoros and break them down into smaller, manageable pomodoros. you work in sprints of time defined by yourself. for example a 30 minute sprint. if you manage to achieve say 3 pomodoros within that 30 minute sprint, you can take a 30 minute break. if you dont accomplish this, take a 7 minute break and return to your pomodoros.

i will start working on this application in python and may translate it into java eventually. for now, i want it to build a command line interface to keep things simple. as the weeks progress, ill build on that to hopefully incorporate a graphical user interface.

for now, all i want my app to do is allow users to set their sprint time, set their pomodoros, and determine the number of minutes a break would be, which will be dependent on the sprint time and the number of pomodoros. i think working with json objects would make sense in this case but for now, i will just store a users pomodoros in a list.

Im pretty sure there is a datetime module in python that i can use to time a users sprints and breaks. how long should a break between sprints be if a user has 4 pomodoros and set their sprint time to 30 minutes