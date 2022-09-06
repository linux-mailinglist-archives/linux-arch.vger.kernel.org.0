Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC65AE3DF
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiIFJJX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiIFJJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 05:09:22 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5654B4A5;
        Tue,  6 Sep 2022 02:09:20 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28698i61023724;
        Tue, 6 Sep 2022 18:08:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28698i61023724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662455324;
        bh=R3PMwyCU9XVA+BiXnB3Ur5skrUwcficqvUv17oBbyNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yh0bG6cvaD4rETTtxz0JcrijEDFRXHTiBbdFdB5DxeVeQ6437m2l8P2aM80V8Fhjt
         8XaLJeJX2FIOsZv+AZJoGS0iOlqNq9RvwD5A9Mh87qGoY85d0Q5b1ewOsFcCVvMK+1
         74VXfwJmGORuUFktIqabbDCwjTgd0nNfe9vq+r5CjV8fpGtrHWOZzg+kQUT8OXl13o
         iqSN7KpGxwHq25ozD8cCPSItm1womvMbQLV7Uzqzf6i2R8JCTT1u101YOFdXkcJ6Rz
         X1+R1NsbFNmzhUEh2OygiGYsQLI3apkHawGL7t1UVLTAikCFnkrzfqqaFAnLTZBpiR
         fAMqZn6GGgqPQ==
X-Nifty-SrcIP: [209.85.160.47]
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1272fc7f51aso13315576fac.12;
        Tue, 06 Sep 2022 02:08:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo3dR4QXIChk/dt5Q+rFv4u+0rRo7PvjfF4XlYFD6duGdufWrNbv
        Ze8XIZXFXWJA/HXGNJOKkuQlLOzU9wHwLJSLrJc=
X-Google-Smtp-Source: AA6agR6OY4q6aKw+dcVMf+1HMS5Bz6jBUkf9aUWQi5PyQb2qypkWmtdG6+Qas8shnXJL81hfLNtBQMLJ68tsKioph7s=
X-Received: by 2002:a05:6808:90a:b0:34b:826c:6116 with SMTP id
 w10-20020a056808090a00b0034b826c6116mr4009247oih.194.1662455323387; Tue, 06
 Sep 2022 02:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-9-masahiroy@kernel.org> <f76020e2-e8bd-4f75-a697-3d6ec6665969@www.fastmail.com>
In-Reply-To: <f76020e2-e8bd-4f75-a697-3d6ec6665969@www.fastmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Sep 2022 18:08:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmaQYfQSSbu=1P9GtcRr6gFGEpPdUgaV0bOf3FdoLnhg@mail.gmail.com>
Message-ID: <CAK7LNASmaQYfQSSbu=1P9GtcRr6gFGEpPdUgaV0bOf3FdoLnhg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] kbuild: remove head-y syntax
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 6, 2022 at 5:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 6, 2022, at 8:13 AM, Masahiro Yamada wrote:
> > Kbuild puts the objects listed in head-y at the head of vmlinux.
> > Conventionally, we do this for head*.S, which contains the kernel entry
> > point.
> >
> > A counter approach is to control the section order by the linker script.
> > Actually, the code marked as __HEAD goes into the ".head.text" section,
> > which is placed before the normal ".text" section.
> >
> > I do not know if both of them are needed. From the build system
> > perspective, head-y is not mandatory. If you can achieve the proper code
> > placement by the linker script only, it would be cleaner.
> >
> > I collected the current head-y objects into head-object-list.txt. It is
> > a whitelist. My hope is it will be reduced in the long run.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> The scripts/head-object-list.txt approach feels a little awkward,
> so overall I'm not convinced that this is an improvement as long
> as there is no final decision for what should be done instead.
>
> If the .head.text section approach works, maybe convert at
> a minimum the x86 and arm64 architectures to provide an example
> of what it should look like in the end, otherwise I doubt that
> any architecture maintainers are going to work on removing their
> architectures from the head-object-list.txt file.



I wish I had done this before fa96b57c149061f71a70bd6582d995f6424fbbf4.
Maybe I would have been able to avoid loongarch adding a head-y.

When people port a new arch, they mimic other arch implementations,
and apparently they assume having head-y is mandatory, and the right
thing to do.

So, we need something to make arch maintainers realize
"when you add a new head-y entry, very likely you are doing wrong".

So, collecting the current ones into a whitelist can prevent the list
from growing at least, even if nobody strives to reduce it.


I did a similar approach for

  scripts/headers_install.sh
  usr/include/Makefile

It was successful because we did not get a new breakage.




Do you have a better idea to avoid bad code slipping in?




See the next arch port.


If somebody upsteams arch/kvx/, they will be very likely to add
arch/kvx/kernel/head.o to head-y.

They are already doing it.
https://github.com/kalray/linux_coolidge/blob/coolidge/arch/kvx/Makefile




People never re-think "why do we need head-y in the first place?"







>
> > +arch/alpha/kernel/head.o
> > +arch/arc/kernel/head.o
> > +arch/arm/kernel/head-nommu.o
> > +arch/arm/kernel/head.o
> > +arch/arm64/kernel/head.o
> > +arch/csky/kernel/head.o
> > +arch/hexagon/kernel/head.o
> > +arch/ia64/kernel/head.o
> > +arch/loongarch/kernel/head.o
> > +arch/m68k/68000/head.o
> > +arch/m68k/coldfire/head.o
> > +arch/m68k/kernel/head.o
> > +arch/m68k/kernel/sun3-head.o
> > +arch/microblaze/kernel/head.o
> > +arch/mips/kernel/head.o
> > +arch/nios2/kernel/head.o
> > +arch/openrisc/kernel/head.o
> > +arch/parisc/kernel/head.o
> > +arch/powerpc/kernel/head_40x.o
> > +arch/powerpc/kernel/head_44x.o
> > +arch/powerpc/kernel/head_64.o
> > +arch/powerpc/kernel/head_8xx.o
> > +arch/powerpc/kernel/head_book3s_32.o
> > +arch/powerpc/kernel/head_fsl_booke.o
> > +arch/powerpc/kernel/entry_64.o
> > +arch/powerpc/kernel/fpu.o
> > +arch/powerpc/kernel/vector.o
> > +arch/powerpc/kernel/prom_init.o
> > +arch/riscv/kernel/head.o
> > +arch/s390/kernel/head64.o
> > +arch/sh/kernel/head_32.o
> > +arch/sparc/kernel/head_32.o
> > +arch/sparc/kernel/head_64.o
> > +arch/x86/kernel/head_32.o
> > +arch/x86/kernel/head_64.o
> > +arch/x86/kernel/head32.o
> > +arch/x86/kernel/head64.o
> > +arch/x86/kernel/ebda.o
> > +arch/x86/kernel/platform-quirks.o
> > +arch/xtensa/kernel/head.o
>
> Seeing that almost all of these have the same naming
> convention, another alternative would be to have a
> special case exclusively for arch/*/kernel/head.S and
> make that either an assembly file that includes all
> the other files from your current list, or use
> an intermediate object to link head-*.o into head.o
> before putting that first.
>
>      Arnd


I prefer a simple list of objects, so that people
can work on it one by one.



As Ard pointed out, we can remove
arch/arm64/kernel/head.o
but it requires deep arch-specific knowledge.



-- 
Best Regards
Masahiro Yamada
