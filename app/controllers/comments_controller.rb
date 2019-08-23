class CommentsController < ApplicationController

    def create
        ProblemSolution.all.each do |sol|
            if sol.is_featured == 1
                @ps_id = sol.id
                break
            end
        end
        @comment = Comment.new(comment_params.merge(:problem_solution_id => @ps_id, :user_id => current_user.id))
        puts @comment.inspect
        if @comment.save
            flash[:succ] = "Comment created"
        else
            flash[:notice] = "Error creating comment"
            @comment.errors.full_messages.each do |msg|
                puts msg
            end
        end
        redirect_to "/current_solution"
    end

    def comment_params
        params.permit(:body)
    end

end
