module Concerns
  module Deposit
    module Attributes
      ATTRS = %i[currency amount interest_rate start_date period period_type inflation_rate].freeze
      DECIMAL_ATTRS =  %i[amount interest_rate inflation_rate].freeze
      INTEGER_ATTRS =  %i[period].freeze

      attr_accessor(*ATTRS)

      def self.included(base)
        base.extend(ClassMethods)
      end
      module ClassMethods
        def attributes
          ATTRS
        end
      end

      def start_date=(value)
        instance_variable_set(:@start_date, Date.parse(value)) rescue instance_variable_set(:@start_date, (value))
      end

      def self.method_missing(message, *args, &block)
        if message.to_s == 'define_numerical_attributes'
          instance_name = "@#{args[0]}".to_sym
          method_name = "#{args[0]}=".to_sym
          define_method(method_name) do |value|
            value = value.send(args[1]) unless value.is_a?(String) && value.empty?
            send(:instance_variable_set, instance_name, value)
          rescue StandardError
            send(:instance_variable_set, instance_name, value)
          end
        else
          super
        end
      end

      def self.respond_to_missing?(method, *)
        method =~ /define_numerical_(\w+)/ || super
      end

      DECIMAL_ATTRS.each { |method_name| define_numerical_attributes(method_name, :to_d) }
      INTEGER_ATTRS.each { |method_name| define_numerical_attributes(method_name, :to_i) }
    end
  end
end
