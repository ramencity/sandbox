def scan_hash_for(input, search_term)
  result = ''
  input.each do |key, value|
    if value.is_a?(Hash)
      scan_hash_for(value, search_term)
    elsif value.is_a?(Array)
      value.map { |e| scan_hash_for(e, search_term) }
    elsif value.is_a?(String) && key == search_term
      result = value
    else
      result = nil
    end
  end
  result
end

def boring_hash
  {
      'a' => 1,
      'b' => {
          'x' => 100,
          'y' => 200
      },
      'c' => 3
  }
end

def rps_tournament_winner(tournament)
  if tournament[0][0].is_a? String
    rps_game_winner(tournament)
  else
    tournament.map { |t| rps_tournament_winner(t) }
  end
end

def save_pair(parent, myHash)
  myHash.each { |key, value|
    value.is_a?(Hash) ? save_pair(key, value) :
        puts("parent=#{parent.nil? ? 'none' : parent}, (#{key}, #{value})")
  }
end

def scan_hash_two(parent, input, search_term)
  input.each { |key, value|
    if value.is_a?(Hash)
      scan_hash_two(key, value, search_term)
    elsif key == search_term
      value
    else
      nil
    end
  }
end
