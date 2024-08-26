import 'package:get/get.dart';

class TicTacToeController extends GetxController {
  // Define the board as a list of 9 elements
  var board = List.generate(9, (_) => '').obs;
  var currentPlayer = 'X'.obs; // Player X starts
  var winner = ''.obs; // Store the winner

  // Reset the game
  void resetGame() {
    board.fillRange(0, 9, '');
    currentPlayer.value = 'X';
    winner.value = '';
  }

  // Make a move
  void makeMove(int index) {
    if (board[index] == '' && winner.value == '') {
      board[index] = currentPlayer.value;
      checkWinner();
      currentPlayer.value = (currentPlayer.value == 'X') ? 'O' : 'X';
    }
  }

  // Check for a winner
  void checkWinner() {
    final winningPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (var pattern in winningPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        winner.value = board[pattern[0]];
        return;
      }
    }

    // Check for a tie
    if (!board.contains('') && winner.value == '') {
      winner.value = 'Tie';
    }
  }
}
