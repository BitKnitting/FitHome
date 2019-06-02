[Back to Readme](../README.md)
# Thanks to Those that went Before
- The [logging dart package](https://pub.dartlang.org/packages/logging).  While I don't understand everything going on in the code, I was delighted with how easy it was to customize log messages to include stack trace information.

# Logging
Logging is based on [this logging dart package](https://pub.dartlang.org/packages/logging).  
## Initialization
Initialization occurs in [main.dart](../lib/main.dart)

Two import files are added to main.dart for logging:  
```
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';  
```  
This code initializes how the log messages will print out.  
```
final Frame f = frames.skip(0).firstWhere((Frame f) =>
    f.library.toLowerCase().contains(rec.loggerName.toLowerCase()) &&
    f != frames.first);
```     
In this line of code, we're sifting through the stack frames, pulling out the one that contains the name of the dart file where the log message came from.  Once we have this glorious piece of info, we can send it to an output stream (in this case, our debug console):  
```
print('${rec.level.name}: ${f.member} (${rec.loggerName}:${f.line}): ${rec.message}');    
```
## Use
Each .dart that uses logging must include the following:  
```  
import 'package:logging/logging.dart';
```  
Then at the beginning of the class:  
```
Logger log = Logger('main_page.dart');  
```
_IMPORTANT_: The dart file name must be given so the stack trace will work.
_(Sadly, i couldn't find a similar library to Python's to get the name of the file the code is currently running)_

For example, I set up logging in the mqtt_stream.dart file:
```
log = Logger('mqtt_stream.dart');
```
Sprinkle:   
```
log.info('this is my log string');  
```
_Note: There are other levels than info...debug...perhaps error....I've been sprinkling info logs for now_
