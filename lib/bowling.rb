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
            if score.inject(:+) == 10 && index < 10
                @total_score += 10 + @scores[index].first
            else
                @total_score += score.inject(:+)
            end
        end
    end
    
end