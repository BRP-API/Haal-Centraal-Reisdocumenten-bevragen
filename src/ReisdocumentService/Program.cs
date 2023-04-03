using FluentValidation;
using FluentValidation.AspNetCore;
using HaalCentraal.ReisdocumentService.Extensions;
using HaalCentraal.ReisdocumentService.Validators;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.MapControllers();

app.Run();
