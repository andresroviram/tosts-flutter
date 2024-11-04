import 'package:flutter/material.dart';
import 'package:minimal_app/app/app.router.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/core/utils/helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:minimal_app/ui/components/circle_filter.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => Overlay.of(context).insert(viewModel.loader));
        } else {
          if (viewModel.loader.mounted) viewModel.loader.remove();
        }

        viewModel.addListener(() {
          if (viewModel.user?.accessToken?.isNotEmpty ?? false) {
            viewModel.navigationService.replaceWithHomeView();
          }
        });

        viewModel.addListener(() {
          if (viewModel.failure != null) {
            ShowFailure.instance.mapFailuresToNotification(
              context,
              failure: viewModel.failure ?? const AnotherFailure(),
            );
            viewModel.resetFailure();
          }
        });

        return Scaffold(
          body: Stack(
            children: [
              PositionedCircleFilter(
                positionedTop: -250,
                positionedRight: -150,
                positionedWidth: MediaQuery.of(context).size.width * 0.8,
                positionedHeight: MediaQuery.of(context).size.height * 0.8,
                sigmaX: 80,
                sigmaY: 80,
                sizeHeight: 500,
                sizeWidth: 500,
              ),
              PositionedCircleFilter(
                positionedBottom: -450,
                positionedRight: 40,
                positionedLeft: 20,
                positionedHeight: MediaQuery.of(context).size.height * 0.6,
                sigmaX: 100,
                sigmaY: 100,
                sizeHeight: 500,
                sizeWidth: 500,
              ),
              PositionedCircleFilter(
                positionedLeft: -40,
                positionedHeight: MediaQuery.of(context).size.height / 0.9,
                sigmaX: 40,
                sigmaY: 40,
                sizeHeight: 80,
                sizeWidth: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/minimal_logo.png',
                      width: 282,
                      height: 118,
                    ),
                    const SizedBox(height: 59),
                    const Text(
                      'LOG IN',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: viewModel.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Mail',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: viewModel.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => viewModel.toggleObscured(),
                        ),
                      ),
                      obscureText: viewModel.isObscured,
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('LOG IN'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }

  // @override
  // LoginViewModel viewModelBuilder(
  //   BuildContext context,
  // ) =>
  //     LoginViewModel();
}
