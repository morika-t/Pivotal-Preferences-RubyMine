module MinePrefs
  module Commands
    module Backups
      class Backup
        attr_reader :filesystem

        def initialize(filesystem: MinePrefs::FileUtils.new)
          @filesystem = filesystem
        end

        def execute(installation_bundle)
          installation_bundle.each do |file|
            source = file.target
            destination = MinePrefs::Commands::Backups::BackupPathname.new(source)

            filesystem.mv(source, destination)
          end
        end

        def undo(installation_bundle)
          installation_bundle.each do |file|
            destination = file.target
            source = MinePrefs::Commands::Backups::BackupPathname.new(destination)

            filesystem.mv(source, destination)
          end
        end
      end
    end
  end
end
