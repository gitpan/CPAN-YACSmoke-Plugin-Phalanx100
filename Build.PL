use Module::Build;

my $build = Module::Build->new
    (
     module_name => 'CPAN::YACSmoke::Plugin::Phalanx100',
     license => 'perl',
     requires => {
       'perl'                       => '5.6.1',
       'CPAN::YACSmoke'             => 0.03,
       'CPANPLUS::Backend'          => 0,
       'Module::Phalanx100'         => 0.04,
     },
     recommends => {
       'Test::Pod'                  => 1.00,
       'Test::Pod::Coverage'        => 0,
     },
     build_requires => {
       'Test::More'                 => 0,
     },
     create_makefile_pl => 'traditional',
     create_readme      => 1,
     dist_author        => 'Robert Rothenberg <rrwo at cpan.org>',
     sign               => 1,
);

$build->create_build_script;
