
from system.core.controller import *

class Users(Controller):
    def __init__(self, action):
        super(Users, self).__init__(action)
        self.load_model('User')
        self.load_model('Poke')
        self.db = self._app.db
    
    def register(self):
        is_valid = self.models['User'].validation(request.form)
        return self.handle_login_reg(is_valid)

    def handle_login_reg(self, result):
        if type(result) == list:
            session['errors'] = result
            return redirect('/')
        self.current_user(result)
        return redirect('/dashboard')

    def current_user(self, is_valid):
        session['user'] = is_valid
        return
    
    def login(self):
        login_request = self.models['User'].login(request.form)
        return self.handle_login_reg(login_request)
    
    def logout(self):
        session.clear()
        return redirect('/')

    def dashboard(self):
        users = self.models['User'].get_all_other_users(session['user']['id'])
        return self.load_view('pokes.html', users=users)
