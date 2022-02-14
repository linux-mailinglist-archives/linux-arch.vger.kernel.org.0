Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE894B5C88
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiBNVVU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 16:21:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBNVVT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 16:21:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0927913C390;
        Mon, 14 Feb 2022 13:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E93F6111F;
        Mon, 14 Feb 2022 19:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8984C340F4;
        Mon, 14 Feb 2022 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644866741;
        bh=zLWY4rc6tKJzkfOHU66+tSLIxceIVdBozj8MWHl9tz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dahbLYzx2Cck5kbI+J06pUjtONQgq4wac0B/zMHO2t8H4+atEXbbC3nQoEeMZmjvT
         itq7QzJ+hcqJRhHre9S0Rv1ba7ESMo4l9io+gmxznvUC35vP0sSOIkYlCR+0otG3GN
         tdNTUG6Qu0hKopOLGNe9r6lsk3LXktZTgdyM6DDF4qnI4CaboAovPMzaA5UAbOEp8B
         APnMM/NoSUEX7k/TbfFZOMIAXqeOgVfYlaUUwS5IVx/KX2WaZSUcXBZdLbU9c3dXWc
         B7yscltnO9vN4AE6rtNUxs37L8HmCFQQ4zLTncxcS+Y4byxc1hWLvKupRncU1kUVIh
         Se79TuvvAK7PA==
Received: by mail-wr1-f41.google.com with SMTP id e3so28621725wra.0;
        Mon, 14 Feb 2022 11:25:41 -0800 (PST)
X-Gm-Message-State: AOAM533lGBGdzQ2n4n/+tiFsDCW6M+1s0S1dxwkv7EnqcNwoNPD/D0To
        g73TG23bEoHghzGuOFucaeUtVTcCMiOXD2j8fXA=
X-Google-Smtp-Source: ABdhPJwrOpkav7UeztG9pweW7/OWsS+hZNYg7RZgUDmgoSoPSixwWLgUERuof4XivnroH6SdfUIEp08YoMpfbv7qa3w=
X-Received: by 2002:a5d:5446:: with SMTP id w6mr422520wrv.12.1644866740020;
 Mon, 14 Feb 2022 11:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-8-arnd@kernel.org>
 <YgqOLZbFK7/B2HJT@zeniv-ca.linux.org.uk>
In-Reply-To: <YgqOLZbFK7/B2HJT@zeniv-ca.linux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 14 Feb 2022 20:25:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a36U35DK22UT6id=WawWaJa-2+_W9HFgmwdDJ_tVYE5NQ@mail.gmail.com>
Message-ID: <CAK8P3a36U35DK22UT6id=WawWaJa-2+_W9HFgmwdDJ_tVYE5NQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] uaccess: generalize access_ok()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 6:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:45PM +0100, Arnd Bergmann wrote:
>
> > diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> > index c7b763d2f526..8867ddf3e6c7 100644
> > --- a/arch/csky/kernel/signal.c
> > +++ b/arch/csky/kernel/signal.c
> > @@ -136,7 +136,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
> >  static int
> >  setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
> >  {
> > -     struct rt_sigframe *frame;
> > +     struct rt_sigframe __user *frame;
> >       int err = 0;
> >
> >       frame = get_sigframe(ksig, regs, sizeof(*frame));
>
> Minor nit: might make sense to separate annotations (here, on nios2, etc.) from the rest...

Done.

> > -}
> > -
> > -static inline int access_ok(const void __user * addr, unsigned long size)
> > -{
> > -     return 1;
> > -}
> > +#define __range_not_ok(addr, size, limit) (!__access_ok(addr, size))
>
> is really wrong.  For sparc64, access_ok() should always be true.
> This __range_not_ok() thing is used *only* for valid_user_frame() in
> arch/sparc/kernel/perf_event.c - it's not a part of normal access_ok()
> there.
>
> sparc64 has separate address spaces for kernel and for userland; access_ok()
> had never been useful there.

Ok, fixed as well now. I had the access_ok() bit right, the definition just
moved around here so it comes before the #include, but I missed the
bit about __range_not_ok(), which I have now reverted back to the
correct version in my tree.

        Arnd
