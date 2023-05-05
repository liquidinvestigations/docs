# fix github image links into raw content links.
# This is automatically done by github wiki system, we must match it.

import subprocess

DIR = 'site/'

def blob_link_to_raw(link):
    return (
        link
        .replace("github.com", "raw.githubusercontent.com")
        .replace("/blob/", "/")
    )


def replace_link(old_link, new_link):
    script=f"""
        grep -Irl '{old_link}' {DIR} | xargs sed -i 's|{old_link}|{new_link}|g'
    """.strip()
    # print('+', script)
    try:
        subprocess.check_call(script, shell=True)
    except Exception as e:
        print(str(e))
        print('failed to replace link: ', old_link)
        print('with new link: ', new_link)



with open("original-links.txt") as f:
    LINKS = [x.strip() for x in f.readlines()]
for link in LINKS:
    replace_link(link, blob_link_to_raw(link))
