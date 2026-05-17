import 'package:ecommere2/data/cubit/termsCubit.dart';
import 'package:ecommere2/data/status/termsStatus.dart';
import 'package:ecommere2/logic/cache/termsCache.dart';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:ecommere2/logic/gettingData/getTerms.dart';
import 'package:ecommere2/shimmer/termsShimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TermsCubit(
        repository: TermsRepository(TermsCache()),
        internetChecker: InternetChecker(),
      )..getTerms(),
      child: Scaffold(
        appBar: AppBar(
        ),
        body: BlocBuilder<TermsCubit, TermsState>(
          builder: (context, state) {

            if (state is TermsLoading) {
              return TermsShimmer();
            }

            if (state is TermsLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Html(
                    data: state.data,
                    style: {
                      "*": Style(color: Colors.black),
                      "body": Style(
                        color: Colors.black,
                        fontSize: FontSize(18),
                      ),
                    },
                  ),
                ),
              );
            }

            if (state is TermsOfflineLoaded) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    color: Colors.orange.shade100,
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

            if (state is TermsNoInternet) {
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
                        context.read<TermsCubit>().getTerms();
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (state is TermsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error: ${state.message}"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TermsCubit>().getTerms();
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