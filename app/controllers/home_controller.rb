class HomeController < ApplicationController
  respond_to :json, only: [:ajax_action]

  # http://10.11.11.254/satesto/ws/WebSiteExchange.1cws?wsdl

  def index
  end

  def ajax_action
    client = Savon.client(
      wsdl: "http://10.11.11.254/satesto/ws/WebSiteExchange.1cws?wsdl",
      basic_auth: ["SiteExchange", "S1teExch@nge"],
      log: true,
      log_level: :debug,
      pretty_print_xml: true
    )

    logger.debug "*****************"
    pp client.operations
    logger.debug "*****************"

    page = "asd"
    @user = page
  end
end
