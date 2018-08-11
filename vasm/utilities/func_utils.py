import utilities.dicts as dicts


def mem(num):
    num = int(num)
    return '0' * (8 - len(bin(num)[2:])) + bin(num)[2:]


def d_to_bin(num):
    num = int(num)
    if num < -128 or num > 127:
        raise ValueError
    if -128 <= num < 0:
        num += 256
    return '0' * (8 - len(bin(num)[2:])) + bin(num)[2:]


def b_to_bin(num):
    if len(num) <= 8 and all(c == '1' or c == '0' for c in num):
        return '0' * (8 - len(num)) + num
    else:
        raise ValueError


def data_split(line):
    string = False
    data = []
    tab = []
    for char in line:
        if char == ';' and not string:
            return data

        if char == "'" or char == '"':
            if not string:
                string = True
            elif tab and (char == tab[0] or tab[0:4] == ['d', 'u', 'p', '(']):
                string = False

        if (char.isspace() or char == ',') \
                and not string:
            if tab:
                if tab[0:4] == ['d', 'u', 'p', '('] and tab[-1] == ')':
                    data[-1] += ' dup ' + ''.join(tab[4:-1])
                else:
                    data.append(''.join(tab))

                tab = []
            continue
        else:
            tab.append(char)

    return data


def code_split(line):
    command = line.split()
    if not command or command[0][0] == ';':
        return True, None, None

    command = line.split(';')[0].split()
    if command[0][-1] == ':':
        label = command[0][:-1]
        command = command[1:]
    elif command[0] == 'endcode':
        label = command[0]
        command = command[1:]
    else:
        label = None

    if command:
        if command[0].upper() == 'MOV':
            command = ' '.join(command).translate(str.maketrans(',', ' ')).split()
            return True, label, command
        if command[0].upper() in dicts.zero and len(command) == 1:
            return True, label, command
        if command[0].upper() in dicts.un and len(command) == 2:
            return True, label, command
        if command[0].upper() in dicts.bi and len(command) == 3 and command[1][-1] == ',':
            command[1] = command[1][:-1]
            return True, label, command
        else:
            return False, label, None
    else:
        return True, label, None

