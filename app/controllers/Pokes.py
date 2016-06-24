
from system.core.controller import *

class Pokes(Controller):
    def __init__(self, action):
        super(Pokes, self).__init__(action)

        self.load_model('Poke')
        self.db = self._app.db

    def create(self):
        if not 'count' in session:
            session['count'] = 0
        session['count'] += 1
        self.models['Poke'].create_poke(request.form, session['user']['id'])
        return self.load_view('pokes.html', count=session['count'])


    # def count(self, id):
    #     if not 'count' in session:
    #         session['count'] = 0
    #     poke = self.models['Poke'].get_poke_by_user_id(session['user']['id'])
