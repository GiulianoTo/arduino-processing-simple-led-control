import processing.serial.*;

Serial port;
boolean ledOn = false;
int counter = 0;
PFont font;
PImage img;

void setup()
{
    size(1200, 600);
    printArray(Serial.list());
    port = new Serial(this, Serial.list()[0], 115200);
    font = createFont("Arial", 100);
    img = loadImage("logo.png");
}

void draw()
{
    // Set background color
    background(190);

    // Displays the image at its actual size at point (0,0)
    image(img, 0, 0);

    // Check mouse press state
    if (mousePressed && !ledOn) {
        port.write("on\n");
        ledOn = true;
        counter++;
    } else if (!mousePressed && ledOn) {
        port.write("off\n");
        ledOn = false;
    }

    // Set fill color and transparency
    if (ledOn) {
        fill(230, 0, 0, 200);
    } else {
        fill(255, 0, 0, 80);
    }

    // Draw led image
    stroke(50); //<>//
    arc(150, 80 + (height / 2), 70, 70, -PI, 0);
    noStroke();
    rect(115, 80 + (height / 2), 70, 50);
    stroke(50);
    line(115, 80 + (height / 2), 115, 130 + (height / 2));
    line(185, 80 + (height / 2), 185, 130 + (height / 2));
    rect(100, 130 + (height / 2), 100, 20);
    fill(127);
    rect(130, 150 + (height / 2), 10, 100);
    rect(160, 150 + (height / 2), 10, 80);

    // Check incoming serial string to reset counter
    if (port.available() > 0) {
        String command = port.readStringUntil('\n');
        if (command != null && trim(command).equals("on")) {
            counter = 0;
        }
    }

    // Print counter value
    fill(0);
    textFont(font);
    textAlign(CENTER);
    text(counter, 350, 180 + (height / 2));
}
