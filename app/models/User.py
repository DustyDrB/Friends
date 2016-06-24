
from system.core.model import Model
import re
import datetime

EMAIL_REGEX = re.compile(r'^[a-za-z0-9\.\+_-]+@[a-za-z0-9\._-]+\.[a-za-z]*$')

class User(Model):
    def __init__(self):
        super(User, self).__init__()
        self.validation_errors= {
            'empty_name': "Name field cannot be empty",
            'empty_email': "Email field cannot be empty",
            'redundant_email': "The given email is already registered",
            'email_invalid': "Email is invalid",
            'password_length': "Password must contain at least eight characters",
            'password_match': "Your passwords do not match",
            'invalid_login': "Either your email or password are not found",
            'empty_birth': "Please provide a date of birth",

        }
        self.queries = {
            'create_user': "INSERT INTO users (name, alias, email, pw_hash, date_created, date_updated) VALUES ( :name, :alias, :email, :pw_hash, NOW(), NOW())",
            'get_user_by_email': "SELECT * FROM users WHERE email = :email LIMIT 1",
            'get_user_by_id': "SELECT id, name, alias, email FROM users WHERE id = :id",
            'get_all_other_users': "SELECT id, name, alias, email FROM users WHERE id != :id",
            
        }
    def register(self, form_data):
        pw_hash = self.bcrypt.generate_password_hash(form_data['password'])

        query = self.queries['create_user']
        data = {
            'name' : form_data['name'],
            'alias' : form_data['alias'],
            'email' : form_data['email'],
            'pw_hash' : pw_hash
        }
        result = self.db.query_db(query, data)
        return self.get_user_by_id(result)

    def validation(self, form_data):
        errors = []

        if len(form_data['name']) < 1:
            errors.append(self.validation_errors['empty_name'])
        if len(form_data['email']) < 1:
            errors.append(self.validation_errors['empty_email'])
        if not EMAIL_REGEX.match(form_data['email']):
            errors.append(self.validation_errors['email_invalid'])
        if len(form_data['password']) < 8:
            errors.append(self.validation_errors['password_length'])
        if form_data['password'] != form_data['confirm']:
            errors.append(self.validation_errors['password_match'])
        # if not form_data['birthday']:
        #     errors.append(self.validation_errors['empty_birth'])

        if len(errors) > 0:
            return errors

        result = self.get_user_by_email(form_data['email'])
        if len(result) > 0:
            errors.append(self.validation_errors['redundant_email'])
            return errors
        return self.register(form_data)

    def login(self, form_data):
        result = self.get_user_by_email(form_data['email'])
        if not result:
            return [self.validation_errors['invalid_login']]
        password = form_data['password']
        pw_hash = result[0]['pw_hash']

        pw_test = self.bcrypt.check_password_hash(pw_hash, password)
        if pw_test == False:
            return [self.validation_errors['invalid_login']]
        else:
            return {
                'id' : result[0]['id'],
                'name' : result[0]['name'],
                'alias' : result[0]['alias'],
            }
            
    def get_user_by_email(self, email):
        query = self.queries['get_user_by_email']
        data = { 'email': email }
        result = self.db.query_db(query, data)
        return result
    
    def get_user_by_id(self, id):
        query = self.queries['get_user_by_id']
        data = {'id' : id}
        result = self.db.query_db(query, data)
        return result[0]
        
    def get_all_other_users(self, id):
        query = self.queries['get_all_other_users']
        data = { 'id': id }
        result = self.db.query_db(query, data)
        return result