Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B750534796
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 02:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiEZAlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344960AbiEZAkL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 20:40:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243A8B0D20;
        Wed, 25 May 2022 17:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9B1FB81ECB;
        Thu, 26 May 2022 00:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6589DC34118;
        Thu, 26 May 2022 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653525607;
        bh=XbYpsC9yEq2qbfVcCMnpASOsc0x6dM1zetw0N7lzPwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OzeAYiRZdsB0yXNS0g4T0S862JWB2B/LUQvACOo5rMGE2n7o9TZvPB27hB71zz38y
         vo9jrOt3g7Uz6Ayo1wV41mp4/BSeoUVtantEuSKD5nAs/iu8jdCOVoUa11gVT2bdrc
         Te2G/7HFQTTP7+EIraOOvVasWY1jJOE6CNGvIfHnnTricGNK2En6oABwY37E52bEjy
         OerKaDd5ZbVw2Fhm6RTHF/WOyuj0HDTUusgZKY1QYwx5AzZBjQ/IDqX+0Q3Igt0ccj
         na8+zgUeTUqSTMCBGY8rJGZE3RXEGnIg6ufUHZKVlRoUxxV42EVxFThlBwDoaMNG68
         /qk7UI4Wse96g==
Received: by mail-vs1-f46.google.com with SMTP id m2so42228vsr.8;
        Wed, 25 May 2022 17:40:07 -0700 (PDT)
X-Gm-Message-State: AOAM532RKsjUwuddb79+sBVhEXiHohPcDMW74d3X2KG0MaN6lrjoT9g3
        0Z/QDjIXEC5X8ZaRZoq75Sl9tCpVobhk8FopS84=
X-Google-Smtp-Source: ABdhPJx0cJkHljwuAHpyaehwgqdzrKWDw6u17/hHUkJNA8qg9NggwxKoibBsRSciUSmCfyeKXeu5IRU/QTIMEigENhQ=
X-Received: by 2002:a67:c117:0:b0:337:a2ea:98e3 with SMTP id
 d23-20020a67c117000000b00337a2ea98e3mr8547786vsj.59.1653525606376; Wed, 25
 May 2022 17:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144003.2357128-1-guoren@kernel.org> <3418219.V25eIC5XRa@diego>
 <CAJF2gTTkpHLZf-+VXZE_gCn=5ZJ5FS3jOxKLVoMyL4i=baPd7Q@mail.gmail.com> <1766627.8hzESeGDPO@diego>
In-Reply-To: <1766627.8hzESeGDPO@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 26 May 2022 08:39:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRrrwDUOTqLDTxZLNnWM1LXEq4VFVB8jZPdYvnS2i0ung@mail.gmail.com>
Message-ID: <CAJF2gTRrrwDUOTqLDTxZLNnWM1LXEq4VFVB8jZPdYvnS2i0ung@mail.gmail.com>
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

On Thu, May 26, 2022 at 3:37 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 25. Mai 2022, 18:08:22 CEST schrieb Guo Ren:
> > Thx Heiko & Guenter,
> >
> > On Wed, May 25, 2022 at 7:10 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Am Mittwoch, 25. Mai 2022, 12:57:30 CEST schrieb Heiko St=C3=BCbner:
> > > > Am Mittwoch, 25. Mai 2022, 00:06:46 CEST schrieb Guenter Roeck:
> > > > > On Wed, May 25, 2022 at 01:46:38AM +0800, Guo Ren wrote:
> > > > > [ ... ]
> > > > >
> > > > > > > The problem is come from "__dls3's vdso decode part in musl's
> > > > > > > ldso/dynlink.c". The ehdr->e_phnum & ehdr->e_phentsize are wr=
ong.
> > > > > > >
> > > > > > > I think the root cause is from musl's implementation with the=
 wrong
> > > > > > > elf parser. I would fix that soon.
> > > > > > Not elf parser, it's "aux vector just past environ[]". I think =
I could
> > > > > > solve this, but anyone who could help dig in is welcome.
> > > > > >
> > > > >
> > > > > I am not sure I understand what you are saying here. Point is tha=
t my
> > > > > root file system, generated with musl a year or so ago, crashes w=
ith
> > > > > your patch set applied. That is a regression, even if there is a =
bug
> > > > > in musl.
> > Thx for the report, it's a valuable regression for riscv-compat.
> >
> > > >
> > > > Also as I said in the other part of the thread, the rootfs seems in=
nocent,
> > > > as my completely-standard Debian riscv64 rootfs is also affected.
> > > >
> > > > The merged version seems to be v12 [0] - not sure how we this discu=
ssion
> > > > ended up in v9, but I just tested this revision in two variants:
> > > >
> > > > - v5.17 + this v9 -> works nicely
> > >
> > > I take that back ... now going back to that build I somehow also run =
into
> > > that issue here ... will investigate more.
> > Yeah, it's my fault. I've fixed up it, please have a try:
> >
> > https://lore.kernel.org/linux-riscv/20220525160404.2930984-1-guoren@ker=
nel.org/T/#u
>
> very cool that you found the issue.
> I've tested your patch and it seems to fix the issue for me.
>
> Thanks for figuring out the cause
I should thx Guenter Roeck, It just surprised me that compat_vdso
could work with quite a lot of rv64 apps.

> Heiko
>
>
> > > > - v5.18-rc6 + this v9 (rebased onto it) -> breaks the boot
> > > >   The only rebase-conflict was with the introduction of restartable
> > > >   sequences and removal of the tracehook include, but turning CONFI=
G_RSEQ
> > > >   off doesn't seem to affect the breakage.
> > > >
> > > > So it looks like something changed between 5.17 and 5.18 that cause=
s the issue.
> > > >
> > > >
> > > > Heiko
> > > >
> > > >
> > > > [0] https://lore.kernel.org/all/20220405071314.3225832-1-guoren@ker=
nel.org/
> > > >
> > >
> > >
> > >
> > >
> >
> >
> >
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
