module Services
  class DepositCalculation
    def self.perform(*args, &block)
      new(*args, &block).perform
    end

    def initialize(deposit)
      @deposit = deposit
    end

    def perform; end
  end
end
