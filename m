Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A7781732
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 05:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjHSDef (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 23:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHSDe1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 23:34:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBAF2D69;
        Fri, 18 Aug 2023 20:34:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so1905692a91.0;
        Fri, 18 Aug 2023 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692416065; x=1693020865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOjVxX/Eg0iGmCqhVv5cIZBql9TtO2CXYAj6O50hbSE=;
        b=IqtJwsF0pUQX7izyHeTreyTJTJhKy5hiG0L5LG7pklRm5ruz2z314lR30cJBIft8IF
         lHOgWqUBHxsrHRZ/n+H1wKK9DAmo6l6M6vOqnptgdlcjmAJVnPdA6vRI0gXUbNjLjw2O
         HaCa2GQWI2H3P/PJF/kO6bmYeR/Nyn9f2ZprmcA/D0k+kc6aE9gt4/58CgSA7F801jjd
         XX+T7G5Lv1/7anA6wENrFajkkBfdYnNLgzsdEjOaJ3u6npvNqyydM0GqNQ4HtJ58/8Bk
         W4eV1DvzXq38mo16H9W9Oyvm8s/Iciep4KukBQTEpuiauG6fJdSHO4J2dBeLWJsNSNRu
         GvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692416065; x=1693020865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOjVxX/Eg0iGmCqhVv5cIZBql9TtO2CXYAj6O50hbSE=;
        b=g1KtxvE6k2ycR/PXbMvrAE4SsFGN9yqylUPD6nf64K+NRp8T4HYEvaD2twXGbYGj8O
         BUllvDA3DBVugaxikS+mUlYfnUmo5NtGGtrHqkL5j57c3A39hFDuP/+Am5k5Dco71VRx
         K6laEUsdpU3LQzdzeVmU3hvTjHyuo58+15y31GjAo2dqddUKEqoN8y1B+wbjStUj6lJ3
         BAdwTYtspfvAZsn8hbmcL6mnGSBqRyqtK3cTuhVOyP1jTXpPa4X1gylTNZ0qz14SMv4n
         5d+3tnurMLTa0aPxa7IH7ueXAcIuREscGNe3sdE35deIA3Gv9wRW4dX2P40p9aFZ/atW
         TL+A==
X-Gm-Message-State: AOJu0YxclvNdQYlOy2KjW11+TXPsAeiQok/KBoWR8PxoGaIfUvknmWUP
        k23RYh3dHraJBipmUHAPOc5K1qei/PluQekxJ5M=
X-Google-Smtp-Source: AGHT+IFpp0VHvCZv9YQH2C6BH14eA1+BcCpaZ1w5QpKfP5/3cQ/4jDAUwPVhdHrKttxLAuvWHcInuMfoJccdrJLxiGs=
X-Received: by 2002:a17:90a:64ca:b0:25d:d224:9fb9 with SMTP id
 i10-20020a17090a64ca00b0025dd2249fb9mr1389535pjm.24.1692416065235; Fri, 18
 Aug 2023 20:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
 <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org> <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
In-Reply-To: <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
From:   Jesse T <mr.bossman075@gmail.com>
Date:   Fri, 18 Aug 2023 23:33:49 -0400
Message-ID: <CAJFTR8T-Fdu_aKapP+Lb6pLYo_ykXwXw6rFZNGR5=WKU1QwUPQ@mail.gmail.com>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 18, 2023 at 7:44=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi Jesse,
>
> I replied to your comment a few days ago, but for some reason
> your email to me contains:
> Reply-To: 20230816055010.31534-1-rdunlap@infradead.org
> so it wasn't sent directly to you.

Sorry about that I messed up the email headers...
>
> My former reply is below.
>
> On 8/16/23 20:15, Randy Dunlap wrote:
> > Hi Jesse,
> >
> > On 8/16/23 15:45, Jesse Taube wrote:
> >> Hi, Randy
> >>
> >>> diff -- a/init/Kconfig b/init/Kconfig
> >>> --- a/init/Kconfig
> >>> +++ b/init/Kconfig
> >>> @@ -1790,14 +1790,6 @@ config DEBUG_RSEQ
> >>>
> >>>         If unsure, say N.
> >>>
> >>> -config EMBEDDED
> >>> -    bool "Embedded system"
> >>> -    select EXPERT
> >>> -    help
> >>> -      This option should be enabled if compiling the kernel for
> >>> -      an embedded system so certain expert options are available
> >>> -      for configuration.
> >>
> >> Wouldn't removing this break many out of tree configs?
> >
> > I'm not familiar with out-of-tree configs.
> > Do you have some examples of some that use CONFIG_EMBEDDED?
> > (not distros)

Buildroot has a few.
It won't immediately break Buildroot and Yocto as they have a set version,
but it could be confusing for anyone updating the kernel.

> >
> >> Should there be a warning here to update change it instead of removal?
> >
> > kconfig doesn't have a warning mechanism AFAIK.
> > Do you have an idea of how this would work?

No, unfortunately. As you said without a warning it would be overlooked so
a change would not be necessary.

A possible solution is to check in a header file with:

#ifdef CONFIG_EMBEDDED
#warning "CONFIG_EMBEDDED has changed to CONFIG_EXPERT"
#endif

Does anyone else have an opinion on this?
Since kconfig doesn't have a warning mechanism the patch seems fine as is.

Thanks,
Jesse Taube
> >
> > We could make a smaller change to init/Kconfig, like so:
> >
> >  config EMBEDDED
> > -     bool "Embedded system"
> > +     bool "Embedded system (DEPRECATED)"
> >       select EXPERT
> >       help
> > -       This option should be enabled if compiling the kernel for
> > -       an embedded system so certain expert options are available
> > -       for configuration.
> > +       This option is being removed after Linux 6.6.
> > +       Use EXPERT instead of EMBEDDED.
> >
> > but there is no way to produce a warning message. I.e., even with this
> > change, the message will probably be overlooked.
> >
> > ---
> > ~Randy
>
> --
> ~Randy
