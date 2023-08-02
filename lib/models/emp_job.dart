// @dart=2.9

class Emp_job {
  int _id;
  String _name;
  int _job_id;
  String _job_name;

  String get job_name => _job_name;

  String get name => _name;
  int get job_id => _job_id;

  int get id => _id;

  Emp_job({
    int id,
    String name,int jobId,String jobName}) {
    _id = id;
    _name = name;
    _job_id=jobId;
    _job_name = jobName;
  }

  Emp_job.fromJson(dynamic map) {
    _id = map['id'] ;
    _name =  map['name'];
    _job_name = map['job_position'] ;
    _job_id =  map['job_id'];

  }

}
