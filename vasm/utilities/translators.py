import utilities.dicts as dicts
import utilities.func_utils as utils


def hlt_order(line, _):
    return True, ['0000' + '0' * 12]


def nop_order(line, _):
    return True, ['1110' + '0' * 12]


def neg_order(line, _):
    line[1] = '1'
    return unary(line)


def not_order(line, _):
    line[1] = '0'
    return unary(line)


def shl_order(line, _):
    line[1] = '1'
    return shift(line)


def shr_order(line, _):
    line[1] = '0'
    return shift(line)


def jz_order(line, labels):
    line[1] = '0000'
    return jump(line, labels)


def jnz_order(line, labels):
    line[1] = '0001'
    return jump(line, labels)


def je_order(line, labels):
    line[1] = '0000'
    return jump(line, labels)


def jne_order(line, labels):
    line[1] = '0001'
    return jump(line, labels)


def jg_order(line, labels):
    line[1] = '0010'
    return jump(line, labels)


def jge_order(line, labels):
    line[1] = '0011'
    return jump(line, labels)


def jl_order(line, labels):
    line[1] = '0100'
    return jump(line, labels)


def jle_order(line, labels):
    line[1] = '0101'
    return jump(line, labels)


def jc_order(line, labels):
    line[1] = '0110'
    return jump(line, labels)


def jnc_order(line, labels):
    line[1] = '0111'
    return jump(line, labels)


def jo_order(line, labels):
    line[1] = '1000'
    return jump(line, labels)


def jno_order(line, labels):
    line[1] = '1001'
    return jump(line, labels)


def jn_order(line, labels):
    line[1] = '1010'
    return jump(line, labels)


def jnn_order(line, labels):
    line[1] = '1011'
    return jump(line, labels)


def jmp_order(line, labels):
    line[1] = '1100'
    return jump(line, labels)


def add_order(line, _):
    line[1] = '0110'
    return alu(line)


def sub_order(line, _):
    line[1] = '0111'
    return alu(line)


def cmp_order(line, _):
    line[1] = '1000'
    return alu(line)


def test_order(line, _):
    line[1] = '1001'
    return alu(line)


def and_order(line, _):
    line[1] = '0010'
    return alu(line)


def or_order(line, _):
    line[1] = '0011'
    return alu(line)


def xor_order(line, _):
    line[1] = '0100'
    return alu(line)


def pushf_order(line, _):
    line[1] = '1100'
    return stack_un(line)


def popf_order(line, _):
    line[1] = '0100'
    return stack_un(line)


def puship_order(line, _):
    line[1] = '1010'
    return stack_un(line)


def popip_order(line, _):
    line[1] = '0010'
    return stack_un(line)


def push_order(line, _):
    line[1] = '1000'
    return stack_bi(line)


def pop_order(line, _):
    line[1] = '0000'
    return stack_bi(line)


def lea_order(line, labels):
    if line[2].upper() not in dicts.registers:
        return False, 'Line ' + str(line[0]) + ': op1 not register.'
    if line[3] not in labels:
        return False, 'Line ' + str(line[0]) + ': unrecognized label.'
    else:
        return True, ['10100' + dicts.registers[line[2].upper()] + labels[line[3]]]


def inc_order(line, _):
    return add_order([line[0], 'add', line[2], '1d'], _)


def dec_order(line, _):
    return sub_order([line[0], 'sub', line[2], '1d'], _)


def ret_order(line, _):
    return popip_order(line, _)


def call_order(line, labels):
    push = puship_order(line, labels)
    jmp = jmp_order(line, labels)
    if jmp[0]:
        return True, jmp[1] + push[1]


def mov_order(line, _):
    mov = '1100'
    if line[2].upper() in dicts.registers:
        # reg -> reg
        if line[3].upper() in dicts.registers:
            return True, [mov + '0000' + dicts.registers[line[2].upper()] +
                          dicts.registers[line[3].upper()] + '0' * 2]
        # mem -> reg
        if line[3] == 'byte' and line[4] == 'ptr' and line[5][:4] == 'ds:[' and line[5][6] == ']':
            if line[5][4:6].upper() in dicts.registers:
                return True, [mov + '0010' + dicts.registers[line[2].upper()] +
                              dicts.registers[line[5][4:6].upper()] + '0' * 2]
            else:
                return False, 'Line ' + str(line[0]) + ': op2 not correct register.'
        # num -> reg
        try:
            if line[3][-1] == 'b':
                num = utils.b_to_bin(line[3][:-1])
            else:
                num = utils.d_to_bin(line[3][:-1])
        except (ValueError, TypeError):
                return False, 'Line ' + str(line[0]) + ': op2 not proper number.'
        else:
            return True, [mov + '1' + dicts.registers[line[2].upper()] + num]

    # reg -> mem
    if line[2] == 'byte' and line[3] == 'ptr' and line[4][:4] == 'ds:[' and line[4][6] == ']':
        if line[4][4:6].upper() in dicts.registers and line[5].upper() in dicts.registers:
            return True, [mov + '0001' + dicts.registers[line[4][4:6].upper()] +
                          dicts.registers[line[5].upper()] + '0' * 2]
        else:
            return False, 'Line ' + str(line[0]) + ': not correct register.'
    else:
        return False, 'Line ' + str(line[0]) + ': unrecognized command.'


def unary(line):
    if line[2].upper() not in dicts.registers:
        return False, 'Line ' + str(line[0]) + ': op1 not register.'
    else:
        return True, ['0101' + line[1] + dicts.registers[line[2].upper()] + '0' * 8]


def shift(line):
    if line[2].upper() not in dicts.registers:
        return False, 'Line ' + str(line[0]) + ': op1 not register.'
    try:
        if line[3][-1] == 'b':
            num = utils.b_to_bin(line[3][:-1])
        else:
            num = utils.d_to_bin(line[3][:-1])
        if not all([c == '0' for c in num[:6]]):
            raise ValueError
    except (ValueError, TypeError):
            return False, 'Line ' + str(line[0]) + ': op2 not proper number.'
    else:
        return True, ['1011' + line[1] + dicts.registers[line[2].upper()] +
                      num[5:] + '0' * 5]


def jump(line, labels):
    if line[2] not in labels:
        return False, 'Line ' + str(line[0]) + ': unrecognized label.'
    else:
        return True, ['0001' + line[1] + labels[line[2]]]


def alu(line):
    if line[2].upper() not in dicts.registers:
        return False, 'Line ' + str(line[0]) + ': op1 not register.'
    if line[3].upper() in dicts.registers:
        return True, [line[1] + '0' + dicts.registers[line[2].upper()] +
                      dicts.registers[line[3].upper()] + '0' * 5]
    else:
        try:
            if line[3][-1] == 'b':
                num = utils.b_to_bin(line[3][:-1])
            else:
                num = utils.d_to_bin(line[3][:-1])
        except (ValueError, TypeError):
            return False, 'Line ' + str(line[0]) + ': op2 not register nor proper number.'
        else:
            return True, [line[1] + '1' + dicts.registers[line[2].upper()] + num]


def stack_bi(line):
    if line[2].upper() not in dicts.registers:
        return False, 'Line ' + str(line[0]) + ': op1 not register.\n'
    else:
        return True, ['1101' + line[1] + dicts.registers[line[2].upper()] + '0' * 5]


def stack_un(line):
    return True, ['1101' + line[1] + '0' * 8]
