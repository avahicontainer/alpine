variable "ALPINE_VERSION" { default = "latest" }
variable "S6_OVERLAY_VERSION" { default = "v3.2.0.0" }

target "docker-metadata-action" {}
target "github-metadata-action" {}

target "default" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64"
    ]
}
target "dev" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
    }
    tags = [
        "avahicontainer/alpine:dev"
    ]
}
