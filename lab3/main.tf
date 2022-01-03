terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.0"
    }
  }
}

#terraform apply -var "webpage_version=v1.0.0"
variable "webpage_version" {
  type        = string
  description = "Release version of the webpage contained within the GIT Repository"
  default     = "v1.0.0"
  validation {
    #regex(...) fails if it cannot find a match (valid version example: v1.0.0)
    condition     = can(regex("(v[0-9]\\.[0-9]\\.[0-9])", var.webpage_version))
    error_message = "I cannot read a valid version for the webpage."
  }
}

resource "heroku_app" "nasapicoftheday" {
  name       = "nasapicoftheday"
  region     = "eu"
  buildpacks = [
    "heroku/php"
  ]
}

resource "heroku_build" "nasapicoftheday" {
  app        = heroku_app.nasapicoftheday.name

  source {
    url      = format("%s%s%s","https://github.com/gitperede/nasapicoftheday/releases/download/",var.webpage_version,"/nasapicoftheday.build.tar.gz")
  }
}
