
class Animals:
    
    __id = 0 
    _animals_list = []
    __slots__ = ('_id','_name','_birthdate', '_commands')
    
    def __init__(self, name, birthdate, commands = []):        
        self._name = name
        self._birthdate = birthdate
        self._commands = commands
        self.counter()
        self._id = Animals.__id
        Animals._animals_list.append(self)

            
    @classmethod
    def counter(cls):
        if Animals._animals_list:
            Animals.__id = Animals._animals_list[-1]._id + 1
        else: Animals.__id = 1

    
    def __repr__(self):
        return f'{self._id};{self._name};{self.__class__.__name__};{self._birthdate};{self.__class__.__base__.__name__};{self._commands}\n'
    
    def __str__(self):
        return f'{self._id:>3}. {self.__class__.__base__.__name__}, {self.__class__.__name__}: {self._name}, {self._birthdate}, commands: {self._commands}'
        

class Pets(Animals):
    __slots__=()
class Pack_animals(Animals):
    __slots__=()

class Cat(Pets):
    __slots__=()
class Dog(Pets):
    __slots__=()
class Hamster(Pets):
    __slots__=()

class Horse(Pack_animals):
    __slots__=()
class Camel(Pack_animals):
    __slots__=()
class Donkey(Pack_animals):
    __slots__=()