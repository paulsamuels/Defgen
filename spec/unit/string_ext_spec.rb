require 'support/spec_helper'
require 'defgen/string_ext'

module Defgen
  describe String do
    [
      [ 'HEY', 'HEY' ],
      [ 'Hey', 'Hey' ],
      [ 'hey', 'Hey' ],
      [ 'hEy', 'HEy' ]
    ].each do |input, expected|
      it "upcases the first letter of #{input}" do
        input.upcase_first.should eq(expected)
      end
    end
  end
end