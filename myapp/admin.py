from django.contrib import admin
from .models import Post, Comment


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'created_date', 'published_date')
    list_filter = ('created_date', 'published_date', 'author')
    search_fields = ('title', 'content')
    date_hierarchy = 'created_date'
    ordering = ('-created_date',)
    
    def get_queryset(self, request):
        return super().get_queryset(request).select_related('author')


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('post', 'author', 'created_date', 'approved_comment')
    list_filter = ('created_date', 'approved_comment')
    search_fields = ('author', 'text')
    actions = ['approve_comments']
    
    def approve_comments(self, request, queryset):
        queryset.update(approved_comment=True)
    approve_comments.short_description = "Approve selected comments"
