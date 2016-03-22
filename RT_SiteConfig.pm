Set($rtname, $ENV{RTNAME} || "rt.example.com" );
Set($Organization, $ENV{ORGANIZATION} || "rt.example.com" );
Set($OwnerEmail , $ENV{OWNER_EMAIL} || 'support@example.com');
Set($LogToSTDERR, $ENV{LOG_LEVEL} || "info" );
Set($Timezone, "UTC" );

Set($WebDomain, $ENV{WEBDOMAIN} || "localhost");
Set($WebPort, $ENV{WEBPORT} || "80");

Set($DatabaseType, "mysql" );
Set($DatabaseHost, $ENV{DATABASE_HOST} || "db" );
Set($DatabasePort, $ENV{DATABASE_PORT} || "" );
Set($DatabaseName, $ENV{DATABASE_NAME} || "rt4" );
Set($DatabaseUser, $ENV{DATABASE_USER} || "rt_user" );
Set($DatabasePassword, $ENV{DATABASE_PASSWORD} || "rt_pass" );
Set($DatabaseRTHost , $ENV{DATABASE_RT_HOST} || '%');

Plugin( "RT::Extension::ActivityReports" );
Plugin( "RT::Extension::ResetPassword" );
Plugin( "RT::Extension::MergeUsers" );
Plugin( "RT::Extension::SpawnLinkedTicketInQueue" );
Plugin( "RT::Extension::JSGantt" );

Plugin( "RT::Extension::CommandByMail" );
Set( @MailPlugins, qw(Auth::MailFrom Filter::TakeAction) );

Plugin( "RT::Extension::RepeatTicket" );
Set( $RepeatTicketCoexistentNumber, 1 );
Set( $RepeatTicketLeadTime, 14 );
Set( $RepeatTicketSubjectFormat, '__Subject__' );

Set( %FullTextSearch,
    Enable     => 0,
    Indexed    => 1,
    Column     => 'ContentIndex',
    Table      => 'Attachments',
);

1;
