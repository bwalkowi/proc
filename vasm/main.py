import os
import argparse
import utilities.readers as readers


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("file_path", help="path to file to compile.")
    args = parser.parse_args()

    if not os.path.isfile(args.file_path):
        print("\nThe given 'file_path' doesn't point to file.\n")

    else:
        reader = readers.Reader()
        data_read = False
        code_read = False
        with open(args.file_path, 'r') as file:

            # i -> number of line currently being read
            i = 0
            for line in file:
                i += 1
                command = line.split()
                if not command or command[0][0] == ';':
                    continue
                if command[0] == 'data:':
                    # data segment can be read only once and before code segment
                    if not code_read and not data_read:
                        output = reader.data_reader(file, i)
                        data_read = output[0]
                        i += output[1]
                    else:
                        reader.errors.append('Line ' + str(i) +
                                             ': data segment can be '
                                             'placed only once before'
                                             ' code segment.')
                # code segment can be read anytime but only once
                elif command[0] == 'code:' and not code_read:
                    output = reader.code_reader(file, i)
                    code_read = output[0]
                    i += output[1]
                else:
                    reader.errors.append('Line ' + str(i) +
                                         ': incorrect/unrecognized syntax.')

        if reader.errors or not code_read:
            print('\nCompilation failed.\n')
            for error in reader.errors:
                print(error)
        else:
            print('\nCompilation succeeded.\n')
            with open('data.mif', 'w') as f:
                f.write('DEPTH = 256;\n'
                        'WIDTH = 8;\n\n'
                        'ADDRESS_RADIX = DEC;\n'
                        'DATA_RADIX = BIN;\n\n'
                        'CONTENT BEGIN\n'
                        '\t[0..255] : 00000000;\n')
                for data in reader.data:
                    f.write('\t' + data + ';\n')
                f.write('END;')

            with open('code.mif', 'w') as f:
                f.write('DEPTH = 256;\n'
                        'WIDTH = 16;\n\n'
                        'ADDRESS_RADIX = DEC;\n'
                        'DATA_RADIX = BIN;\n\n'
                        'CONTENT BEGIN\n'
                        '\t[0..255] : 0000000000000000;\n')
                for code in reader.code:
                    f.write('\t' + code + ';\n')
                f.write('END;')


if __name__ == "__main__":
    main()
