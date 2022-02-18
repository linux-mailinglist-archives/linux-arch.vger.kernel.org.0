Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB0D4BB33B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 08:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiBRHai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 02:30:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBRHah (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 02:30:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59726B79D;
        Thu, 17 Feb 2022 23:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F9E7B820CC;
        Fri, 18 Feb 2022 07:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B4C340FC;
        Fri, 18 Feb 2022 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645169417;
        bh=4Rk51yI7cy+h8GrR+wkZuFO6d6ZOgVmodthZQla/xGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W+QkvboqRofbLzCm9hHbzxq3Qth8S5HybnqRYBMCOV1+sxzSrsO0GxsWzCKKMdHEn
         bqDIEx/e5uKVtXdEgKU0zauKVsAP+BwRxL7Eht14lnrZY8/Snkv6ooC0Xtnb3PIWOU
         TH9CI9oqKC4NB6YlmX9GiyVVlzJ9JxhHp19vd8W2yF7M0r4JQcSsxSZGgcunHmnBls
         jIKpwMz+6/fED/WEoZ31MUXYk0elz6QstAQFVIrh0vdiPiG2fQNGZe4Ls/9ylnZeuT
         EPDfxlf0eA4H0vr8C6AxZVCkxFWsivLQ9riuK2cmIaTDgPv5zksZWQSERe1IxP+qyj
         OVCD1xp4hu7Yg==
Received: by mail-wr1-f53.google.com with SMTP id o24so13020470wro.3;
        Thu, 17 Feb 2022 23:30:17 -0800 (PST)
X-Gm-Message-State: AOAM533Pn0K1psX08r8MR/7uIPoYLosS7GxMRhKr7RvKUFAahONEFcGZ
        56vGzBunQmxfc7bc1gmCrRw124pgkUxH0XSUlNI=
X-Google-Smtp-Source: ABdhPJz4trlMwdvjT8y0UPggztkdijECp2hMuaf6QP4pGa8b+VYFZp4/tSgCA0YRdkm1OA4dObRIZr3wh6XhtS+RfLY=
X-Received: by 2002:adf:ea01:0:b0:1e4:b3e6:1f52 with SMTP id
 q1-20020adfea01000000b001e4b3e61f52mr4942117wrm.317.1645169415535; Thu, 17
 Feb 2022 23:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-6-arnd@kernel.org>
 <20220218062851.GC22576@lst.de>
In-Reply-To: <20220218062851.GC22576@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Feb 2022 08:29:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Dhn1Gsap1Wss2xpKBwe3jWLAmMYtL7S1-26tZ5D_2fQ@mail.gmail.com>
Message-ID: <CAK8P3a1Dhn1Gsap1Wss2xpKBwe3jWLAmMYtL7S1-26tZ5D_2fQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] x86: remove __range_not_ok()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
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
        <linux-xtensa@linux-xtensa.org>,
        Christoph Hellwig <hch@infradead.org>
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

On Fri, Feb 18, 2022 at 7:28 AM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Feb 16, 2022 at 02:13:19PM +0100, Arnd Bergmann wrote:
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2794,7 +2794,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
> >  static inline int
> >  valid_user_frame(const void __user *fp, unsigned long size)
> >  {
> > -     return (__range_not_ok(fp, size, TASK_SIZE) == 0);
> > +     return __access_ok(fp, size);
> >  }
>
> valid_user_frame just need to go away and the following __get_user calls
> replaced with normal get_user ones.

As I understand it, that would not work here because get_user() calls
access_ok() rather than __access_ok(), and on x86 that can not be
called in NMI context.

It is a bit odd that x86 is the only architecture that has this check,
but adding
it was clearly intentional, see 7c4788950ba5 ("x86/uaccess, sched/preempt:
Verify access_ok() context").

> > diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> > index 53de044e5654..da534fb7b5c6 100644
> > --- a/arch/x86/kernel/dumpstack.c
> > +++ b/arch/x86/kernel/dumpstack.c
> > @@ -85,7 +85,7 @@ static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
> >        * Make sure userspace isn't trying to trick us into dumping kernel
> >        * memory by pointing the userspace instruction pointer at it.
> >        */
> > -     if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
> > +     if (!__access_ok((void __user *)src, nbytes))
> >               return -EINVAL;
>
> This one is not needed at all as copy_from_user_nmi already checks the
> access range.

Ok, removing this.

> > diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> > index 15b058eefc4e..ee117fcf46ed 100644
> > --- a/arch/x86/kernel/stacktrace.c
> > +++ b/arch/x86/kernel/stacktrace.c
> > @@ -90,7 +90,7 @@ copy_stack_frame(const struct stack_frame_user __user *fp,
> >  {
> >       int ret;
> >
> > -     if (__range_not_ok(fp, sizeof(*frame), TASK_SIZE))
> > +     if (!__access_ok(fp, sizeof(*frame)))
> >               return 0;
>
> Just switch the __get_user calls below to get_user instead.

Same as the first one, I think we can't do this in NMI context.

         Arnd
