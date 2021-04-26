// This example was summarized from http://www.playframework.org/documentation/1.2/validation and
// reproduced here for quick reference.

// To achieve model-level validations (versus handling at controller level), first annotate 
// the properties of the model.

package models;
 
public class User {
    
    @Required
    public String name;
 
    @Required
    @Min(0)
    public Integer age;
}

// Next, in the controller, specify that all properties must be valid.

public static void hello(@Valid User user) {
   if(validation.hasErrors()) {
       params.flash(); // add http parameters to the flash scope
       validation.keep(); // keep the errors for the next request
       index();
   }
   render(name, age);
}

// And the modified form...

#{ifErrors}
   <h1>Oops…</h1>
#{/ifErrors}
 
#{form @Application.hello()}
   <div>
      Name: <input type="text" name="user.name" value="${flash['user.name']}" />
      <span class="error">#{error 'user.name' /}</span>
   </div>
   <div>
      Age: <input type="text" name="user.age" value="${flash['user.age']}" /> 
      <span class="error">#{error 'user.age' /}</span>
   </div>
   <div>
      <input type="submit" value="Say hello" /> 
   </div>
#{/form}

