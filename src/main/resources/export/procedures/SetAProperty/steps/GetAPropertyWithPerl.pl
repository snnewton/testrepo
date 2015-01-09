use ElectricCommander ();
  my $ec = new ElectricCommander;
  my $ecValue = $ec->getProperty("/myJob/someOtherStatus")->findvalue('//value')->value();
print $ecValue