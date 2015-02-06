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
      {
        id: @sku,
        total_available: @total_available,
        on_hand_count: @on_hand_ct,
        on_hand_reno:  @on_hand_reno,
        on_hand_other: @on_hand_other,
        committed: @committed
      }
    end
  end
end