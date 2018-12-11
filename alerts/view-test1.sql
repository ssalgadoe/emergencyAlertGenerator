SELECT 
  alertsource.name, 
  alertsource.url, 
  classificationtype.name, 
  languagetype.name, 
  sourcetype.name, 
  alertsource.trustlevel, 
  alertsource.id
FROM 
  public.alertsource, 
  public.classificationtype, 
  public.sourcetype, 
  public.languagetype
WHERE 
  alertsource.classificationid = classificationtype.id AND
  alertsource.sourcetypeid = sourcetype.id AND
  alertsource.languageid = languagetype.id;
