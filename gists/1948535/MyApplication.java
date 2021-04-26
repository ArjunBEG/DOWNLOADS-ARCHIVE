package net.hockeyapp.android.demo;

import org.acra.ACRA;
import org.acra.annotation.ReportsCrashes;

import android.app.Application;

// Replace APP_ID with your App ID on HockeyApp
@ReportsCrashes(formKey="APP_ID")
public class MyApplication extends Application {
  @Override
  public void onCreate() {
    ACRA.init(this);
    ACRA.getErrorReporter().setReportSender(new HockeySender());

    super.onCreate();
  }
}
