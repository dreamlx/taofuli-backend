module ApplicationHelper
  # https://gist.github.com/ifightcrime/9291167a0a4367bb55a2
  def parse_image_data(base64_image)
    filename = DateTime.now.to_s(:number)
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]
  
    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind
  
    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]
  
    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension
  
    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    })
  end
  
  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end

  def admin_log_in(admin)
    session[:admin_id] = admin.id
    @current_admin = admin
  end

  def current_admin
    @current_admin || Admin.find_by(id: session[:admin_id])
  end

  def admin_logged_in?
    !current_admin.nil?
  end

  def admin_logout
    session.delete(:admin_id)
    @current_admin = nil
  end
end
