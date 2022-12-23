class CsvReportGeneratorJob
  include SuckerPunch::Job

  def perform(export_id)
    export = Export.find(export_id)
    csv_generator = CsvReportGeneratorService.new(export: export)
    csv_generator.generate
  end
end
