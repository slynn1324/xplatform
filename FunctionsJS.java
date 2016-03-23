import javax.script.*;

class FunctionsJS {

	public static void main(String[] args) throws Exception {
		ScriptEngineManager factory = new ScriptEngineManager();
		ScriptEngine engine = factory.getEngineByName("javascript");
		engine.eval(new java.io.FileReader("functions.js"));

		Invocable inv = (Invocable) engine;

		System.out.println("add(2,3) => " + inv.invokeFunction("_add", 2, 3));
		System.out.println("add(3,5) => " + inv.invokeFunction("_add", 3, 5));

		Object msgPtr = inv.invokeFunction("_getMessage");
		System.out.println("getMessage() => " + inv.invokeFunction("Pointer_stringify", msgPtr));
	}
}

