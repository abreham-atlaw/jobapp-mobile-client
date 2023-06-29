import 'package:jobapp/apps/core/data/requests/job_requests.dart';
import 'package:jobapp/apps/core/di/core_providers.dart';
import 'package:jobapp/lib/network/network_client.dart';
import 'package:jobapp/lib/network/request.dart';

import '../models/job.dart';

class JobRepository {
  Future<NetworkClient> get _networkClient async {
    return await CoreProviders.provideAuthenticatedNetworkClient();
  }

  Future<List<Job>> search(String query) async {
    return (await _networkClient).execute(SearchJobRequest(query));
  }

  Future<List<Job>> listJobs(Location searchLocation) async {
    return (await _networkClient)
        .execute(ListJobsRequest(location: searchLocation));
  }

  Future<Job> acceptJob(Job job) async {
    return await (await _networkClient).execute(AcceptJobRequest(job));
  }

  Future<Job?> getCurrentSession() async {
    try {
      return await (await _networkClient).execute(GetSessionRequest());
    } catch (ex) {
      if (ex is! ApiException || ex.statusCode != 404) {
        rethrow;
      }
      return null;
    }
  }
}
