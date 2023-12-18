(* FIXME: this should remove itself if the paclet has been uninstalled *)
PacletInstall[ "RickHennigan/ComputationalFitness", AllowVersionUpdate -> False ];
Needs[ "RickHennigan`ComputationalFitness`" -> None ];

(* FIXME:
    Import[ "file.fit" ] at the start of a session fails.
    It only works if Import[ ... "FIT" ] has evaluated first.
    Possible solution: Create a package file in $UserBaseDirectory/Autoload/ComputationalFitness/Kernel/init.m that
    registers the format. It should also remove itself if the paclet has been uninstalled.
*)