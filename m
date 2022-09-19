Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301F95BCBA2
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiISMSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 08:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISMSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 08:18:30 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE511DF16;
        Mon, 19 Sep 2022 05:18:25 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 28JCHxhu019959;
        Mon, 19 Sep 2022 21:17:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 28JCHxhu019959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663589879;
        bh=8aWuQLPgUjO2hHTxhxUtJFCPMusYzMKoXSzZIe6HxdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ruc0JgvNiI9SIk8G1CCrirmc/BevOwTVD5nwrpVJek1jkSh9INKB9qpO3wo2l7cVg
         +/HVuWbF4Jll7/WmujvHpc839rhzH0CAZ3ygAu6EIE7tTWAu3xcRVO3mIDZ94Pj6SA
         W6ZpGMelTdbRKoM7YnUMw454UbPWeirRHJsCEEJ04m5cCqbVHDeBC9wSIt9UB+g/Rg
         211LNQ9Lv64NKMXnxt8esFQtg5BThox4qLz077yKC+4+UbAGztH5gfL255ZtI38agi
         CgYlFqqSwXwiAg9vXfggOkawPPllKTGRnw7zOzjkkbagcYIBohhrgxUA3GuB8gra+K
         3YNdQsnoiYuGw==
X-Nifty-SrcIP: [209.85.167.169]
Received: by mail-oi1-f169.google.com with SMTP id o64so481537oib.12;
        Mon, 19 Sep 2022 05:17:59 -0700 (PDT)
X-Gm-Message-State: ACgBeo0eFjwET1EXIN+OIii/ZEfiA6zh7qNX250ti+Sm1mIDOgrBw3BG
        P2hFb1Eb/P4juNCbjkcn4GDIiJkHEuFk1HBCCb4=
X-Google-Smtp-Source: AA6agR5fCHiLt8KV0h3AaofSngs2QdHWjXGKyrzvVJlIx/iHDXkG8XPEuzGsNgncjjO04CTaMIj0HVFHj810SyI0/Zk=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr11850446oib.194.1663589878451; Mon, 19
 Sep 2022 05:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-8-masahiroy@kernel.org> <CAMuHMdUpY92WGNqTOV0-jaB+q1q0nS4wxkhrC8jb-uGU9KbogQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUpY92WGNqTOV0-jaB+q1q0nS4wxkhrC8jb-uGU9KbogQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 19 Sep 2022 21:17:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqy4DCAB2LuK7dpiYDjRciXHE_E6gAvHHfvYAfe9CqGg@mail.gmail.com>
Message-ID: <CAK7LNATqy4DCAB2LuK7dpiYDjRciXHE_E6gAvHHfvYAfe9CqGg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] kbuild: use obj-y instead extra-y for objects
 placed at the head
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 19, 2022 at 5:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Yamada-san,
>
> On Tue, Sep 6, 2022 at 8:15 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > The objects placed at the head of vmlinux need special treatments:
> >
> >  - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
> >    them before other archives in the linker command line.
> >
> >  - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
> >    obj-y to avoid them going into built-in.a.
> >
> > This commit gets rid of the latter.
> >
> > Create vmlinux.a to collect all the objects that are unconditionally
> > linked to vmlinux. The objects listed in head-y are moved to the head
> > of vmlinux.a by using 'ar m'.
> >
> > With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
> > for builtin objects.
> >
> > There is no *.o that is directly linked to vmlinux. Drop unneeded code
> > in scripts/clang-tools/gen_compile_commands.py.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>




Thanks for the report.

I will squash the following:



diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index 1755e6cd309f..af015447dfb4 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_SUN3X)   := head.o
 obj-$(CONFIG_VIRT)     := head.o
 obj-$(CONFIG_SUN3)     := sun3-head.o

-obj-y  := entry.o irq.o module.o process.o ptrace.o
+obj-y  += entry.o irq.o module.o process.o ptrace.o
 obj-y  += setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o

 obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o












--
Best Regards
Masahiro Yamada
