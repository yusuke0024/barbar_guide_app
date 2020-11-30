module SalonShowSupport
  def valid_show(salon)
    visit salons_path
    click_on salon.name
  end
end
