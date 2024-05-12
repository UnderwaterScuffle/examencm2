import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/providers/login_form_provider.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 30),
                    const LoginForm(),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, 'add_user'),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.indigo.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(const StadiumBorder()),
                          ),
                          child: const Text('No tienes una cuenta?, creala'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the next page
                            Navigator.pushNamed(context, 'home');
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.indigo.withOpacity(0.1)),
                            shape: MaterialStateProperty.all(const StadiumBorder()),
                          ),
                          child: const Text('Skip Login'), // Button Text
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Form(
      key: loginFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icon(Icons.people),
            ),
            onChanged: (value) => loginFormProvider.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: '************',
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            onChanged: (value) => loginFormProvider.password = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'La contraseña no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.orange,
            elevation: 0,
            onPressed: loginFormProvider.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!loginFormProvider.isValidForm()) return;
                    loginFormProvider.isLoading = true;
                    final String? errorMessage = await authService.login(
                        loginFormProvider.email, loginFormProvider.password);
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'home');
                    } else {
                      print(errorMessage);
                    }
                    loginFormProvider.isLoading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
