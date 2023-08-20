Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD4781C35
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 04:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHTCxA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 22:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjHTCwt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 22:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0074B80333;
        Sat, 19 Aug 2023 18:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9182E60AC7;
        Sun, 20 Aug 2023 01:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CC6C433CA;
        Sun, 20 Aug 2023 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692495549;
        bh=7KkQTCzUtOa5Qo72yntFLpX+VCeQORqMyNVamnhlfL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nTt+8iCwqIx7ac50IQATKWK04TK+IweFtOhC70xdXNX+2cwKVxrr+bncvEchd98jq
         pPG8R9RaRIfAgYFsURCbO2N+EO571YypXE2RBgcDEAJJkXb7+bQCWsqBtprRL4a68u
         qzYDb64W/xJHHq+tBwERwq4rsTQ1dVf30hyEpiY7sPBJ3712B1F6u0uyRr+DGUrPHi
         ieZKetwpMb1rYL5AZclw/oLSvXaDjkSemEFNCoF/2wrbS3lEGbj5FOf+JzpTUESpS0
         3tH+T7YqI43czknRYPWuefmAz8klnguul8eHPJnnwZlj1p7EGj7pyBWzs0Jbvp2+OL
         0+/bwg5KU5eGw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56c711a889dso1464606eaf.0;
        Sat, 19 Aug 2023 18:39:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJ65g2vhIboU1NIaOzLLPLFsaDNCeqmEGrZtlQmfhZH2I8Zq10
        TUePVrwjXKDhC4aQL13A6xYJ6TSa3e7/+CaWRxk=
X-Google-Smtp-Source: AGHT+IG2QhgwooldOsjv7TQTroLbJjd7yFanAK91+vM3CAD+CqE802hDxH9EuVVW73FillNAXUmRWM1fQodqiMDioS4=
X-Received: by 2002:a4a:245a:0:b0:56e:4ee2:9183 with SMTP id
 v26-20020a4a245a000000b0056e4ee29183mr4009011oov.1.1692495549230; Sat, 19 Aug
 2023 18:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-4-arnd@kernel.org>
 <CAK7LNAT0BZ107ngRNQvVO4DjOKj8AOrD2860rOgQ84WP9QfaFw@mail.gmail.com> <6574626d-3853-4ef5-a481-5c03894e4ba2@app.fastmail.com>
In-Reply-To: <6574626d-3853-4ef5-a481-5c03894e4ba2@app.fastmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 10:38:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmM9DjHu0gcyVAH1nCf0OVKMq52HvpHtYmCy9E8nKEvQ@mail.gmail.com>
Message-ID: <CAK7LNARmM9DjHu0gcyVAH1nCf0OVKMq52HvpHtYmCy9E8nKEvQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] Kbuild: avoid duplicate warning options
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 13, 2023 at 2:45=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sat, Aug 12, 2023, at 11:21, Masahiro Yamada wrote:
> > On Sat, Aug 12, 2023 at 5:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > GCC manual says -Wall implies -Wmaybe-uninitialized.
> >
> > If you move -Wno-maybe-uninitialize to the "W !=3D 2" part,
> > -Wmaybe-uninitialized is unneeded in the 'W =3D=3D 2" part.
> >
> > Maybe, the same applies to -Wunused-but-set-parameter.
> >
> > Shall we drop warnings implied by another, or
> > is it clearer to explicitly add either -Wfoo or -Wno-foo?
> >
> > If desired, we can do such a clean-up later, though.
>
> Right, we can probably drop that, I've gone back and forth
> on this how to handle these. Some of the warnings are
> handled differently between gcc and clang, or differently
> between compiler versions, where they are sometimes
> implied and sometimes need to be specified explicitly.
>
> What I've tried to do here is to do the change in the least
> invasive way to ensure that this larger patch does not
> change the behavior. My preference would be for you
> to merge it like this unless you see a bug, and then
> do another cleanup pass where we remove the ones implied
> by either -Wall or -Wextra on all known versions.
>
> I'll be on vacation the next few weeks starting on
> Tuesday and will be able to reply to emails, but won't
> have a chance to sufficiently test any significant
> reworks of my series before the merge window.
>
>     Arnd

Applied  to linux-kbuild. Thanks.

--=20
Best Regards
Masahiro Yamada
