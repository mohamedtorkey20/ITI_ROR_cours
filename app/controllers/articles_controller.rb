class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]
 

  def index
      @articles = Article.where(status: 'public')
    
  end
  
  
  def show
      @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.reports_count ||= 0
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end
  

  def edit
    redirect_to articles_path, alert: "Access Denied" unless @article.user_id == current_user.id
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def report
    @article = Article.find(params[:id])
    @article.increment!(:reports_count)

    if @article.reports_count >= 3
      @article.update(status: "archived")
    end
    redirect_to root_path, notice: "Article reported successfully."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :status,:avatar)
  end
end
