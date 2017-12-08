"""
Test given palindrome determiner executables
"""

import sys
import os
import shutil
import subprocess
import argparse
import string
import random
import time

std_true = [
    "Dennis and Edna sinned",
    "  d e,NNis aN D EDNASINNED!",
    "",
    ",",
    ",a,",
    "!a,abaa",
    "a",
    " a ",
    "race car",
    "a man, a plan, a canal. PANAMA!",
    "aaaaaaaaaaaaabaaaaaaaaaaaaa",
    ]

std_false = [
    "ab",
    "wherefore art thou romeo",
    "python",
    "Guido Van Rossum",
    "aab",
    "a, b",
    "bbbbbbbbbbbbbbbbbbbbbba",
    "aaaaaaaaaaaaaabaaaaaaaaaaaa",
    "b,,,,,,,,,,,,,,,,a"]

def generate_pal(n):
    s = "".join(random.choice(string.printable) for _ in range(n))
    return f"{s}{s[::-1]}"

def gen_nonpal(n):
    p = f"{''.join(random.choice(string.printable) for _ in range(n))}{random.choice(string.ascii_letters)}"
    app = string.ascii_uppercase[(ord(next(filter(str.isalpha, p)).upper()) - 65 + 13) % 26]
    return f"{p}{app}"

def get_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("execs", nargs="*", type=str,
                            help="executable scripts to target")
    parser.add_argument("--no-test", action="store_true",
                            help="don't test each palindrome generated")
    parser.add_argument("-n", type=int, default=500,
                            help="number of extra test cases to generate for both true and false")
    parser.add_argument("-d", action="store_true",
                            help="dump testcases")
    return parser.parse_args()

def is_pal(s):
    s = list(filter(str.isalpha, s.lower()))
    return s == s[::-1]

def is_true(out):
    return "true" in out.decode().lower()

def script_result(script, *args):
    proc = subprocess.Popen([script, *args], stdout=subprocess.PIPE)
    return proc.communicate()

def test_script(script):
    start = time.time()
    exe = shutil.which(script)
    if not exe:
        sys.exit(f"** can't find executable {script!r}")
    for tst in std_true:
        out, err = script_result(exe, tst)
        if err:
            sys.exit(f"{exe!r} wrote {err!r} on {tst!r}")
        if not is_true(out):
            sys.exit(f"{exe!r} failed {out!r} on {tst!r}")
    for tst in std_false:
        out, err = script_result(exe, tst)
        if err:
            sys.exit(f"{exe!r} wrote {err!r} on {tst!r}")
        if is_true(out):
            sys.exit(f"{exe!r} failed {out!r} on {tst!r}")
    print(f"{exe!r} ok in {time.time() - start:.3f}s")

if __name__ == "__main__":
    args = get_args()
    start = time.time()
    for _ in range(args.n):
        std_true.append(generate_pal(random.randrange(20)))
        std_false.append(gen_nonpal(random.randrange(20)))
    print(f"generated {args.n} testcases in {time.time() - start:.3f}s")
    if not args.no_test:
        print("verifying testcases")
        start = time.time()
        for t in std_true:
            if not is_pal(t):
                sys.exit(f"bad palindrome {t!r}")
        for t in std_false:
            if is_pal(t):
                sys.exit(f"bad non-palindrome {t!r}")
        print(f"finished in {time.time() - start:.3f}s")
    else:
        print("skipping verification")
    if args.d:
        print(f"{chr(10).join(map('true: {!r}'.format, std_true))}\n{chr(10).join(map('false: {!r}'.format, std_false))}")
    if not args.execs:
        print("nb no scripts were supplied")
    for script in args.execs:
        test_script(script)
