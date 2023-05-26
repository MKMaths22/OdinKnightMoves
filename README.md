# OdinKnightMoves
Follows the Knights assignment from TOP  

This project uses the MIT License.  

Project instructions:  

For this project, you’ll need to use a data structure that’s similar (but not identical) to a binary tree.  

A knight in chess can move to any square on the standard 8x8 chess board from any other square on the board, given enough turns.  

knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]

(1) Put together a script that creates a game board and a knight.  
(2) Treat all possible moves the knight could make as children in a tree. Don’t allow any moves to go off the board.  
(3) Decide which search algorithm, BFS or DFS, is best to use for this case. Hint: one of them could be a potentially infinite series.  
(4) Use the chosen search algorithm to find the shortest path between the starting square (or node) and the ending square. Output what that full path looks like, e.g.  
  
  > knight_moves([3,3],[4,3])  
  => You made it in 3 moves!  Here's your path:
    [3,3]
    [4,5]
    [2,4]
    [4,3]

