import 'dart:io';

void main() {
  print('Welcome to Tic-Tac-Toe!');

  while (true) {
    playGame();

    // Ask if players want to play again
    print('\nWould you like to play again? (y/n)');
    final input = stdin.readLineSync()?.toLowerCase();
    if (input != 'y') {
      print('Thanks for playing! Goodbye.');
      break;
    }
  }
}

void playGame() {
  // Initialize the board (positions 1-9)
  final List<String> board = List.generate(9, (index) => (index + 1).toString());
  String currentPlayer = 'X';
  bool gameWon = false;
  int moveCount = 0;

  // Optional: Let players choose their markers
  // This is the bonus feature
  final markers = chooseMarkers();
  final player1 = markers[0];
  final player2 = markers[1];

  print('\nPlayer 1: $player1, Player 2: $player2');
  print('Enter a number (1-9) to make your move.\n');

  while (true) {
    // Display the current board
    displayBoard(board);

    // Get player move
    final position = getPlayerMove(board, currentPlayer == 'X' ? player1 : player2);

    // Update the board
    board[position - 1] = currentPlayer;
    moveCount++;

    // Check for win or draw
    if (checkWin(board, currentPlayer)) {
      displayBoard(board);
      print('\nPlayer ${currentPlayer == 'X' ? '1' : '2'} ($currentPlayer) wins!');
      gameWon = true;
      break;
    } else if (moveCount == 9) {
      displayBoard(board);
      print('\nThe game is a draw!');
      break;
    }

    // Switch players
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }
}

List<String> chooseMarkers() {
  while (true) {
    print('\nPlayer 1, choose your marker (X or O):');
    final input = stdin.readLineSync()?.toUpperCase();

    if (input == 'X') {
      return ['X', 'O'];
    } else if (input == 'O') {
      return ['O', 'X'];
    } else {
      print('Invalid input. Please enter X or O.');
    }
  }
}

void displayBoard(List<String> board) {
  print('');
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('-----------');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('-----------');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
  print('');
}

int getPlayerMove(List<String> board, String playerMarker) {
  while (true) {
    print('Player ${playerMarker == 'X' ? '1' : '2'} ($playerMarker), enter your move (1-9):');
    final input = stdin.readLineSync();
    final position = int.tryParse(input ?? '');

    if (position == null || position < 1 || position > 9) {
      print('Invalid input. Please enter a number between 1 and 9.');
      continue;
    }

    if (board[position - 1] == 'X' || board[position - 1] == 'O') {
      print('That position is already taken. Please choose another.');
      continue;
    }

    return position;
  }
}

bool checkWin(List<String> board, String player) {
  // Check all possible winning combinations
  const winningCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
    [0, 4, 8], [2, 4, 6]             // diagonals
  ];

  for (var combination in winningCombinations) {
    if (board[combination[0]] == player &&
        board[combination[1]] == player &&
        board[combination[2]] == player) {
      return true;
    }
  }

  return false;
}