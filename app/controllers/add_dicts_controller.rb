class AddDictsController < ApplicationController

  def anagrams(word,list)
  signature = word.split("").sort.join
  list.select { |w| w.split("").sort.join == signature}
  end

  def index
    @page_request_last = PageRequest.last
    @add_dicts = AddDict.all   
    @add_dict = AddDict.new
    if @add_dicts.present?
      @recent_dict = AddDict.last!
      @list = File.read(Rails.root.join('public' + @recent_dict.file.to_s)).split("\n")
    end
    if params[:search].present?
      @anagram = anagrams(params[:search],@list).join(", ").to_s
      @ile = anagrams(params[:search],@list).count  
      if @ile < 1 
      @search = Search.create!(:query => "0 anagrams found for " + params[:search])
      else 
      @search = Search.create!(:query => @ile.to_s + " anagrams found for '" + params[:search] + "' > "  + @anagram, :timing => @page_request_last.page_duration )
      @timing
      end
      @recent_searches = Search.recent
    end
  end

  def create
    @page_request_last = PageRequest.last
    if params[:add_dict].present?
      @add_dict = AddDict.new(params[:add_dict])
      @add_dict.timing = @page_request_last.page_duration

      respond_to do |format|
        if @add_dict.save

          format.html { redirect_to(root_path, :notice => 'Dictionary was successfully uploaded.') }
          format.xml  { render :xml => @add_dict, :status => :created, :location => @add_dict }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @add_dict.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to(root_path, :notice => 'Select the dictionary file.') }
      end
    end


  end


end
