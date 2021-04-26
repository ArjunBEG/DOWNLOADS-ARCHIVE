final Agent agent = new Agent.Iterative(
  new Array<Agent>(
    new Understands(
      this.github,
      new QnSince(
        49092213,
        new QnReferredTo(
          this.github.users().self().login(),
          new QnParametrized(
            new Question.FirstOf(
              new Array<Question>(
                new QnIfContains("config", new QnConfig(profile)),
                new QnIfContains("status", new QnStatus(talk)),
                new QnIfContains("version", new QnVersion()),
                new QnIfContains("hello", new QnHello()),
                new QnIfCollaborator(
                  new QnAlone(
                    talk, locks,
                    new Question.FirstOf(
                      new Array<Question>(
                        new QnIfContains(
                          "merge",
                          new QnAskedBy(
                            profile,
                            Agents.commanders("merge"),
                            new QnMerge()
                          )
                        ),
                        new QnIfContains(
                          "deploy",
                          new QnAskedBy(
                            profile,
                            Agents.commanders("deploy"),
                            new QnDeploy()
                          )
                        ),
                        new QnIfContains(
                          "release",
                          new QnAskedBy(
                            profile,
                            Agents.commanders("release"),
                            new QnRelease()
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    ),
    new StartsRequest(profile),
    new RegistersShell(
      "b1.rultor.com", 22,
      "rultor",
      IOUtils.toString(
        this.getClass().getResourceAsStream("rultor.key"),
        CharEncoding.UTF_8
      )
    ),
    new StartsDaemon(profile),
    new KillsDaemon(TimeUnit.HOURS.toMinutes(2L)),
    new EndsDaemon(),
    new EndsRequest(),
    new Tweets(
      this.github,
      new OAuthTwitter(
        Manifests.read("Rultor-TwitterKey"),
        Manifests.read("Rultor-TwitterSecret"),
        Manifests.read("Rultor-TwitterToken"),
        Manifests.read("Rultor-TwitterTokenSecret")
      )
    ),
    new CommentsTag(this.github),
    new Reports(this.github),
    new RemovesShell(),
    new ArchivesDaemon(
      new ReRegion(
        new Region.Simple(
          Manifests.read("Rultor-S3Key"),
          Manifests.read("Rultor-S3Secret")
        )
      ).bucket(Manifests.read("Rultor-S3Bucket"))
    ),
    new Publishes(profile)
  )
);
