class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion:{in: ["Approved","Pending","Denied"]}
  validate :overlapping_approved_requests
  validate :valid_dates
  belongs_to :cat

  def approve!
    unless self.status == "Denied"
      self.transaction do
        self.status = "Approved"
        self.save
        self.overlapping_requests.map do |request|
          request.status = "Denied"
          request.save
        end
      end
      return true
    else
      return false
    end
  end

  def deny!
    self.transaction do
      self.status = "Denied"
      self.save
    end
  end

  def overlapping_requests
    output = []
    pending_cat = Cat.find(self.cat_id)
    all_requests = pending_cat.requests
    all_requests.each do |request|
      beginning_date = request.start_date
      finishing_date = request.end_date
      truth_array = []
      truth_array << self.start_date.between?(beginning_date,finishing_date)
      truth_array << self.end_date.between?(beginning_date,finishing_date)
      truth_array << beginning_date.between?(self.start_date,self.end_date)
      truth_array << finishing_date.between?(self.start_date,self.end_date)
      if truth_array.any?{|x| x}
        output << request unless request == self
      end
    end
    output
  end

  def overlapping_approved_requests
    if overlapping_requests.any? { |request| request.status == "Approved" } &&
      self.status == "Approved"
      self.errors[:overlapping_request] << "Overlaps with existing request"
    end
  end

  def valid_dates
    if self.start_date > self.end_date
      self.errors[:date_error] << "Start date must be before end date"
    end
  end


end
