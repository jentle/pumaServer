class Output < ActiveRecord::Base
  belongs_to :panel

  validates :watt, :presence => true

   after_save :notify_change

  def notify_change
    Output.connection.execute "NOTIFY outputs, '#{self.watt}'"
  end

  def self.on_change
    Output.connection.execute 'LISTEN outputs'
    loop do
      puts "inside loop"
      Output.connection.raw_connection.wait_for_notify do |event, pid, outputs|
        yield outputs
      end
    end

  ensure
    connection.execute 'UNLISTEN outputs'
  end


end
