require 'methods'

describe "Methods: " do
    describe "#my_uniq" do
        let(:array) { [1, 2, 1] }
        context "should pass the specs" do
            it "should not raise an error" do
                expect { my_uniq(array) }.to_not raise_error
            end
            it "should return a unique array" do
                expect(my_uniq(array)).to eq([1, 2])
            end
            it "should not use .uniq" do
                expect(my_uniq(array)).not_to receive(:uniq)
            end
        end
    end

    describe "#two_sum" do
        let(:array) { [1, 2, 1, -2, 3, -3] }
        context "should pass the specs" do
            it "should not raise an error" do
                expect { two_sum(array) }.to_not raise_error
            end
            it "should return pairs that sum to 0" do
                expect(two_sum(array)).to eq([[1, 3], [4, 5]])
            end
        end
    end

    describe "#my_transpose" do
        let(:array) { rows = [ [0, 1, 2], [3, 4, 5], [6, 7, 8] ]}
        let(:ans) { [[0, 3, 6], [1, 4, 7], [2, 5, 8]] }
        context "should pass the specs" do
            it "should not raise an error" do
                expect { my_transpose(array) }.to_not raise_error
            end
            it "should return a transposed array" do
                expect(my_transpose(array)).to eq(ans)
            end
            it "should not use .transpose" do
                expect(my_transpose(array)).not_to receive(:transpose)
            end
        end
    end

    describe "#stock_picker" do
        let(:array) {[1, -2, -2, 4]}
        let(:ans) {[1,3]}
        context "should pass the specs" do
            it "should not raise an error" do
                expect { stock_picker(array) }.to_not raise_error
            end
            it "should return greatest investment pair" do
                expect( stock_picker(array)).to eq(ans)
            end
        end
    end
end
