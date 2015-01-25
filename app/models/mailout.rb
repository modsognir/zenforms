class Mailout
  class LobError < StandardError; end

  attr_reader :service, :file, :address
  def initialize(file, address)
    @service = Lob.load
    @file = file
    @address = address
  end

  def object
    {
      name: 'name',
      file: file,
      setting_id: 100
    }
  end

  def to
    {
      name: address.name,
      address_line1: address.address_line_1,
      city: address.city,
      state: address.state,
      country: address.country,
      zip: address.zip
    }
  end

  def from
    {
      name: 'Zenforms'
      address_line1: address.address_line_1,
      city: address.city,
      state: address.state,
      country: address.country,
      zip: address.zip
    }
  end

  def send!
    begin
      service.jobs.create(
        name: "Zenforms Mailout",
        to: to,
        from: from,
        objects: object
      )
    rescue => e
      raise LobError, e
    end
  end
end