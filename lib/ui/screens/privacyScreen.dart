import 'package:ecommere2/data/cubit/privacyCubit.dart';
import 'package:ecommere2/data/status/privacyStatus.dart';
import 'package:ecommere2/logic/cache/privacyCache.dart';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:ecommere2/logic/gettingData/getPrivacy.dart';
import 'package:ecommere2/shimmer/privacyShimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrivacyCubit(
        repository: PrivacyRepository(PrivacyCache()),
        internetChecker: InternetChecker(),
      )..getPrivacy(),
      child: Scaffold(
        appBar: AppBar(
          
        ),
        body: BlocBuilder<PrivacyCubit, PrivacyState>(
          builder: (context, state) {

            if (state is PrivacyLoading) {
              return PrivacyShimmer();
            }

            if (state is PrivacyLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Html(
                  data: state.data,
                  style: {
                    "*": Style(
                      color: Colors.black,
                    ),
                    "body": Style(
                      color: Colors.black,
                      fontSize: FontSize(16),
                    ),
                  },
                ),
              );
            }

            if (state is PrivacyOfflineLoaded) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.orange.shade100,
                    padding: const EdgeInsets.all(10),
                    child: const Text("Offline Mode - Cached Data"),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Html(
                        data: state.data,
                        style: {
                          "*": Style(color: Colors.black),
                          "body": Style(color: Colors.black),
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is PrivacyNoInternet) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 50),
                    const SizedBox(height: 10),
                    const Text("No Internet Connection"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PrivacyCubit>().getPrivacy();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (state is PrivacyError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PrivacyCubit>().getPrivacy();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}