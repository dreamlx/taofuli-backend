class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_user!, only: [:wx_get_jsapi_ticket]
  def update_profile
    @user = current_user
    if @user.update(user_params)
      @user.active if @user.name && @user.gender && @user.cell && @user.email
      render 'get_info'
    else
      return api_error(status: 422)
    end
  end

  def get_info
    @user = current_user
  end

  def wx_get_jsapi_ticket
    jsapi_ticket = ""
    if Ticket.first && !Ticket.first.ticket.nil? && Ticket.first.expires_at > Time.current
      jsapi_ticket = Ticket.first.ticket
    else
      uri = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}")
      res = Net::HTTP.get_response(uri)
      json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))
      access_token = json["access_token"]

      ticket_uri = URI("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{access_token}&type=jsapi")
      ticket_res = Net::HTTP.get_response(ticket_uri)
      ticket_json = JSON.parse(ticket_res.body.gsub(/[\u0000-\u001f]+/, ''))
      jsapi_ticket = ticket_json["ticket"]
      Ticket.delete_all
      Ticket.create(
        ticket: jsapi_ticket,
        token: access_token,
        expires_at: Time.current + 1.hours
        )
    end

    if jsapi_ticket == ""
      render json: {message: "error"}
    else
      timestamp = Time.now.to_i
      wxnonceStr = "taofuli"
      wxOri = Digest::SHA1.hexdigest("jsapi_ticket=#{jsapi_ticket}&noncestr=#{wxnonceStr}&timestamp=#{timestamp}&url=#{params[:url]}")
      render json: {timestamp: timestamp, noncestr: wxnonceStr, signature: wxOri, appid: ENV["WECHAT_APP_ID"], access_token: Ticket.first.token}
    end
  end

  private
    def user_params
      params.permit(:name, :gender, :cell, :email)
    end
end