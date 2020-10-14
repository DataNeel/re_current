# re_current

This is a very-incomplete version of the re_current library used to build midi loops and power processing sketches. You can find examples of its use at http://instagram.com/neel.shivdasani.


## Documentation v1

To get things started, here is some very brief documentation.

### some notes
* This library is built using the Processing language, which is similar to Java
* In processing, code can be split across multiple files in the program folder. This library takes advantage of that, and various functions and visualizations live in different folders
* Processing can access shader files, and they must be included in the data folder
* You will need to install the processing plugins The Midi Bus and Syphon (unless you remove syphon from your code)

### MIDI Input
* All midi inputs are processed in the file midi_input.pde
* Midi input is processed using the Processing plugin called The Midi Bus
* Midi signals are currently mapped to specific functions using if/else statements based on their channel, note, or CC. You'll need to map these to channels and notes/CCs that you know your controller can send

### The Param Class
* Many parameters in this framework employ the Param Class
* The param class is instantiated with a current value, minimum value, and maximum value
* The value, min, and max can be reset using Param.reset(value, min, max)
* The value can be directly set using Param.set(value)
* The value can be targeted using Param.target(value). Doing so will smoothly move the parameter to that value over some amount of that is a function of the tempo
* Param.get() will retrieve the param value
* If the param is moving, Param.update() will move it further. This is typically done once per draw
* If the param is moving, Param.updateGet() will update it and get it. This is typically done once per draw

### The Note Class
* The note
