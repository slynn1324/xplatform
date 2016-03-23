import javax.script.*;

ScriptEngineManager factory = new ScriptEngineManager();
ScriptEngine engine = factory.getEngineByName("javascript");
engine.eval(new java.io.FileReader("functions.js"));

Invocable inv = (Invocable) engine;

println("add(2,3) => " + inv.invokeFunction("_add", 2, 3));
println("add(3,5) => " + inv.invokeFunction("_add", 3, 5));

def msgPtr = inv.invokeFunction("_getMessage");
println("getMessage() => " + inv.invokeFunction("Pointer_stringify", msgPtr));