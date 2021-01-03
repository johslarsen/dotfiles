#!/usr/bin/env python
import email
from sys import argv, stdin, stdout
from os import getenv, fdopen

mail = email.message_from_string(stdin.read())

def mimetree(part, callback, prefix=""):
    if part.is_multipart():
        for i, child in enumerate(part.get_payload()):
            path = prefix + str(i)
            callback(path, child)
            if child.is_multipart():
                mimetree(child, callback, path+".")
    else:
        callback("0", part)


if len(argv) == 1:
    def summary(path, p):
        tokens = [path, p.get_content_type(), p.get_filename(), p.get_content_charset(), "%.1fKB"%(len(p.as_string())/1e3)]
        print(' '.join([str(t) for t in tokens if t]))

    mimetree(mail, summary)
else:
    with fdopen(stdout.fileno(), 'wb') as raw_stdout:
        dump_all = "*" in argv[1:]
        def dump_by_id(path, part):
            if not dump_all and path not in argv[1:]:
                return
            decoded = part.get_payload(decode=True)
            raw_stdout.write(decoded if decoded else part.as_bytes())

        mimetree(mail, dump_by_id)
