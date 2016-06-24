
from system.core.model import Model

class Poke(Model):
    def __init__(self):
        super(Poke, self).__init__()
        self.queries = {
            'create_poke': "INSERT INTO pokes (user_id, poke_id, date_created, date_updated) values (:user_id, :poke_id, NOW(), NOW())",
            'poke_history_query': "SELECT COUNT(*) AS poke_history FROM pokes WHERE user_id=:id"
        }
    def create_poke(self, form_data, user_id):
        query = self.queries['create_poke']

        print user_id, form_data['poke_id']

        data = {
            'user_id': form_data['user_id'],
            'poker_id': poke_id,
            'poke_id': form_data['poke_id']
        }
        result = self.db.query_db(query, data)
        return result
    def get_pokes_by_user_id(self, user_id):
        poke_history = self.db.query_db['poke_history_query']
        return poke_history[0]