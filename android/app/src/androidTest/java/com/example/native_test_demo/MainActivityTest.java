package com.example.native_test_demo;

import static androidx.test.espresso.flutter.EspressoFlutter.onFlutterWidget;
import static androidx.test.espresso.flutter.action.FlutterActions.click;
import static androidx.test.espresso.flutter.assertion.FlutterAssertions.matches;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withText;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withTooltip;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withValueKey;

import android.app.Instrumentation;

import androidx.test.core.app.ActivityScenario;
import androidx.test.espresso.flutter.assertion.FlutterAssertions;
import androidx.test.espresso.flutter.matcher.FlutterMatchers;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.platform.app.InstrumentationRegistry;
import androidx.test.uiautomator.UiDevice;
import androidx.test.uiautomator.UiObject;
import androidx.test.uiautomator.UiObjectNotFoundException;
import androidx.test.uiautomator.UiSelector;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

@RunWith(AndroidJUnit4.class)
public class MainActivityTest {

    @Before
    public void setUp() {
        ActivityScenario.launch(MainActivity.class);
    }

    @Test
    public void performClick() {
        onFlutterWidget(withTooltip("Increment")).perform(click());
        onFlutterWidget(withValueKey("CountText")).check(matches(withText("Button tapped 1 time.")));
    }

    @Test
    public void getCurrentLocation() throws UiObjectNotFoundException, InterruptedException {
        onFlutterWidget(withValueKey("geolocation_page_button")).perform(click());

        onFlutterWidget(withValueKey("get_current_position_button")).check(FlutterAssertions.matches(FlutterMatchers.isExisting()));
        onFlutterWidget(withValueKey("get_current_position_button")).perform(click());

        grantPermission();
        Thread.sleep(2 * 1000);
        onFlutterWidget(withValueKey("current_position_text")).check(matches(withText("Current location: 45.5016883, -73.567255")));
    }

    private void grantPermission() throws UiObjectNotFoundException {
        Instrumentation instrumentation = InstrumentationRegistry.getInstrumentation();
        UiObject allowPermission = UiDevice.getInstance(instrumentation).findObject(new UiSelector().text("While using the app"));
        if (allowPermission.exists()) {
            allowPermission.click();
        }
    }
}