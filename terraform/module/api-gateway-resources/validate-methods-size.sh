#!/bin/sh


if [ "$GET" -gt 1 ]; then
  echo ""
  echo "+-----------------------------------------------+"
  echo "| Method Get duplicated on methods Size: $GET"
  echo "+-----------------------------------------------+"
fi
if [ "$POST" -gt 1 ]; then
  echo ""
  echo "+-----------------------------------------------+"
  echo "| Method Post duplicated on methods Size: $POST"
  echo "+-----------------------------------------------+"
fi
if [ "$PATCH" -gt 1 ]; then
  echo ""
  echo "+-----------------------------------------------+"
  echo "| Method Patch duplicated on methods Size: $PATCH"
  echo "+-----------------------------------------------+"
fi
if [ "$DELETE" -gt 1 ]; then
  echo ""
  echo "+-----------------------------------------------+"
  echo "| Method Delete duplicated on methods Size: $DELETE"
  echo "+-----------------------------------------------+"
fi
if [ "$PUT" -gt 1 ]; then
  echo ""
  echo "+-----------------------------------------------+"
  echo "| Method Put duplicated on methods Size: $PUT"
  echo "+-----------------------------------------------+"
fi
if [ "$OPTION" -gt 1 ]; then
  echo ""
  echo "+-----------------------------------------------+"
  echo "| Method Option duplicated on methods Size: $OPTION"
  echo "+-----------------------------------------------+"
fi

if [ "$GET" -gt 1 ] || [ "$POST" -gt 1 ] || [ "$PATCH" -gt 1 ] || [ "$DELETE" -gt 1 ] || [ "$PUT" -gt 1 ] || [ "$OPTION" -gt 1 ]; then
  exit 1
fi



