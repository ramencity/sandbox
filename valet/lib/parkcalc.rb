class ParkCalcPage
  attr :page

  def initialize(page_handle)
    @page = page_handle
    @page.goto 'http://www.shino.de/parkcalc'
  end

  def thirty_minutes
    @page.text_field(:id, 'StartingDate').set '4/1/2014'
    @page.text_field(:id, 'LeavingDate').set '4/1/2014'
    @page.text_field(:id, 'LeavingTime').set '12:30'
  end

  def select(parking_lot)
    @page.select_list(:id, 'ParkingLot').select parking_lot
  end

  def enter_parking_duration(duration)

  end

  def calculate_price
    @page.button(:value, 'Calculate').click
    @page.table[3][1].text.split[1].strip
  end

  @@durationMap = {
    '30 minutes'        => %w(05/04/2010 12:00 AM 05/04/2010 12:30 AM),
    '3 hours'           => %w(05/04/2010 12:00 AM 05/04/2010 03:00 AM),
    '5 hours'           => %w(05/04/2010 12:00 AM 05/04/2010 05:00 AM),
    '5 hours 1 minute'  => %w(05/04/2010 12:00 AM 05/04/2010 05:01 AM),
    '12 hours'          => %w(05/04/2010 12:00 AM 05/04/2010 12:00 PM),
    '24 hours'          => %w(05/04/2010 12:00 AM 05/05/2010 12:00 AM),
    '1 day 1 minute'    => %w(05/04/2010 12:00 AM 05/05/2010 12:01 AM),
    '3 days'            => %w(05/04/2010 12:00 AM 05/07/2010 12:00 AM),
    '1 week'            => %w(05/04/2010 12:00 AM 05/11/2010 12:00 AM)
     }
end
