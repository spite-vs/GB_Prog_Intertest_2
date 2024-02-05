from animals import *
from csv import DictReader
from os.path import isfile
from ast import literal_eval
from datetime import datetime

def err():
    print('\n -- Нажимай на клавиши с умом --')


def end():
    print('\n -- Возвращайся, я буду ждать --')


def animal_name():
    i = input('Имя животного:\n')
    while not i:
        print('Имя не может быть пустым')
        i = input('Имя животного:\n')
    return i

def date_validator(date):
    try:
        val_date = datetime.strptime(date, '%Y-%m-%d')
        if val_date >= datetime.today():
            print('Дата не может быть в будущем')
            return True
    except ValueError:
        print('Неверный формат даты')
        return True
        
def animal_birthdate():
    i = input('Дата рождения в формате(YYYY-MM-DD):\n')
    while date_validator(i):
        i = input('Дата рождения в формате(YYYY-MM-DD):\n')
    return i

def commands():
    lst=[]
    com = ' '
    q = {'q', 'quit', ''}
    while com not in q:
        com = input('(Если животное больше ничего не умеет, введите q)\nЖивотное умеет:\n')
        if com not in {'q', 'quit', '', ' ', 'й'}:
            lst.append(com)
    return lst
    
def wrt(dt):
    with open('animals.csv', 'w', encoding='utf-8', newline='') as an:
        an.write('id;name;type;birthdate;class;commands\n')
        an.writelines(map(repr,dt))
        
def int_validator(x):
    try:
        int(x)
    except ValueError:
        print('Соберись!')
        return True
        
        
def init_list():
    if not isfile('animals.csv'):
        return
    else:
        with open('animals.csv', 'r', encoding='utf-8', newline='') as an:
            reader = DictReader(an, delimiter=';')
            lst=[]
            for row in reader:
                i = globals()[row['type']]
                lst.append(i(row['name'],row['birthdate'], literal_eval(row['commands'])))
            Animals._animals_list = lst
    

def input_data():
    command = ''
    type_animal = {'1': Cat, '2': Dog, '3': Hamster,
                 '4': Horse, '5': Camel, '6': Donkey, '7': end}
    while command not in type_animal:
        print('\nКакое животное хотите внести:\n1. Кот\n2. Собака\n3. Хомяк\n4. Лошадь\n5. Верблюд\n6. Осёл\n7. Выйти')
        command = input("Введите номер операции: ")
        if command not in '123456':
            type_animal.get(command, err)()
        else:
            type_animal.get(command, err)(animal_name(), animal_birthdate(), commands())


def print_data():
    print()
    for i in Animals._animals_list:
        print(i)
    print()
    com = input('\nОтсортировать по дате? (Y/N)(Д/Н)')
    while com not in 'yYnNдДнН':
        err()
        com = input('\nОтсортировать по дате? (Y/N)(Д/Н)')
    if com in 'nNнН':
        print()
    else:
        for i in sorted(Animals._animals_list, key=lambda x: datetime.strptime(x._birthdate, '%Y-%m-%d')):
            print(i)

    
def put_command():
    print_data()
    i = input('Какому животному добавляем команду: ')
    while int_validator(i) or int(i) <= 0 or int(i) > len(Animals._animals_list):
        i = input('Какому животному добавляем команду: ')
    lst=commands()
    Animals._animals_list[int(i)-1]._commands.extend(lst)
    
    
def menu():
    init_list()
    command = ''
    operation = {'1': input_data, '2': print_data, '3': put_command, '4': end}
    while command != '4':
        print('\nБаза данных для животных:\n1. Внести\n2. Вывести на экран\n3. Добавить команду\n4. Выйти и сохранить')
        command = input("Введите номер операции: ")
        operation.get(command, err)()
    wrt(Animals._animals_list)