{
  description = "A minimal NixOS flake";

  inputs = {
    # La entrada principal: el conjunto de expresiones y paquetes de Nix.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
  };

  outputs = { self, nixpkgs, ... }: {
    # 1. Configuraciones del Sistema NixOS
    # Define una configuración de NixOS llamada 'nixos'. 
    # Sustituye 'tu-hostname' por el nombre de tu máquina.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # O "aarch64-linux", dependiendo de tu arquitectura.
      
      modules = [
        # Importa el módulo de configuración base de NixOS (obligatorio).
        ./configuration.nix 
        
        # Opcional: Define módulos específicos aquí si no usas configuration.nix para todo.
      ];
    };

    # 2. Paquetes para otras plataformas (opcional pero bueno para la estructura)
    # Proporciona un conjunto de paquetes que pueden ser instalados con 'nix profile install flake#paquete'.
    packages.x86_64-linux = import nixpkgs {
      system = "x86_64-linux";
      config = { allowUnfree = true; }; # Permite paquetes no libres si es necesario
    };
    
    # Define paquetes específicos aquí si quieres que tu flake compile y exporte software.
    # Ejemplo:
    # defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello; 
  };
}
