export default {
  'about_me_description': `
**Quick intro**
`,
  'about_me_text': `
I am currently on my 3rd year pursuing Bachelor deegree on University of Warsaw (Faculty of Mathematics, Informatics and Mechanics).
  
I love programming. It's my passion. I am interested in various topics:
 * I love IoT ([AVR stuff](https://github.com/styczynski/avr-weather-esp8266)) and programming FPGAs
 * I love real-time hardcore distributed systems!
 * I love making frontend :))
 * I like Machine Learning, but it's highly amateur stuff for now. I also organised this [PL in ML Conference](http://plinml.mimuw.edu.pl) with friends of mine ;)
 * I really like functional languages and written frontend in Mathamatica for n-dimensional tic-tac-toe game (hey, you did what?) [see here](https://github.com/styczynski/mathematica-playground)

I love assembly, low level-hacking things and I can be categorised as a geek who can't wait to know how that *new cutting-edge technology works*. 

**Now you can scroll down. Hover and click things to see why I did *that strange project* or read some details about me :))**
**Good luck explorer!**
`,
  'open_source_description': `
**Limitless universe**

I love to make software. I love the Open Source.
Below few of my open projects are included.

They are mostly done in part-time so maintenece is not as good as I think it should be.
`,
  'experiments_description': `
**Exploring new worlds**

As I am still a student I've got time for playing and making experiments with various toolings and software.
  
The recent achievements I am most proud of are:
`,
  'space_junk_description': `
**You entered a space junk area - outer hull may damage in contact with fast micro obejcts.**

This is area of obscure, old code that's not maintained in any way.
This was written years ago and published more recently.
The code hangs there for me only as a documentation of my interests before highscool (proof of beeing hackish child from the begining of time?)
`,
  'pl_in_ml_description': `
**PL in ML: Polish View on Machine Learning**
  
It's a conference done in spare time by my and my friends. I was responsible for preparing (all set up by myself with help from two of my collegues with content fromatting and mechanical UI fixes).
The system needed to be bulletproof and ready for participats to register.
  
It was huge task. I programmed backend (PHP + Laravel), frontend (React), CI, set up Docker with our custom image.
`,
  'pl_in_ml_more': `
  The work was done in spare time i.e. during weekend. From that perspective it's an achievement to work as a full-time and launch conference during afternoons ;)
`,
  'messagetube_description': `
**MessageTube** is an interface when user can enter some set of words like "Mom loves cats"
and gets 3 videos from YT where people sing or say words "Mom" then "loves" and then "cats"
It's like Giphy, but more.
Beneath this is using force alignment and YouTube caption extraction.
Our work (MessageTube was made by my friends and me) got 3rd prize on Facebook Warsaw Hackaton 2018).
`,
  'messagetube_more': `
I love hackatons, because you can see all the people with their fantastic energy, motivation and lots of love for programming.
It's so cool, I love that!
`
  'atom_terminal_panel_description': `
Plugin for ATOM Editor. Advanced terminal interface for Atom editor
`,
  'atom_terminal_panel_more': `
This plugin was written in my spare time when I was preparing myself for Informatics Olimpiad (in Poland).
As I needed something to relax from the olympic problems I enjoyed writing an Atom plugin.

I am trying to maintain that, but I have no more time so someone probably will take ownership of that?
`,
  'autocomplete_js_description': `
Plugin for ATOM Editor. Advanced terminal interface for Atom editor
`,
   'autocomplete_js_more': `
JQuery plugin for autocompletion inspired by [Lorenzo Puccetti - complete-ly.js](https://complete-ly.appspot.com/).

This is a plugin I wrote espiecially for Atom terminal plugin I was then writing to get to know how autocompletion is implemented in real world.
`,
  'weatherly_description': `
Nice looking weather fetcher written in Java using JavaRx - reactive programming.
`,
   'weatherly_more': `
Weatherly is an Java application written mostly using JavaRx reactive programming as a part of university course (OOP).

Application is fairly nice and got A though visuals are not as facy as I wanted.
`,
  'utest_description': `
Universal bash testing script. Allows you to test any executable program or command with file input. Checks for memory leaks and measures program efficency in simplest ways.
`,
   'utest_more': `
This is **pure** sickness. +2K LOC bash universal tester called **utest** (pronounced: Micro test) is a bash script that runs programs and compares in/out/err to one specified by configuration.
What is amazing, it was superuseful when testing Informatics Olympiad solutions.
It is capable of:

* Parsing its YAML config (yep that was made in bash)
* Displaying fancy spinner
* Compiling sources (for example using GCC) if command is specified by user
* Using custom input/output parse scripts and custom testing scripts
* Unzipping or wgetting anything anywhere (just leave the zip or give him a url!)
* Autodetecting files to test (in simplest mode it requires no configuration at all!)

This was done in bash. Please do not ask how or why. It was pure fun for me.
`,
  'ipp_poly_description': `
This project is based on exercise we had to do on Warsaw University, Poland on the Individual Programistic Project subject. We had to implement polynomial calculator.
`,
  'ipp_poly_more': `
This project was a part of course at Warsaw University.
The task was divided into 3 separate subtasks:

* Provide dynamically-allocated lists implementation
* Interactive calculator for that library
* Implement additional functionality and provide basic unit tests
`,
  'avr_weather_esp8266_description': `
Weather fetching through wifi with LCD1602 + Atmega32 + ESP8266
`,
  'avr_weather_esp8266_more': `
The project demonstrates that anything is possible even making HTTP requests from AVR using ESP module.

This is a fetcher that sends HTTP request to openweathermap.com asking about weather in Warsaw then extracts
the info and displays it on LCD screen.

Really fun low level stuff.
`,
  'tic_tac_console_description': `
The game is n-dimensional classic tic-tac-toe game inside Windows terminal. Utilizes basic terminal hid-input, ascii dialog boxes and even more strange stuff!
`,
  'tic_tac_console_more': `
The game was invented by me and a friend of mine.
It's cool, beacause I managed (in highschool) to implement mouse detection in Windows terminal window and play music with beeps. 
`,
  'waccgl_description': `
Windows Advanced Console Componental Graphics Library. For making mouse-supported-ascii-based-fancy-dialog-boxes-and-ui inside Windows console window!
`,
  'waccgl_more': `
This is what powered Tic-Tac-Toe for the console. Pretty old code written by me in highschool. 
`
};