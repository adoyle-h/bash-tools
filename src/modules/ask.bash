ask() {
  local msg=$*
  read -rp "$msg? ([Y]es/No)" answer
  case $answer in
    [Yy]* )
      echo YES
      ;;
    [Nn]* )
      echo NO
      ;;
    '')
      echo YES
      ;;
    *)
      echo Invalid Answer
      ;;
  esac

  return 0
}
