# Save all assets (PNG, JPG, fonts, etc.) into local folder,
# then replace their links to match.
# This is required for offline website use.

import os
import subprocess
from urllib.parse import urlparse
from urllib.request import urlretrieve

SITE_DIR = 'site'
OUT_FOLDER_NAME = '_DOWNLOADED_ASSETS'
OUT_DIR = 'site/' + OUT_FOLDER_NAME
os.makedirs(OUT_DIR)

with open("all-links.txt") as f:
    LINKS = [x.strip() for x in f.readlines()]

ALLOWED_EXTENSIONS = [ "jpg", "jpeg", "png", "svg", "css", "gif", "woff2", "xml", "js" ]



def replace_link(old_link, new_link):
    script=f"""
        grep -Irl '{old_link}' {SITE_DIR} | xargs sed -i 's|{old_link}|{new_link}|g'
    """.strip()
    # print('+', script)
    try:
        subprocess.check_call(script, shell=True)
    except Exception as e:
        print(str(e))
        print('failed to replace link: ', old_link)
        print('with new link: ', new_link)




i = 0
for link in LINKS:
    if 'w3.org' in link:
        continue
    filename = os.path.basename(urlparse(link).path)
    for ext in ALLOWED_EXTENSIONS:
        if not filename.lower().endswith(ext):
            continue

        i += 1

        filename = OUT_DIR + '/' + str(i) + '.' + ext
        relative_link = './' + OUT_FOLDER_NAME + '/' + str(i) + '.' + ext

        try:
            urlretrieve(link, filename)
        except Exception as e:
            print(str(e))
            print('failed to download link: ', link)
            break
        replace_link(link, relative_link)
        break

