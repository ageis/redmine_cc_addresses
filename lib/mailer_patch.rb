module MailerPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
	unloadable
        alias_method_chain :issue_edit, :cc_addresses
    end
  end

  module InstanceMethods
    def issue_edit_with_cc_addresses(journal, to_users, cc_users)
      issue = journal.journalized.reload
      cc_addresses = issue.cc_addresses.collect {|m| m.mail}
      cc_users << cc_addresses
      issue_edit_without_cc_addresses(journal, to_users, cc_users)
    end
  end

end