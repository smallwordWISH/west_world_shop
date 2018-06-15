class SpgatewayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def return
    payment = Payment.find_and_process(spgateway_params)

    if payment&.save
      flash[:notice] = "#{payment.order.sn} paid"
    else
      flash[:alert] = "Somethint went wrong. Please try again later."
    end

    redirect_to orders_path
  end

  def notice
    payment = Payment.find_and_process(spgateway_params)
    
    if payment&.save
      render text: "1|OK"
    else
      render text: "0|ErrorMessage"
    end
  end

  def spgateway_params
    params.slice("Status", "MerchantID", "Version", "TradeInfo", "TradeSha")
  end
end