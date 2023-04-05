#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/ReisdocumentProxy/ReisdocumentProxy.csproj", "src/ReisdocumentProxy/"]
RUN dotnet restore "src/ReisdocumentProxy/ReisdocumentProxy.csproj"
COPY . .
WORKDIR "/src/src/ReisdocumentProxy"
RUN dotnet build "ReisdocumentProxy.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ReisdocumentProxy.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ReisdocumentProxy.dll"]