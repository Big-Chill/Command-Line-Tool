$LOAD_PATH << "."
require"word_game"

game_obj = WordGame::Game.new
game_obj.start_game
