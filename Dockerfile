ARG SERVICE

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-stage
ARG SERVICE

COPY . .

WORKDIR /src/${SERVICE}

RUN dotnet restore && dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
ARG SERVICE

WORKDIR /${SERVICE}

COPY --from=build-stage /src/${SERVICE}/out .
ENTRYPOINT [ "dotnet", "${SERVICE}.dll" ]
