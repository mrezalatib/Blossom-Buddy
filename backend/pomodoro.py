import time
import sqlite3
from colorama import Fore, Style, init
from orca.debug import printResult
from prettytable import PrettyTable
from watchdog.utils.echo import echo_class


def welcome_user():
    print("Hello! Welcome to Pomodoro")


"""
step 1: allow users to add their pomodoros to the database. each pomodoro is also
returned and stored in a list in the main function
"""


def get_pomodoro():
    print("Make sure your pomodoros are achievable!")
    pomodoro = input(Fore.RESET + "Add a pomodoro: ")

    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    cursor.execute("""
CREATE TABLE IF NOT EXISTS pomodoros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pomodoro TEXT NOT NULL)
""")
    cursor.execute('''
INSERT INTO pomodoros (pomodoro)
VALUES (?)
''', (pomodoro,))

    print(Fore.GREEN+"Pomodoro added successfully!"+Fore.RESET)
    connection.commit()  # save changes to database
    connection.close()

    return pomodoro


def display_pomodoro_list():
    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    cursor.execute('SELECT * FROM pomodoros')
    rows = cursor.fetchall()

    for row in rows:
        if len(rows) > 0:
            print("ID: "+ Fore.GREEN+  f"{row[0]}" + Fore.RESET+ f", Pomodoro: {row[1]}")
        else:
            print("There are no pomodoros in the database!")

    connection.close()


"""
step 2: get a users sprint time
"""


def get_sprint_time():
    sprint_time = input("Enter your sprint time in minutes (eg. 30): ")

    while not sprint_time.isdigit() or sprint_time not in [str(x) for x in range(1, 61)]:
        print("Please enter a valid sprint time!")
        sprint_time = input("Enter your sprint time in minutes (eg. 30): ")

    return int(sprint_time)


"""
determine the length of the break inbetween sprints dependent on no. of pomodoros
and users specified sprint time.

im going to workshop this part because i want to create an algorithm that calculates
break-time. for now it will be hardcoded in a sense.
"""

def start_break():
    print("Your break has started")
    time.sleep(15)
    print("Get back to work")


def assign_index_to_pomodoros(pomodoro_list):
    index = 0
    pomodoro_with_index = []
    for pomodoro in pomodoro_list:
        index += 1
        pomodoro_with_index.append([index, pomodoro])

    return pomodoro_with_index


def add_done_pomodoros_to_database(pomodoro):
    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    cursor.execute("""
CREATE TABLE IF NOT EXISTS completed_pomodoros (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pomodoro TEXT NOT NULL)
""")
    cursor.execute('''
INSERT INTO completed_pomodoros (pomodoro)
VALUES (?)
''', (pomodoro,))

    connection.commit()
    connection.close()

    print(Fore.BLUE+"You have completed a task. Well done!"+Fore.RESET)


def mark_pomodoro_as_done():
    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    cursor.execute('SELECT * FROM pomodoros')
    rows = cursor.fetchall()

    for row in rows:
        print(f"ID: " + Fore.GREEN+ f"{row[0]}" + Fore.RESET+ f", Pomodoro: {row[1]}")

    pomodoro_id = input("Which pomodoro would you like to mark as DONE? (select an index): ")

    # add the specified pomodoro to completed pomodoros table in database
    for row in rows:
        if int(pomodoro_id) == row[0]:
            completed_pomodoro = row[1]
            add_done_pomodoros_to_database(completed_pomodoro)

    # remove the pomodoro from pomodoros table in database
    cursor.execute('DELETE FROM pomodoros WHERE id = ?', (pomodoro_id,))
    connection.commit()
    connection.close()


def display_completed_pomodoros():
    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    cursor.execute('SELECT * FROM completed_pomodoros')
    rows = cursor.fetchall()

    print("Well done on completing these pomodoros:\n")
    for row in rows:
        print(f"ID: {row[0]}, Pomodoro: {row[1]}")


def fetch_item_by_index(index):
    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    query = "SELECT * FROM pomodoros WHERE id = ?"
    cursor.execute(query, (index,))
    result = cursor.fetchone()

    return result


def get_pomodoro_id():

    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    cursor.execute('SELECT * FROM pomodoros')
    rows = cursor.fetchall()

    valid_indexes = [str(row[0]) for row in rows]

    pomodoro_id = input("\nWhich pomodoro would you like to DELETE (select an index): ")

    while pomodoro_id not in valid_indexes:
        print(Fore.RED + "Pomodoro index does not exist!" + Fore.RESET)
        pomodoro_id = input("\nWhich pomodoro would you like to DELETE (select an index): ")

    return pomodoro_id


def delete_pomodoro():
    connection = sqlite3.connect('./pomodoros.db')
    cursor = connection.cursor()

    cursor.execute('SELECT * FROM pomodoros')
    rows = cursor.fetchall()

    for row in rows:
        print(f"ID: " + Fore.GREEN+ f"{row[0]}" + Fore.RESET+ f", Pomodoro: {row[1]}")

    pomodoro_id = get_pomodoro_id()

    pomodoro_to_delete = fetch_item_by_index(pomodoro_id)
    confirm_deletion = input("Are you sure you want to delete"+ Fore.RED+f" '{pomodoro_to_delete[1]}'"+Fore.RESET +"? (y/n): ")

    if confirm_deletion == 'y':
        # remove the pomodoro from pomodoros table in database
        cursor.execute('DELETE FROM pomodoros WHERE id = ?', (pomodoro_id,))
        connection.commit()
        connection.close()
        print(Fore.RED+f"'{pomodoro_to_delete[1]}' was deleted.".upper()+Fore.RESET)
    else:
        print(Fore.BLUE + f"'{pomodoro_to_delete[1]}' was not removed from the database."+ Fore.RESET)


def display_menu():
    table = PrettyTable()
    table.field_names = ["Index", "Description"]

    table.add_row([Fore.GREEN+"1"+Fore.RESET, Fore.GREEN+"Add a pomodoro."+Fore.RESET])
    table.add_row([Fore.GREEN+"2"+Fore.RESET, Fore.GREEN+"Delete a pomodoro."+Fore.RESET])
    table.add_row([Fore.GREEN+"3"+Fore.RESET, Fore.GREEN+"Mark a pomodoro as completed."+Fore.RESET])
    table.add_row([Fore.GREEN+"4"+Fore.RESET, Fore.GREEN+"Display pomodoros."+Fore.RESET])
    table.add_row([Fore.GREEN+"5"+Fore.RESET, Fore.GREEN+"Display completed pomodoros."+Fore.RESET])
    table.add_row([Fore.GREEN+"6"+Fore.RESET, Fore.GREEN+"Get help."+Fore.RESET])
    table.add_row([Fore.GREEN+"7"+Fore.RESET, Fore.GREEN+"Quit the program."+Fore.RESET])

    print("\n", table)


def display_help():
    print("This help function will be updated later")


def run():
    while True:

        display_menu()
        user_input = input(Fore.RESET + "What would you like to do?: ")
        print()
        if user_input == '1': #add pomodoro
            get_pomodoro()

        elif user_input == '2':
            delete_pomodoro() #delete pomodoro

        elif user_input == '3':
            mark_pomodoro_as_done() #mark pomodoro as done

        elif user_input == '4':
            display_pomodoro_list() #show pomodoros

        elif user_input == '5':
            display_completed_pomodoros() #show done pomodoros

        elif user_input == '6':
            display_help()

        elif user_input == '7':
            print("\033[32mQuitting...\033[0m")
            break

        else:
            print("Invalid input. Please choose a valid option.")


if __name__ == "__main__":
    run()
