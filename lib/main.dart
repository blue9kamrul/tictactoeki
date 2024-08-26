import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/tic_tac_toe_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tic Tac Toe',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  final TicTacToeController controller = Get.put(TicTacToeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Toe')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display winner or current player
          Obx(() {
            if (controller.winner.value == '') {
              return Text('Current Player: ${controller.currentPlayer.value}', style: TextStyle(fontSize: 24));
            } else {
              return Text(controller.winner.value == 'Tie'
                  ? 'It\'s a Tie!'
                  : 'Player ${controller.winner.value} Wins!', style: TextStyle(fontSize: 24));
            }
          }),
          // Tic Tac Toe Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.makeMove(index);
                  },
                  child: Obx(() {
                    return Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          controller.board[index],
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          // Reset Button
          ElevatedButton(
            onPressed: () {
              controller.resetGame();
            },
            child: Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
