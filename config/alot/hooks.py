#!/usr/bin/env python3
#from alot.settings.const import settings
from alot.buffers import SearchBuffer
from alot.commands.globals import ExternalCommand
import logging
import re
import subprocess
import sys

log = logging.getLogger('hooks')

def name_addr(realname, address):
    return "%s<%s>"%(realname + " " if realname != "" else "", address)

ANSI_ESCAPE = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/ ]*[@-~])')
def text_quote(message):
    return re.sub("^", "> ", ANSI_ESCAPE.sub('', message), 0, re.MULTILINE)

def reply_prefix(realname, address, timestamp, message=None, ui=None, dbm=None):
    return "%s, %s wrote:\n"%(timestamp.strftime("%Y-%m-%d %H:%M:%S%Z"), name_addr(realname, address))

FORWARDED_HEADERS = ["From", "To", "Cc", "Date", "Subject"]
def forward_prefix(realname, address, timestamp, message=None, ui=None, dbm=None):
    headers = [h + ": " + message.get(h) if message.get(h) else None for h in FORWARDED_HEADERS]
    return "--- Begin forwarded message ---\n%s\n\n"%("\n".join([h for h in headers if h]))

def add_from_to_bcc(ui):
    for addr in ui.current_buffer.envelope.get_all("From"):
        ui.current_buffer.envelope.add("Bcc", addr)

async def pre_envelope_send(ui=None, dbm=None, cmd=None):
    add_from_to_bcc(ui)

def poll_new_mail(ui):
    ui.notify("Polling new mail ...")
    proc = subprocess.run(["notmuch", "new"], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    msg = "Periodic `notmuch new`:\n" + proc.stdout.decode("UTF-8")
    log.info(msg) if proc.returncode == 0 else log.error(msg)
    summary = [l for l in msg.splitlines() if not re.match(r'^[0-9]', l)][-1]

    if summary != "No new mail.":
        buf = ui.current_buffer
        if buf and buf.modename == 'search' and re.match(r'tag:inbox', buf.get_info()['querystring']):
            log.debug("Reloading buffer: " + str(buf.get_info()))
            buf.rebuild()
        sys.stdout.write("\a")
    ui.notify(summary)

async def pipeto(ui):
    await ui.apply_command(ExternalCommand("nvim"))

def loop_hook(ui=None):
    poll_new_mail(ui)
