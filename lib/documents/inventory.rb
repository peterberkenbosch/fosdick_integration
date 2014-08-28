module Documents
  class Inventory

    def initialize(contents)
      attrs            = contents.split(' ')
      @sku             = attrs[0]
      @total_available = attrs[1]
      @on_hand_ct      = attrs[2]
      @on_hand_reno    = attrs[3]
      @on_hand_other   = attrs[4]
      @committed       = attrs[5]
    end

    def to_message
      level = @total_available.to_i < 200 ? 'warn' : 'info'

      {
        level: level,
        subject: "Inventory For Item #{@sku}",
        description: "SKU: #{@sku}, Total Available: #{@total_available}, On Hand Count: #{@on_hand_ct}, " <<
                     "On Hand Reno: #{@on_hand_reno}, On Hand Reno: #{@on_hand_reno}, Committed: #{@committed}"
      }
    end
  end
end