from sys import stdin

CHAR_WIDTH =12
CHAR_HEIGHT=24
CHAR_Y0    =19
RECT_HEIGHT=24

everything = stdin.read().split("\n")

P = int(everything[0])

Board = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
]
for i in range(1,(len(everything)-1)):
    elements = everything[i].split(" ")
    I = int(elements[0])
    J = int(elements[1])
    N = int(elements[2])
    Board[I][J] = N

print(
"<?xml version='1.0' standalone='yes'?>\n"\
"<!DOCTYPE svg>\n"\
"<svg version='1.0' xmlns='http://www.w3.org/2000/svg' width='624px' height='571px' style='background-color:white'>\n"\
"  <style>\n"\
"    * {font: 20px monospace;}\n"\
"    text {white-space: pre;}\n"\
"    tspan.red {fill: white;}\n"\
"    rect.red {fill: red;}\n"\
"    tspan.yellow {fill: black;}\n"\
"    rect.yellow {fill: yellow;}\n"\
"  </style>\n", end="")

if P == 1:
    print("  <rect width='{}' height='{}' x='0' y='0' class='red'/>".format(13*CHAR_WIDTH, RECT_HEIGHT))
    print("  <text x='0' y= '{}'><tspan class='red'>Player 1 turn</tspan> (red/positive)</text>".format(CHAR_Y0))
else:
    print("  <rect width='{}' height='{}' x='0' y='0' class='yellow'/>".format(13*CHAR_WIDTH, RECT_HEIGHT))
    print("  <text x='0' y= '{}'><tspan class='yellow'>Player 2 turn</tspan> (yellow/negative)</text>".format(CHAR_Y0))
print("  <text x='0' y= '{}'>                 j=0 j=1 j=2 j=3 j=4 j=5 j=6 j=7 j=8</text>".format(CHAR_Y0+1*CHAR_HEIGHT))
print("  <text x='0' y= '{}'>                  ╱   ╱   ╱   ╱   ╱   ╱   ╱   ╱   ╱ </text>".format(CHAR_Y0+2*CHAR_HEIGHT))
print("  <text x='0' y= '{}'>    ╔══════════════════════════════════════════════╗</text>".format(CHAR_Y0+3*CHAR_HEIGHT))

text_string = ""
for i in range(0, 5):
    num_spaces = 2*abs(4-i)+1
    num_triangles=i+5
    text_string += "  <text x='0' y='{}'>".format(CHAR_Y0+(2*i+4)*CHAR_HEIGHT) + "    ║" + \
                   " "*num_spaces + " ".join(["╱ ╲"]*num_triangles) + " "*(num_spaces+9) + "║</text>\n"

    text_string += "  <text x='0' y='{}'>".format(CHAR_Y0+(2*i+5)*CHAR_HEIGHT) + "i={} ║".format(i) + \
                   " "*(num_spaces-1) + "│"
    
    for j in range(max(0, i-4), min(5+i, 9)):
        N = Board[i][j]
        y = (2*i+5)*CHAR_HEIGHT
        x = (6+(4-i)*2 + j*4)*CHAR_WIDTH
        if   N == 0: text_string += "   │"
        elif N >  0:
            text_string += "<tspan class='red'> {} </tspan>│"  .format(N)
            print("  <rect width='{}' height='{}' x='{}' y='{}' class='red'/>"   .format(3*CHAR_WIDTH, CHAR_HEIGHT, x, y))
        else       :
            text_string += "<tspan class='yellow'>{} </tspan>│".format(N)
            print("  <rect width='{}' height='{}' x='{}' y='{}' class='yellow'/>".format(3*CHAR_WIDTH, CHAR_HEIGHT, x, y))

    text_string += " "*(num_spaces) + "        ║</text>\n"

for i in range(5, 9):
    num_spaces = 2*abs(4-i)+1
    num_triangles=14-i
    text_string += "  <text x='0' y='{}'>".format(CHAR_Y0+(2*i+4)*CHAR_HEIGHT) + "    ║" + \
                   " "*(num_spaces-2) + " ".join(["╲ ╱"]*num_triangles) + " "*(num_spaces+7) + "║</text>\n"

    text_string += "  <text x='0' y='{}'>".format(CHAR_Y0+(2*i+5)*CHAR_HEIGHT) + "i={} ║".format(i) + \
                   " "*(num_spaces-1) + "│"
    
    for j in range(max(0, i-4), min(5+i, 9)):
        N = Board[i][j]
        y = (2*i+5)*CHAR_HEIGHT
        x = (6+(4-i)*2 + j*4)*CHAR_WIDTH
        if   N == 0: text_string += "   │"
        elif N >  0:
            text_string += "<tspan class='red'> {} </tspan>│"  .format(N)
            print("  <rect width='{}' height='{}' x='{}' y='{}' class='red'/>\n"   .format(3*CHAR_WIDTH, CHAR_HEIGHT, x, y))
        else       :
            text_string += "<tspan class='yellow'>{} </tspan>│".format(N)
            print("  <rect width='{}' height='{}' x='{}' y='{}' class='yellow'/>\n".format(3*CHAR_WIDTH, CHAR_HEIGHT, x, y))

    text_string += " "*(num_spaces) + "        ║</text>\n"

text_string += "  <text x='0' y='{}'>    ║         ╲ ╱ ╲ ╱ ╲ ╱ ╲ ╱ ╲ ╱                  ║</text>\n".format(CHAR_Y0+22*CHAR_HEIGHT)

print(text_string, end="")

print("  <text x='0' y='{}'>    ╚══════════════════════════════════════════════╝</text>".format(CHAR_Y0+23*CHAR_HEIGHT))
print("</svg>\n", end="")
