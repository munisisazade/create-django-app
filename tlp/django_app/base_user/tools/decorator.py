from django.shortcuts import redirect
from django.urls import reverse
from django.views.generic import View


class LoginRequiredMixinView(View):
    """
        This method for base Login required
        for view append your new class
    """
    def dispatch(self, *args, **kwargs):
        if self.request.user.is_authenticated:
            return redirect(reverse('base:index'))
        else:
            return super(LoginRequiredMixinView, self).dispatch(*args, **kwargs)
