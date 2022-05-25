Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3053410B
	for <lists+linux-arch@lfdr.de>; Wed, 25 May 2022 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiEYQIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiEYQIj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 12:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4EB2250;
        Wed, 25 May 2022 09:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618C9615E2;
        Wed, 25 May 2022 16:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CE4C34117;
        Wed, 25 May 2022 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653494917;
        bh=yKZpZ7SIZeLHb0X8nC5bqkpDaZyHuZo++7kw37oIcGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=goVP0r/5GwDlgxrUTVvx6jhaOtTm7pWUyfqhP1hgj2iDGXU4Tiq8pzDnwCvAkgpG4
         L1r86pR2gPdL9aCADSayVXaRv86iKfwqr3WFbWOZxdLnDhv1govZgITWE7RtDWiB5+
         LSjycCUndGv9y0jhBd0U8lb2tsEZKd0fEkC2wJsMf/1yO50v0Dzuq7GoqJ/s9pQejc
         wNgI7SjceSjeavb7oG9cfRxObqafmjEdCwDyFAraqlxbB1zYcaDbq+IRyVfomMK/KY
         bNjIBroLqZ8u1NSoR6dO+y5X61zbeNatpUa3EJ8SCurI9i1y8SKf6MZABNuUT5W2GC
         6go17gsxUHsuQ==
Received: by mail-vk1-f177.google.com with SMTP id i25so5151556vkr.8;
        Wed, 25 May 2022 09:08:37 -0700 (PDT)
X-Gm-Message-State: AOAM533v0pAJ28zdQU8hf2sK+UhmFZGXe9sdHuiU9EA2ZfVlmk3zruRk
        vHa6E66Wu59tSuKeVXx19GVavYor0eOIbeuf9Wc=
X-Google-Smtp-Source: ABdhPJw1WHHqxuzdMTtb2eEqwRRFtvXa8jU3vxrvtrww8g1vIS4KjJWMDyxFq63Hm2BXr071eyutBaZ38+UIdXynb6U=
X-Received: by 2002:a1f:2106:0:b0:357:a8c9:a8d6 with SMTP id
 h6-20020a1f2106000000b00357a8c9a8d6mr5907118vkh.2.1653494913806; Wed, 25 May
 2022 09:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144003.2357128-1-guoren@kernel.org> <20220524220646.GA3990738@roeck-us.net>
 <6435704.4vTCxPXJkl@diego> <3418219.V25eIC5XRa@diego>
In-Reply-To: <3418219.V25eIC5XRa@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 26 May 2022 00:08:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTkpHLZf-+VXZE_gCn=5ZJ5FS3jOxKLVoMyL4i=baPd7Q@mail.gmail.com>
Message-ID: <CAJF2gTTkpHLZf-+VXZE_gCn=5ZJ5FS3jOxKLVoMyL4i=baPd7Q@mail.gmail.com>
Subject: Re: [PATCH V9 20/20] riscv: compat: Add COMPAT Kbuild skeletal support
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Heiko & Guenter,

On Wed, May 25, 2022 at 7:10 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 25. Mai 2022, 12:57:30 CEST schrieb Heiko St=C3=BCbner:
> > Am Mittwoch, 25. Mai 2022, 00:06:46 CEST schrieb Guenter Roeck:
> > > On Wed, May 25, 2022 at 01:46:38AM +0800, Guo Ren wrote:
> > > [ ... ]
> > >
> > > > > The problem is come from "__dls3's vdso decode part in musl's
> > > > > ldso/dynlink.c". The ehdr->e_phnum & ehdr->e_phentsize are wrong.
> > > > >
> > > > > I think the root cause is from musl's implementation with the wro=
ng
> > > > > elf parser. I would fix that soon.
> > > > Not elf parser, it's "aux vector just past environ[]". I think I co=
uld
> > > > solve this, but anyone who could help dig in is welcome.
> > > >
> > >
> > > I am not sure I understand what you are saying here. Point is that my
> > > root file system, generated with musl a year or so ago, crashes with
> > > your patch set applied. That is a regression, even if there is a bug
> > > in musl.
Thx for the report, it's a valuable regression for riscv-compat.

> >
> > Also as I said in the other part of the thread, the rootfs seems innoce=
nt,
> > as my completely-standard Debian riscv64 rootfs is also affected.
> >
> > The merged version seems to be v12 [0] - not sure how we this discussio=
n
> > ended up in v9, but I just tested this revision in two variants:
> >
> > - v5.17 + this v9 -> works nicely
>
> I take that back ... now going back to that build I somehow also run into
> that issue here ... will investigate more.
Yeah, it's my fault. I've fixed up it, please have a try:

https://lore.kernel.org/linux-riscv/20220525160404.2930984-1-guoren@kernel.=
org/T/#u

>
>
> > - v5.18-rc6 + this v9 (rebased onto it) -> breaks the boot
> >   The only rebase-conflict was with the introduction of restartable
> >   sequences and removal of the tracehook include, but turning CONFIG_RS=
EQ
> >   off doesn't seem to affect the breakage.
> >
> > So it looks like something changed between 5.17 and 5.18 that causes th=
e issue.
> >
> >
> > Heiko
> >
> >
> > [0] https://lore.kernel.org/all/20220405071314.3225832-1-guoren@kernel.=
org/
> >
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
