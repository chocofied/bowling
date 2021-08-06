require "bowling"

describe "Bowling score total" do
    describe "Overall total" do
        #combine creation of instances
        before do
            @game = Bowling.new
        end
        context "All tosses were gutter balls" do
            it "Score is 0" do
                add_many_scores(20,0)
                @game.calc_score
                expect(@game.total_score).to eq 0
            end
        end
        
        context "All tosses knocked over 1 pin" do
            it "Score is 20" do
                add_many_scores(20,1)
                @game.calc_score
                expect(@game.total_score).to eq 20
            end
        end
        context "Got a spare" do
            it "Spare bonus is added" do
                #First frame is 3, then 7 points - a spare
                @game.add_score(3)
                @game.add_score(7)
                #Second frame's first throw is 4 points
                @game.add_score(4)
                #The rest are gutter balls
                add_many_scores(17,0)
                #Calculate total
                @game.calc_score
                #Expected total *(4) is the bonus points
                # 3 + 7 + 4 + (4) = 18
                expect(@game.total_score).to eq 18
            end
        end
        context "Frame is different, but two adjacent throws would make a spare" do
            it "Spare bonus is not added" do
                #First frame is 3, then 5 points
                @game.add_score(3)
                @game.add_score(5)
                #Second frame is 5, then 4 points
                @game.add_score(5)
                @game.add_score(4)
                #The rest are gutter balls
                add_many_scores(16,0)
                #Calculate total
                @game.calc_score
                #Expected total
                # 3 + 5 + 5 + 4 = 17
                expect(@game.total_score).to eq 17
            end
        end
        context "Getting a spare in the last frame" do
            it "Spare bonus is not added" do
                #First frame is 3, then 7 points - a spare
                @game.add_score(3)
                @game.add_score(7)
                #Second frame first throw is 4 points
                @game.add_score(4)
                #15 gutter balls
                add_many_scores(15,0)
                #Last frame is 3, then 7 points - a spare
                @game.add_score(3)
                @game.add_score(7)
                #Calculate total
                @game.calc_score
                #Expected total
                # 3 + 7 + 4 + (4) + 3 + 7 = 28
                expect(@game.total_score).to eq 28
            end
        end
        context "Add strike bonus" do
            it "Strike bonus is added" do
                #First frame is a strike
                @game.add_score(10)
                #Second frame is 5, then 4 points
                @game.add_score(5)
                @game.add_score(4)
                #16 gutter balls
                add_many_scores(16,0)
                #Calculate total
                @game.calc_score
                #Expected total
                # 10 + 5 + (5) + 4 + (4) = 28
                expect(@game.total_score).to eq 28
            end
        end
        context "Got a double" do
            it "Strike bonuses are added" do
                #First frame is a strike
                @game.add_score(10)
                #Second frame is a strike
                @game.add_score(10)
                #Third frame is 5, then 4 points
                @game.add_score(5)
                @game.add_score(4)
                #14 gutter balls
                add_many_scores(14,0)
                #Calculate total
                @game.calc_score
                #Expected total
                # 10 + 10 + (10) + 5 + (5 + 5) + 4 + (4) = 53
                expect(@game.total_score).to eq 53
            end
        end
        context "Got a turkey" do
            it "Strike bonuses are added" do
                #First frame is a strike
                @game.add_score(10)
                #Second frame is a strike
                @game.add_score(10)
                #Third frame is a strike
                @game.add_score(10)
                #Fourth frame is 5, then 4 points
                @game.add_score(5)
                @game.add_score(4)
                #12 gutter balls
                add_many_scores(14,0)
                #Calculate total
                @game.calc_score
                #Expected total
                # 10 + 10 + (10) + 10 + (10 + 10) + 5 + (5 + 5) + 4 + (4) = 83
                expect(@game.total_score).to eq 83
            end
        end
        context "Last frame is a strike" do
            it "Strike bonus is not added" do
                #First frame is a strike
                @game.add_score(10)
                #Second frame is 5, then 4 points
                @game.add_score(5)
                @game.add_score(4)
                #Frames 3~9 are gutter balls
                add_many_scores(14,0)
                #Last frame is a strike
                @game.add_score(10)
                #Calculate total
                @game.calc_score
                #Expected total
                # 10 + 5 + (5) + 4 + (4) + 10 = 38
                expect(@game.total_score).to eq 38
            end
        end
    end
    
    describe "Total for each frame" do
        context "All throws knock down 1 pin each" do
            it "First frame score is 2" do
                add_many_scores(20,1)
                #calculate total
                @game.calc_score
                expect(@game.frame_score(1)).to eq 2
            end
        end
        context "Got a spare" do
            it "Spare bonus is added" do
                #first frame is 3, then 7 points
                @game.add_score(3)
                @game.add_score(7)
                #Next frame's first toss is 4 points
                @game.add_score(4)
                #17 gutter balls
                add_many_scores(17,0)
                #calculate total
                @game.calc_score
                #Expected score
                #3 + 7 + (4) = 14
                expect(@game.frame_score(1)).to eq 14
            end
        end
        context "Got a strike" do
            it "Strike bonus is added" do
                #first frame is a strike
                @game.add_score(10)
                #Next frame's first toss is 5, then 4 points
                @game.add_score(5)
                @game.add_score(4)
                #16 gutter balls
                add_many_scores(16,0)
                #calculate total
                @game.calc_score
                #Expected score
                #10 + (5) + (4) = 19
                expect(@game.frame_score(1)).to eq 19
            end
        end
    end
end
private
#Run multiple times at once with same score
def add_many_scores(count, pins)
    count.times do
        @game.add_score(pins)
    end
end