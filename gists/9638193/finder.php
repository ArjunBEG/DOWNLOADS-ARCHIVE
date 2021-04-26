class Code {
  private Option[] options;
  ctor(Option[] opts) {
    this.options = opts;
  }
  public get() {
    Result result = null;
    for (opt in this.options) {
      if (opt.matches()) {
        result = opt.get();
        break;
      }
    }
    if (result == null) {
      throw "Nothing found";
    }
    return result;
  }
}

class FirstOption {
  public matches() {
    // return true if it is found
  }
  public get() {
    // do some search and return
  }
}

class SecondOption {
  public matches() {
    // return true if it is found
  }
  public get() {
    // do some search and return
  }
}

Result result = new Code([new FirstOption(), new SecondOption()]).get();