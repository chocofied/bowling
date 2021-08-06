#Class to manage bowling scores
class Bowling
    def initialize
        #Set total score to 0 at first
        @total_score = 0
        #Keep track of scores
        @scores = []
        #temp storage array
        @temp = []
    end
    
    #return total score
    def total_score
        @total_score
    end
    
    #add score
    def add_score(pins)
        @temp << pins
        #add total frame score when second toss is done
        if @temp.size == 2
            @scores << @temp
            @temp = []
        end
    end
    
    #calculate score
    def calc_score
        @scores.each.with_index(1) do |score, index|
            #If a spare that's not the last spare, then add bonus
            if spare?(score) && not_last_frame?(index)
                @total_score += calc_spare_bonus(index)
            else
                @total_score += score.inject(:+)
            end
        end
    end
    
    private
    #Check if spare
    def spare?(score)
        score.inject(:+) == 10
    end
    
    #Check if not last frame
    def not_last_frame?(index)
        index < 10
    end
    
    #Calculate spare bonus
    def calc_spare_bonus(index)
        10 + @scores[index].first
    end
end