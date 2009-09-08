class CellSpecCell < Cell::Base
  def modify_opts
    @opts[:test] << ', world'
    nil
  end
  
  def check_params
    @opts[:test] + params[:add]
  end
  
  def state_without_template
    return 'this state has not template'
  end
end