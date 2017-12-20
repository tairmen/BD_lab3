from django.db import models
 
class cities(models.Model):
	id = models.IntegerField(primary_key = True)
	city = models.CharField(max_length=40)
	country = models.CharField(max_length=40)
	population = models.BigIntegerField()
 
	def __str__(self):
		return self.id
 
class travels(models.Model):
	id = models.IntegerField(primary_key = True)
	city_id = models.ForeignKey(cities)
	date1 = models.DateField()
	date2 = models.DateField()
 
	def __str__(self):
		return self.id