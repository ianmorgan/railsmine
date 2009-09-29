class MethodOrClassesController < ApplicationController
  # GET /method_or_classes
  # GET /method_or_classes.xml
  def index
    @method_or_classes = MethodOrClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @method_or_classes }
    end
  end

  # GET /method_or_classes/1
  # GET /method_or_classes/1.xml
  def show
    @method_or_class = MethodOrClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @method_or_class }
    end
  end

  # GET /method_or_classes/new
  # GET /method_or_classes/new.xml
  def new
    @method_or_class = MethodOrClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @method_or_class }
    end
  end

  # GET /method_or_classes/1/edit
  def edit
    @method_or_class = MethodOrClass.find(params[:id])
  end

  # POST /method_or_classes
  # POST /method_or_classes.xml
  def create
    @method_or_class = MethodOrClass.new(params[:method_or_class])

    respond_to do |format|
      if @method_or_class.save
        flash[:notice] = 'MethodOrClass was successfully created.'
        format.html { redirect_to(@method_or_class) }
        format.xml  { render :xml => @method_or_class, :status => :created, :location => @method_or_class }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @method_or_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /method_or_classes/1
  # PUT /method_or_classes/1.xml
  def update
    @method_or_class = MethodOrClass.find(params[:id])

    respond_to do |format|
      if @method_or_class.update_attributes(params[:method_or_class])
        flash[:notice] = 'MethodOrClass was successfully updated.'
        format.html { redirect_to(@method_or_class) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @method_or_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /method_or_classes/1
  # DELETE /method_or_classes/1.xml
  def destroy
    @method_or_class = MethodOrClass.find(params[:id])
    @method_or_class.destroy

    respond_to do |format|
      format.html { redirect_to(method_or_classes_url) }
      format.xml  { head :ok }
    end
  end
end
