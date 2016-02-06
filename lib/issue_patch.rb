module IssuePatch
  def self.included(base)
    base.class_eval do
      safe_attributes 'cc_addresses_attributes'
      unloadable
      belongs_to :deliverable
      has_many :cc_addresses, :class_name => 'CcAddress', :foreign_key => 'issue_id', :dependent => :delete_all
      accepts_nested_attributes_for :cc_addresses, :reject_if => lambda { |cc_address| cc_address[:mail].blank? }, :allow_destroy => true
    end
  end
end
