
import re
import os


VERBOSE_YUI = False
YUI_APP_PATH = 'd:\\www\\yuicompressor-2.4.8.jar'
MIN_SUFF = 'min'
ORIGIN_HTML_PATH = 'data\\list-of-files.html'
ORIGIN_PRE_URL_REPLACES = ['js/', 'src/origin/']
RESULT_PATH = 'src\\box2d.js'
RESULT_MIN_PATH = 'src\\box2d.min.js'

def _yui_compress(src, dst):
    cmd = [
        YUI_APP_PATH,
        '-v' if VERBOSE_YUI else '',
        src,
        '-o', dst,
        '--charset utf-8',
        '--line-break 1000'
    ]
    cmd = ' '.join(cmd)
    os.system(cmd)

def _read(path):
    with open(path) as fh:
        data = fh.read()
        print 'read file', path, len(data)
        fh.close()
    return data or ''

def _proc_src(src):
    data = []
    min_data = []
    src = src.replace(*ORIGIN_PRE_URL_REPLACES)
    dst = src.split('.')
    dst.insert(-1, MIN_SUFF)
    dst = '.'.join( dst )
    _yui_compress(src, dst)
    _proc_dst(src, dst, data, min_data)
    with open(RESULT_PATH, 'a') as fh:
        fh.write( '\n\n'.join(data) )
        fh.close()
    with open(RESULT_MIN_PATH, 'a') as fh:
        fh.write( u'\n'.join(min_data) )
        fh.close()

def _proc_dst(src, dst, data, min_data):
    text = _read(src)
    data.append(text)
    text = _read(dst)
    min_data.append(text)
    os.remove(dst)

def main():
    src_re = re.compile(r'<script src=\'([^\']+)\'')
    if os.path.isfile(RESULT_PATH):
        os.remove(RESULT_PATH)
    if os.path.isfile(RESULT_MIN_PATH):
        os.remove(RESULT_MIN_PATH)
    data = _read(ORIGIN_HTML_PATH)
    for item in src_re.findall(data):
        if item.startswith('js/'):
            _proc_src(item)


if __name__ == '__main__':
    main()
