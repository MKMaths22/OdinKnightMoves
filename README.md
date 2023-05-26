# OdinKnightMoves
Follows the Knights assignment from TOP  

This project uses the MIT License.  

--------------------------------------------

Project instructions: 
-------------------------------------------- 

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

-------------------------------------------

Author comments by Peter Hawes:
------------------------------------------

I decided in the end to combine following the instructions with an extra feature. The user is informed that other shortest possible routes have been found and is shown these routes upon entering any input. That way, the extra routes can be shown without breaking the spirit of the project instructions, or having extra arguments to input. A redundant #find_one_route method is included in redundant.rb, to show how we can just calculate one optimal knight route.

I find it fascinating how many optimal routes there can be. For example, when the knight can move in a consistent direction, e.g. from [0, 0] to [3, 6] in 3 steps that look like [1, 2] vectors, there is only one optimal route. However, from [3, 3] to [5, 5] takes 4 steps and there are 54 optimal routes!  

It was tempting to use a global variable for all_routes, until I thought of making it an instance variable of the Knight class. I needed all of the branching recursive calls of #complete_route to be able to push their routes onto the same all_routes variable, but kept running into scope issues.  

