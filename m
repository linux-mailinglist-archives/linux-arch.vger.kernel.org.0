Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E4781C21
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 04:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHTCn0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 22:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHTCnQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 22:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612656A5A;
        Sat, 19 Aug 2023 18:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A82618A9;
        Sun, 20 Aug 2023 01:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ACDC433CA;
        Sun, 20 Aug 2023 01:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692495414;
        bh=/6ZD3a1/w3AluyCxLOe7XB7yWBmEmhM8gGnVv/KNyZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ThQcXO/7mYy1X9qncCgUvkkvVv5Ju85HrVEzV3di6MSmEqD+9Wp8EL5LykSDB7/gk
         NxeDo7d2cX+aSaM2DrVG2yWeeRCJAt9A+h8uf58u7YBe/7EWWgiJXh6lPfI5049QSU
         pVdjqmUm6vefmBO9ijdwDfY7C6SXpWoEYdytcM5Bzf2OEfOQk1wci9OpmArMuZbjFF
         dQM+UJY1RXFyxiJwAElaD2sqwmfU2QEF9N2PeMkV93iVTIoxc9H64Db6BwgJPQoHAJ
         HJpuyxxbW08Ru3zYuXsLUsY4UNqY8tekTLS01tRM5kQL+fb10dizOprK3qqDfS3qbO
         rh/QJe4Gkrqcw==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6bc9c01e154so1771107a34.0;
        Sat, 19 Aug 2023 18:36:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwgNB37r791INtVTXebcbzh/DS8yHuP6awPEd3J/z0kSTGoczXl
        fPegI5UwilUfBgo+HoB6i3JVTLhhG6VUV1iwX0o=
X-Google-Smtp-Source: AGHT+IEwVUhK0RwZdjxGlE1oRin2YF1Cw37OsBCNvzSh0Zm9F619cPzMJ0iDdJ7YUFThp9pZW8tcI0S18VRm+VYrEl4=
X-Received: by 2002:a05:6808:219d:b0:3a4:1223:d224 with SMTP id
 be29-20020a056808219d00b003a41223d224mr2516859oib.21.1692495413538; Sat, 19
 Aug 2023 18:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-3-arnd@kernel.org>
 <20230811141943.GB3948268@dev-arch.thelio-3990X> <6e1c3faf-83f3-4627-bd74-42fea5b88dfb@app.fastmail.com>
In-Reply-To: <6e1c3faf-83f3-4627-bd74-42fea5b88dfb@app.fastmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 10:36:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT84H_dh25E3OywSHiM9z7TNgCymhHFA7yjUxgTjZgXvg@mail.gmail.com>
Message-ID: <CAK7LNAT84H_dh25E3OywSHiM9z7TNgCymhHFA7yjUxgTjZgXvg@mail.gmail.com>
Subject: Re: [PATCH 2/9] Kbuild: consolidate warning flags in scripts/Makefile.extrawarn
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 11:45=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Fri, Aug 11, 2023, at 16:19, Nathan Chancellor wrote:
> > On Fri, Aug 11, 2023 at 04:03:20PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Warning options are enabled and disabled in inconsistent ways and
> >> inconsistent locations. Start rearranging those by moving all options
> >> into Makefile.extrawarn.
> >>
> >> This should not change any behavior, but makes sure we can group them
> >> in a way that ensures that each warning that got temporarily disabled
> >> is turned back on at an appropriate W=3D1 level later on.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  Makefile                   | 88 -------------------------------------
> >>  scripts/Makefile.extrawarn | 90 +++++++++++++++++++++++++++++++++++++=
+
> >>  2 files changed, 90 insertions(+), 88 deletions(-)
> >
> > This shuffle seems reasonable to me. Would it make sense to rename the
> > Makefile from Makefile.extrawarn to just Makefile.warn or
> > Makefile.warnings? They are still "extra" warnings but to me, the
> > meaning of the Makefile is changing so it seems reasonable to drop the
> > "extra" part.
>
> Renaming the file seems fine, but I'd much prefer to do that separately
> if we decide to do it, otherwise rebasing my patches is going to
> be even more painful.
>
>      Arnd

Applied  to linux-kbuild. Thanks.


--=20
Best Regards
Masahiro Yamada
