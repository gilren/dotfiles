#!/usr/bin/env bash
set -e

DISKS=$(lsblk -dn -o NAME,TYPE | awk '$2=="disk"{print $1}')

TEXT=""
TOOLTIP=""

for DISK in $DISKS; do

  if [[ "$DISK" == zram* ]]; then
    continue
  fi

  # largest partition
  PART=$(lsblk -rpo PATH,TYPE,SIZE -n "/dev/$DISK" |
    awk '$2=="part"{print $1, $3}' |
    sort -hk2 |
    tail -1 |
    awk '{print $1}')

  if [ -z "$PART" ]; then
    SIZE=$(lsblk -dn -o SIZE "/dev/$DISK")
    TOOLTIP+="<b>$DISK</b>  $SIZE (unmounted)\n"
    continue
  fi

  # LUKS/LVM mapper child of that partition
  MAPPER=$(lsblk -rpo PATH,TYPE -n "$PART" |
    awk '$2=="crypt" || $2=="lvm" {print $1; exit}')

  FS="${MAPPER:-$PART}"

  # df on the filesystem
  read USED TOTAL <<<$(df -B1 --output=used,size "$FS" | tail -1 | awk '{print $1, $2}')

  H_USED=$(numfmt --to=iec "$USED")
  H_TOTAL=$(numfmt --to=iec "$TOTAL")
  PERC=$((USED * 100 / TOTAL))

  TOOLTIP+="<b>$DISK</b> $H_USED / $H_TOTAL (${PERC}%)\n"
done

TEXT=$(df -h --output=pcent / | tail -1 | tr -s ' ')

echo -n "{\"text\":\"${TEXT## }\", \"tooltip\": \"${TOOLTIP%\\n}\"}"
