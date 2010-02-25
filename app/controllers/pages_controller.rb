class PagesController < ApplicationController
  before_filter :set_page, :only => [:new, :show, :edit, :update, :destroy, :delete_attachment]
  before_filter :new_if_no_title, :only => [:show, :edit]
  
  def index
    params[:title] = "Welcome"
    find
  end

  def new
    if params[:title] then
      @page.title = params[:title]
    end
  end
  
  def show
    @action = @page.title if @page.title
  end

  def edit
    @action += " #{@page.title}"
  end

  def update
    @page.update_attributes(params[:page])

    if @page.save then
      redirect_to page_url(@page)
    else
      render :action => :edit
    end
  end

  def create
    @page = Page.new(params[:page])
    if @page.save then
      redirect_to page_url(@page)
    else
      render :action => :new
    end
  end

  def destroy
    @page.attachments_attributes = @page.attachments.map {|a| {:id => a.id, :_delete => '1'}}
    @page.save
    @page.destroy
    redirect_to pages_url
  end

  def find
    @pages = Page.find_by_title_insensitive(params[:title])
    if @pages.count == 0 then
      redirect_to :action => :new, :title => params[:title]
    else
      redirect_to page_url(@pages[0])
    end
  end

  def search
    if params[:search_type] then
      if params[:search_type].downcase == 'text' then
        @pages = text_search(params[:query], params[:page])
      elsif session[:search_type].downcase == 'tag' 
        @pages = tag_search(params[:query], params[:page])
      else
        render :text => "shit fucked up!"
      end
    end
    if @pages then
      @start_record = (@pages.per_page * @pages.current_page) - (@pages.per_page - 1)
      @end_record = @start_record + (@pages.per_page - 1)
      @end_record = @pages.total_entries if @end_record > @pages.total_entries
    end
  end

  def browse
    @pages = []
    if params[:letter] then
      @letter = params[:letter]
      @pages = Page.begins_with(@letter)
    else
      @letter = "All Pages"
      @pages = Page.all_sorted_by_title
    end
  end 
  
  def tag_cloud
    @tags = Page.tag_counts
  end

  def search_tagged
    @tags = params[:tags] 
    @pages = tag_search(@tags, params[:page])
  end

  def delete_attachment
    @attachment_id = params[:attachment_id];

    if @page.title != nil then
      @page.attachments_attributes = [{:id => params[:attachment_id], :_delete => 1}]
      @page.save
    end
  end

private 
  def set_page
    begin
      if params[:id] then
        @page = Page.find(params[:id])
      else
        @page = Page.new
      end
    rescue ActiveRecord::RecordNotFound
      @page = Page.new
    end
  end

  def text_search(query, page)
    page = page || 1
    
    Page.find_with_ferret query, :page => page, :per_page => 20
  end

  def tag_search(tags, page)
    page = page || 1
    Page.paged_find_tagged_with tags, :page => page
  end

  def new_if_no_title
    redirect_to :action => :new if ! @page.title
  end
end
