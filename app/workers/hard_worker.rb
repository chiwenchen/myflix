class HardWorker
  include Sidekiq::Worker
  def perform(name)
    Ufe
  end
end