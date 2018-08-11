import utilities.func_utils as util
import utilities.translators as trans
import utilities.dicts as dicts


class Reader:

    def __init__(self):
        self.data = []
        self.code = []
        self.labels = {}
        self.errors = []

    def data_reader(self, file, line_num):
        mem_ptr = 0
        i = 0
        for line in file:
            if mem_ptr > 255:
                self.errors.append('Line ' + str(line_num + i) +
                                   ': exceeded memory in data segment.')
                return False, i

            i += 1
            data = util.data_split(line)
            if not data:
                continue
            if data[0] == 'enddata':
                return True, i

            if data[0][-1] == ':':
                self.labels[data[0][:-1]] = util.mem(mem_ptr)
                if data[1] == 'db':
                    data = data[1:]

            if data[0] != 'db':
                self.errors.append("Line " + str(line_num + i) +
                                   ": missing word 'db'.")
                continue

            for word in data[1:]:
                if word[0] == word[-1] == "'" or word[0] == word[-1] == '"':
                    for c in word[1:-1]:
                        self.data.append(str(mem_ptr) + ' : ' +
                                         util.d_to_bin(ord(c)))
                        mem_ptr += 1
                elif 'dup' in word:
                    try:
                        word = word.split()
                        assert len(word) == 3
                        num = int(word[0])
                        pattern = word[2]
                        if pattern[-1] == 'b':
                            pattern = util.b_to_bin(pattern[:-1])
                        elif pattern[-1] == 'd':
                            pattern = util.d_to_bin(pattern[:-1])
                        else:
                            pattern = util.d_to_bin(ord(pattern[1:-1]))
                    except (ValueError, TypeError, AssertionError):
                        self.errors.append("Line " + str(line_num + i) +
                                           ": incorrect dup statement.")
                    else:
                        for k in range(num):
                            self.data.append(str(mem_ptr) + ' : ' + pattern)
                            mem_ptr += 1
                else:
                    try:
                        if line[3][-1] == 'b':
                            num = util.b_to_bin(word[:-1])
                        else:
                            num = util.d_to_bin(word[:-1])
                    except (ValueError, TypeError):
                        self.errors.append("Line " + str(line_num + i) +
                                           ": incorrect number format.")
                    else:
                        self.data.append(str(mem_ptr) + ' : ' + num)
                        mem_ptr += 1

    def code_reader(self, file, line_num):
        mem_ptr = 0
        end_code = False
        i = 0
        for line in file:
            if mem_ptr > 255:
                self.errors.append('Line ' + str(line_num + i) +
                                   ': exceeded memory in code segment.')
                break
            i += 1
            proper, label, command = util.code_split(line)
            if not proper:
                self.errors.append('Line ' + str(line_num + i) +
                                   ': incorrect syntax.')
                continue
            if label == 'endcode':
                end_code = True
                break
            if label:
                self.labels[label] = util.mem(mem_ptr)
            if not command:
                continue

            self.code.append([line_num + i] + command)
            mem_ptr += 2 if command[0] == 'call' else 1

        if not end_code:
            return False, i

        code = []
        mem_ptr = 0
        for command in self.code:

            compiled = False
            if command[1].upper() in dicts.zero or command[1].upper() in \
                    dicts.un or command[1].upper() in dicts.bi:
                compiled, msg = getattr(trans, command[1].lower() +
                                        '_order')(command, self.labels)

            if compiled:
                if len(msg) == 2:
                    # 'call' -> puship (msg[1]); jmp label (msg[0])
                    code.append(str(mem_ptr) + ' : ' + msg[1])
                    mem_ptr += 1
                code.append(str(mem_ptr) + ' : ' + msg[0])
                mem_ptr += 1
            else:
                self.errors.append(msg)
        self.code = code
        return True, i
