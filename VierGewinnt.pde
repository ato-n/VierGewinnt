//init
int size,
    maxx = 7, maxy = 6,
    player = (int)round(random(1, 2)), winner, loser;
String text = "";
Cell[][] cells;

void setup() {
    fullScreen();
    if (width / maxx > height / (maxy + 1)) size = height / (maxy + 1);
    else size = width / maxx;
    cells = new Cell[maxx][maxy];
    for (int y = 0; y < maxy; y++)
        for (int x = 0; x < maxx; x++)
            cells[x][y] = new Cell(x, y, size);
}

void draw() {
    background(0);
    for (int y = 0; y < maxy; y++)
        for (int x = 0; x < maxx; x++)
            cells[x][y].create();
    if (player == 1) text = "'Gruen' ist an der Reihe!";
    else if (player == 2) text = "'Blau' ist an der Reihe!";
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text(text, width / 2, height / 2 + floor(maxy / 2) * size - maxy * size);
}

void touchStarted() {
    if (player == 0) {
        for (int y = 0; y < maxy; y++) {
            for (int x = 0; x < maxx; x++) {
                cells[x][y].content = 0;
                player = loser;
            }
        }
    } else
        for (int y = 0; y < maxy; y++)
            for (int x = 0; x < maxx; x++)
                cells[x][y].checkForClick(touches[0].x, touches[0].y);
}

void checkWin() {
    int win = 0, 
        emptyCells = 0;
    
    //check for empty cells
    for (int y = 0; y < maxy; y++)
        for (int x = 0; x < maxx; x++)
            if (cells[x][y].content == 0) emptyCells++;
    if (emptyCells == 0) win = -1;
    
    //check horizontal
    for (int y = 0; y < maxy; y++)
        for (int x = 0; x < maxx - 3; x++)
            if (cells[x][y].content == cells[x + 1][y].content
             && cells[x][y].content == cells[x + 2][y].content
             && cells[x][y].content == cells[x + 3][y].content
             && cells[x][y].content != 0)
                win = cells[x][y].content;
    //check vertical
    for (int y = 0; y < maxy - 3; y++)
        for (int x = 0; x < maxx; x++)
            if (cells[x][y].content == cells[x][y + 1].content
             && cells[x][y].content == cells[x][y + 2].content
             && cells[x][y].content == cells[x][y + 3].content
             && cells[x][y].content != 0)
                win = cells[x][y].content;
    //check diagonal (down-left to up-right)
    for (int y = 0; y < maxy - 3; y++)
        for (int x = 0; x < maxx - 3; x++)
            if (cells[x][y].content == cells[x + 1][y + 1].content
             && cells[x][y].content == cells[x + 2][y + 2].content
             && cells[x][y].content == cells[x + 3][y + 3].content
             && cells[x][y].content != 0)
                win = cells[x][y].content;
    //check diagonal (up-left to down-right)
    for (int y = 3; y < maxy; y++)
        for (int x = 0; x < maxx - 3; x++)
            if (cells[x][y].content == cells[x + 1][y - 1].content
             && cells[x][y].content == cells[x + 2][y - 2].content
             && cells[x][y].content == cells[x + 3][y - 3].content
             && cells[x][y].content != 0)
                win = cells[x][y].content;
    
    
    
    
    if (win != 0) {
        
        //lock open cells
        for (int y = 0; y < maxy; y++)
            for (int x = 0; x < maxx; x++)
                if (cells[x][y].content == 0) cells[x][y].content = 3;
        
        //send message
        player = 0;
        if (win == 1 || win == 2) {
            winner = win;
            if (winner == 1) text = "'Gruen' gewinnt!";
            else text = "'Blau' gewinnt!";
        } else if (win == -1) {
            winner = (int)round(random(1, 2));
            text = "Unentschieden!";
        }
        if (winner == 1) loser = 2;
        else loser = 1;
    } else changePlayer();
}

void changePlayer() {
    if (player == 1) player = 2;
    else if (player == 2) player = 1;
}
