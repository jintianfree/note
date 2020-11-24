In your Application class, find or create the onCreate method. Add the following code to initialize the Adjust SDK:
```

import com.adjust.sdk.Adjust;
import com.adjust.sdk.AdjustConfig;

public class GlobalApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        String appToken = "{YourAppToken}";
        String environment = AdjustConfig.ENVIRONMENT_SANDBOX;
        AdjustConfig config = new AdjustConfig(this, appToken, environment);
        Adjust.onCreate(config);
    }
}
```