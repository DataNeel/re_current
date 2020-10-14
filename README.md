# re_current

This is a very-incomplete version of the re_current library used to build midi loops and power processing sketches. You can find examples of its use at http://instagram.com/neel.shivdasani.


## Documentation v1

To get things started, here is some very brief documentation.

### some notes
* This library is built using the Processing language, which is similar to Java
* In processing, code can be split across multiple files in the program folder. This library takes advantage of that, and various functions and visualizations live in different folders
* Processing can access shader files, and they must be included in the data folder
* You will need to install the processing plugins The Midi Bus and Syphon (unless you remove syphon from your code)

### Using multiple visuals
* For each visual, you need to create a new pde file with a setup function and a draw function. sketch_noiseDemo.pde can be used as a template
* The draw function in re_current.pde checks the _visual_ variable to determine which sketch draw function it should call


### MIDI Input
* All midi inputs are processed in the file midi_input.pde
* Midi input is processed using the Processing plugin called The Midi Bus
* Midi signals are currently mapped to specific functions using if/else statements based on their channel, note, or CC. You'll need to map these to channels and notes/CCs that you know your controller can send

### The TapTempo class
* The TapTempo class keeps track of your time and tempo
* TapTempo.tap() will start to record taps to set a new tempo. Calling tap() again will add a second tap, setting a new tempo. If more than 2 seconds occur between taps, the first tap will be ignored
* TapTempo.T will access the custom time that this tempo tracks
* TapTempo.loopLocation stores the current place in a loop. Passing this value to new instances of Note() will record their location in the loop and enable them to trigger repeatedly
* TapTempo.update() will update all of the clocks. This is run once per draw


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
* The note class logs the time within a loop at which the note was pressed, a link to the previous note, and a velocity
* The velocity is a parameter, and it is used to make notes fade in when they are instantiated and fade out when Note.dim() is called

### The Loop class
* The loop class accesses a linked list of notes
* It is instantiated using Loop(noteCount), where noteCount is the maximum number of notes that are stored
* A note is added to the loop using Loop.add(time, velocity), where time is the time within a loop and the velocity is the target velocity that it will fade to
* Loop.clear() will dim all notes, moving their velocities towards 0
* Loop.times() will return an array of the times for each note
* Loop.velocities() will return an array of the velocities for each note
* Loop.event() is a boolean that will return true if a note occurred between the current and previous draw()

### The Palette class
 * The Palette class manages your color palettes and lets you swap between them
 * It is instantiated using Palette(colors, paletteID), where colors is a 2d array of processing colors and paletteID is the palette you want to start with
 * Each row of the colors array represents a single palette, and each palette should have 4 colors
 * Palette.setPalette(ID) instantly sets the colors to the palette found in row ID of the colors matrix
 * Palette.targetPalette(ID) gradually shifts from the current palette to the palette found in row ID of the colors matrix
 * Palette.shift() gradually rotates the order of the colors in the current Palette
