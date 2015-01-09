use ElectricCommander ();
  my $ec = new ElectricCommander;
  $ec->setProperty ("/myJob/someOtherStatus", "complete indeed", {jobStepId => $ENV{COMMANDER_JOBSTEPID}})