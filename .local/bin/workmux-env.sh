#!/bin/sh
# Source the standard Versaterm dev environment, then repoint every
# VDXDIR-derived variable at a workmux worktree instead of the shared
# checkout (/usr1/vdxiii_8.1/vdxiii) that setup_recenv.vtmpgsql.dev
# hardcodes at line 139. That script is root-owned, shared by every user
# on this box, and not something to edit for a per-worktree path — so this
# re-derives the same "VDXDIR-relative structures" block it computes,
# against $1 (default: $PWD) instead.
#
# Usage: . ~/.local/bin/workmux-env.sh [worktree_path]

_wm_target="${1:-$PWD}"

. /usr/local/bin/setup_recenv.vtmpgsql.dev

VDXDIR="${_wm_target}"

BASEDIR=${VDXDIR}
BASEDIR_ACTIVE_LINK=${VDXDIR_ACTIVE_LINK}
RUNTIME=${VDXDIR}/e
VERRUNTIME=${VDXDIR}/e
VDXPHP=${VDXDIR}/web_browser/php_scripts
VDXSCRIPTS=${VDXDIR}/e/scripts

RECORDS=${VDXDIR}
VERSONNEL=${VDXDIR}
RECDIR=${VDXDIR}/records

if [ -f "${VDXDIR}/etc/termcap.vdx" ]; then
    TERMCAP=${VDXDIR}/etc/termcap.vdx
fi
if [ -d "${VDXDIR}/etc/terminfo" ]; then
    TERMINFO=${VDXDIR}/etc/terminfo
fi

# CLIENT_SITE_TYPE is hardcoded "US" in setup_recenv.vtmpgsql.dev — mirror
# that here rather than re-deriving the Cdn. branch this box doesn't use.
FGLDBPATH=${VDXDIR}/etc
FGLRESOURCEPATH=${VDXFILES}/etc:${VDXDIR}/etc:${VDXDIR}/e/42s/en_US
FGLLDPATH=${VDXDIR}/e/42m:${VDXDIR}/e/lib

# Put the worktree's own etc/ ahead of whatever the shared script already
# appended, so 4JS resource lookups (.4st/.4tb) prefer this worktree.
DBPATH="${VDXDIR}/etc:${DBPATH}"

STG=${VDXDIR}/staging/src
STG_EXTRACT_PRG=${VDXDIR}/e/mre_tbl_extract.42r
IconDir="${VDXDIR}/etc/icons"

export VDXDIR BASEDIR BASEDIR_ACTIVE_LINK RUNTIME VERRUNTIME VDXPHP VDXSCRIPTS \
    RECORDS VERSONNEL RECDIR TERMCAP TERMINFO FGLDBPATH FGLRESOURCEPATH \
    FGLLDPATH DBPATH STG STG_EXTRACT_PRG IconDir

cd "${VDXDIR}" || return 1
