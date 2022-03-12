{
  description = ''Simple variant generator empowering easy heterogeneous type operations'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sumtypes-master.flake = false;
  inputs.src-sumtypes-master.owner = "beef331";
  inputs.src-sumtypes-master.ref   = "refs/heads/master";
  inputs.src-sumtypes-master.repo  = "sumtypes";
  inputs.src-sumtypes-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sumtypes-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sumtypes-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}