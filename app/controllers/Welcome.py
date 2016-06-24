
from system.core.controller import *

class Welcome(Controller):
    def __init__(self, action):
        super(Welcome, self).__init__(action)
    
    def index(self):
        return self.load_view('index.html')
        
    def login_reg(self):
        if 'errors' in session:
            for error in session['errors']:
                flash(error)
            session.pop('errors')
        return redirect('/')

