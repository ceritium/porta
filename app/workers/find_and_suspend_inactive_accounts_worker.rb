# frozen_string_literal: true

class FindAndSuspendInactiveAccountsWorker
  include Sidekiq::Worker

  def perform
    Account.providers.inactive_since_time_ago.find_each(&:suspend!)
  end
end
