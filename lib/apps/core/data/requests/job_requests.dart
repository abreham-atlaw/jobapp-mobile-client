import 'package:flutter/widgets.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/data/serializers/job_serializer.dart';
import 'package:jobapp/lib/network/request.dart';

JobSerializer _serializer = JobSerializer();

class GetJobByIdRequest extends Request {
  GetJobByIdRequest(super.url);

  @override
  deserializeObject(response) {}
}

class SearchJobRequest extends Request<List<Job>> {
  SearchJobRequest(String query)
      : super("/worker/search/",
            getParams: {"query": query}, method: Method.get);

  @override
  List<Job> deserializeObject(response) {
    return _serializer.deserializeMany(response);
  }
}

class ListJobsRequest extends Request<List<Job>> {
  ListJobsRequest({double? radius, Location? location})
      : super("/worker/jobs/",
            getParams: {
              "latitude": location?.latitude.toString(),
              "longitude": location?.longitude.toString(),
            },
            method: Method.get);

  @override
  List<Job> deserializeObject(response) {
    return _serializer.deserializeMany(response);
  }
}

class AcceptJobRequest extends Request<Job> {
  AcceptJobRequest(Job job)
      : super("/worker/job/accept/",
            postParams: {"job_id": job.id}, method: Method.post);

  @override
  Job deserializeObject(response) {
    return _serializer.deserialize(response);
  }
}

class GetSessionRequest extends Request<Job> {
  GetSessionRequest() : super("/worker/session/", method: Method.get);

  @override
  Job deserializeObject(response) {
    return _serializer.deserialize(response);
  }
}
