FROM bash

LABEL version="1.0.1"
LABEL repository="http://github.com/ianwremmel/prevent-nopush-commits"
LABEL homepage="http://github.com/ianwremmel/prevent-nopush-commits"
LABEL maintainer="Ian Remmel <1182361+ianwremmel@users.noreply.github.com>"

LABEL com.github.actions.name="Prevent nopush commits"
LABEL com.github.actions.description="Prevents you from merging nopush commits into master."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="red"

RUN apk add git

COPY LICENSE README.md /

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["entrypoint.sh"]