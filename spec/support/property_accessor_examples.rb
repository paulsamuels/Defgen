require 'support/spec_helper'

module Defgen
  shared_examples "property accessors" do
    it { should respond_to :name }
    it { should respond_to :objc_type }
    it { should respond_to :message_prefix }
    it { should respond_to :attributes }
    it { should respond_to :object_setter }
    it { should respond_to :parameter }
  end
end