module Fission
  class Command
    class Stop < Command

      def initialize(args=[])
        super
      end

      def execute
        unless @args.count == 1
          Fission.ui.output self.class.help
          Fission.ui.output ""
          Fission.ui.output_and_exit "Incorrect arguments for stop command", 1
        end

        vm_name = @args.first

        unless Fission::VM.exists? vm_name
          Fission.ui.output_and_exit "Unable to find the VM #{vm_name} (#{Fission::VM.path(vm_name)})", 1 
        end

        unless VM.all_running.include?(vm_name)
          Fission.ui.output ''
          Fission.ui.output_and_exit "VM '#{vm_name}' is not running", 0
        end

        Fission.ui.output "Stopping '#{vm_name}'"
        @vm = Fission::VM.new vm_name
        @vm.stop
      end

      def option_parser
        optparse = OptionParser.new do |opts|
          opts.banner = "\nstop usage: fission stop vm"
        end

        optparse
      end

    end
  end
end
