class ClaimRequests::CreateClaim
  include Virtus.model

  # input
  attribute :user, User
  attribute :organization, Organization

  # output
  attribute :claim_request, ClaimRequest

  def call
    @claim_request = ClaimRequest.new
    @claim_request.user = user
    @claim_request.organization = organization
    @claim_request.save
  end

end
