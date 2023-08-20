Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D0781C33
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 04:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjHTCwG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 22:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjHTCvy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 22:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730EC81831;
        Sat, 19 Aug 2023 18:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 076D961939;
        Sun, 20 Aug 2023 01:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FC2C433CA;
        Sun, 20 Aug 2023 01:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692495682;
        bh=8vJrg6bScgP7KMUHXJiLEWTyerH8jmKxylz1ghIm6LQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kA5YXM7kDOEphlJJ2ct6EUdud5KXpeKlqM5WCAFJMN1O4xUaPnp5cWMq8Z03mqT4H
         iVlI9VSEbYBCTy0S49s1P+Rw6I0C9zdtE+mBjLLwWS5DmuejAeU8gC685JBmNxWDIx
         yxpgfbeFSWmiyg8aiIR5/kemOx8zLpQRA+n8xhwXY59XmoCDd2nVhMbKneTcsqlNWp
         fcfBNg0xGOUqnA3sbb3fYZqyRSoBhu1QnlGYLEBpu+GWz7GLelFYNJsmKKk0kp1+8+
         slaZpsptNj1WqYtdKjtpa/hC/tn/snJw44inV608iiG+RBDE1wlW73lhwFAbGeVVJx
         pmMEXgAvZ9A1Q==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1c8be41e5efso1356962fac.3;
        Sat, 19 Aug 2023 18:41:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJopPoui7qeug0MH3YCMkYDk2zs6l0jAiAlsmhbJHan6o+Vbye
        yesb2ucl/5sG7c4+nNcyX73i/BVSBSScB75T+IA=
X-Google-Smtp-Source: AGHT+IG29AmKpf1Sid9m6LYfYuiXk8qrFeMM2FmYfu5NkRteGi4dD2h6nnzgPp0MYVohCvtPXI3kP4IllyUrurld9Dg=
X-Received: by 2002:a05:6870:8308:b0:1ba:3a7f:50eb with SMTP id
 p8-20020a056870830800b001ba3a7f50ebmr4107984oae.22.1692495681563; Sat, 19 Aug
 2023 18:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-6-arnd@kernel.org>
 <CAK7LNASuTOwHA0zz8MqxPdt5snMstpSY7==0o6kmU-RML3nioQ@mail.gmail.com>
In-Reply-To: <CAK7LNASuTOwHA0zz8MqxPdt5snMstpSY7==0o6kmU-RML3nioQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 10:40:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWu5otunZrgfgS+BLdUu9R853fBaiW-aVOhKER0F_57w@mail.gmail.com>
Message-ID: <CAK7LNASWu5otunZrgfgS+BLdUu9R853fBaiW-aVOhKER0F_57w@mail.gmail.com>
Subject: Re: [PATCH 5/9] extrawarn: enable format and stringop overflow
 warnings in W=1
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
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

On Sat, Aug 12, 2023 at 10:10=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Sat, Aug 12, 2023 at 10:50=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> =
wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The stringop and format warnings got disabled globally when they were
> > newly introduced in commit bd664f6b3e376 ("disable new gcc-7.1.1 warnin=
gs
> > for now"), 217c3e0196758 ("disable stringop truncation warnings for now=
")
> > and 5a76021c2eff7 ("gcc-10: disable 'stringop-overflow' warning for now=
").
> >
> > In all cases, the sentiment at the time was that the warnings are
> > useful, and we actually addressed a number of real bugs based on
> > them, but we never managed to eliminate them all because even the
> > build bots using W=3D1 builds only see the -Wstringop-truncation
> > warnings that are enabled at that level.
> >
> > Move these into the W=3D1 section to give them a larger build coverage
> > and actually eliminate them over time.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  scripts/Makefile.extrawarn | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> > index 87bfe153198f1..ec528972371fa 100644
> > --- a/scripts/Makefile.extrawarn
> > +++ b/scripts/Makefile.extrawarn
> > @@ -16,8 +16,6 @@ KBUILD_CFLAGS +=3D -Werror=3Dstrict-prototypes
> >  KBUILD_CFLAGS +=3D -Wno-format-security
> >  KBUILD_CFLAGS +=3D -Wno-trigraphs
> >  KBUILD_CFLAGS +=3D $(call cc-disable-warning,frame-address,)
> > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-truncation)
> > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-overflow)
> >  KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member=
)
> >
> >  ifneq ($(CONFIG_FRAME_WARN),0)
> > @@ -56,9 +54,6 @@ KBUILD_CFLAGS +=3D -Wno-pointer-sign
> >  # globally built with -Wcast-function-type.
> >  KBUILD_CFLAGS +=3D $(call cc-option, -Wcast-function-type)
> >
> > -# We'll want to enable this eventually, but it's not going away for 5.=
7 at least
> > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, stringop-overflow)
> > -
> >  # Another good warning that we'll want to enable eventually
> >  KBUILD_CFLAGS +=3D $(call cc-disable-warning, restrict)
> >
> > @@ -111,6 +106,9 @@ KBUILD_CFLAGS +=3D -Wmissing-include-dirs
> >  KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-but-set-variable)
> >  KBUILD_CFLAGS +=3D $(call cc-option, -Wunused-const-variable)
> >  KBUILD_CFLAGS +=3D $(call cc-option, -Wpacked-not-aligned)
> > +KBUILD_CFLAGS +=3D $(call cc-option, -Wformat-overflow)
> > +KBUILD_CFLAGS +=3D $(call cc-option, -Wformat-truncation)
>
>
> These are redundant because -Wall implies
> -Wformat-overflow and -Wformat-truncation
> according to the GCC manual.
>
>
>
>
> --
> Best Regards
> Masahiro Yamada


Applied  to linux-kbuild. Thanks.


--=20
Best Regards
Masahiro Yamada
