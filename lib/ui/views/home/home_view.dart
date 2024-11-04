import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:minimal_app/ui/components/add_or_edit_client_modal.dart';
import 'package:minimal_app/ui/components/circle_filter.dart';
import 'package:minimal_app/ui/components/client_card.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          PositionedCircleFilter(
            positionedTop: -450,
            positionedLeft: -200,
            positionedWidth: MediaQuery.of(context).size.width * 0.8,
            positionedHeight: MediaQuery.of(context).size.height * 0.8,
            sigmaX: 50,
            sigmaY: 50,
            sizeHeight: 500,
            sizeWidth: 500,
          ),
          PositionedCircleFilter(
            positionedRight: -150,
            positionedHeight: MediaQuery.of(context).size.height * 0.9,
            sigmaX: 50,
            sigmaY: 50,
            sizeHeight: 250,
            sizeWidth: 250,
          ),
          PositionedCircleFilter(
            positionedBottom: -100,
            positionedLeft: -350,
            positionedWidth: MediaQuery.of(context).size.width * 0.8,
            sigmaX: 50,
            sigmaY: 50,
            sizeHeight: 300,
            sizeWidth: 300,
          ),
          const PositionedCircleFilter(
            positionedBottom: -200,
            positionedRight: -100,
            sigmaX: 200,
            sigmaY: 200,
            sizeHeight: 300,
            sizeWidth: 300,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48, left: 32, right: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Image.asset(
                  'assets/minimal_logo.png',
                  width: 128,
                  height: 54,
                ),
                const SizedBox(height: 26),
                const Text(
                  'CLIENTS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 11),
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        onChanged: viewModel.search,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddOrEditClientModal(
                              onSave: viewModel.createClient,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('ADD NEW'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: viewModel.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: viewModel.clients.length,
                          itemBuilder: (context, index) {
                            final client = viewModel.clients[index];
                            return ClientCard(
                              client: client,
                              onEdit: viewModel.editClient,
                              onDelete: viewModel.deleteClient,
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: ElevatedButton(
                      onPressed: viewModel.isBusy || !viewModel.hasMoreItems
                          ? null
                          : viewModel.onPageChanged,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('LOAD MORE'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
