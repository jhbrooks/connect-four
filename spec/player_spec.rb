require "spec_helper"

describe Player do
  let(:player) { Player.new(:a, "X") }

  describe "#new" do
    context "when given 2 arguments (name, mark)" do
      it "returns a Player object" do
        expect(player).to be_an_instance_of(Player)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Player.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Player.new("a", "b", "c") }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#name" do
    it "returns the correct name" do
      expect(player.name).to eq(:a)
    end
  end

  describe "#mark" do
    it "returns the correct mark" do
      expect(player.mark).to eq("X")
    end
  end

  describe "#to_s" do
    it "returns the Player's name as a string" do
      expect(player.to_s).to eq("a")
    end
  end
end
