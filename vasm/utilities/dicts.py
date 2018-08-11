zero = ['RET', 'PUSHF', 'POPF', 'PUDHIP', 'POPIP', 'HLT', 'NOP']
un = ['INC', 'DEC', 'CALL', 'NOT', 'NEG', 'PUSH', 'POP', 'JZ', 'JNZ', 'JE', 'JNE',
      'JG', 'JGE', 'JL', 'JLE', 'JC', 'JNC', 'JO', 'JNO', 'JN', 'JNN', 'JMP']
bi = ['MOV', 'SHR', 'SHL', 'ADD', 'SUB', 'CMP', 'TEST', 'AND', 'OR', 'XOR', 'LEA']

registers = {'AX': '000',
             'BX': '001',
             'CX': '010',
             'DX': '011',
             'EX': '100',
             'FX': '101',
             'GX': '110',
             'HX': '111'}
