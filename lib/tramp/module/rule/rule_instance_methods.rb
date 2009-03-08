require File.expand_path(File.dirname(__FILE__) + '/rule_utilities.rb')

module Tramp
  module Rule
    module InstanceMethods
      
      include Tramp::Rule::Utilities
    
      attr_accessor :event
    
      def initialize(options=nil)
        @event = options.delete(:event) if options.is_a? Hash
      end
      
      def container
        if respond_to? :class_container
          class_container
        else
          Tramp::RuleContainer.new
        end
      end
      
      def helpers
        if respond_to? :class_helpers
          class_helpers
        else
          nil
        end
      end

      def eval
        hash = {}
        @event.extend(helpers) if helpers
        container.keys.map do |key|
          hash[key] = send('eval_' + key.to_s)
        end
        hash
      end

      def eval_secondary_events
        container.secondary_events.map do |event_name|
          unless event_name == nil
            event_class = Kernel.const_get(event_name) 
            event = event_class.new
            event.amount = self.event.amount
            event
          end
        end
      end
      
      def eval_entries
        container.entries.map do |entry|
          if entry.is_a? Hash
            entry.inject({}) do |hash,(key,value)|
              if value.is_a? String or value.is_a? Symbol
                if @event.respond_to? value
                  hash[key] = @event.send(value)
                else
                   hash[key] = value.to_s
                end
              else 
                hash[key] = value
              end
              hash
            end
          end
        end   
      end
  
      def eval_collections
        container.collections.map do |collection|
          if event.respond_to?(collection)
            event.send(collection)
          end
        end
      end
  
      #protected :eval_own_entries, :eval_own_collections
    end
  end
end