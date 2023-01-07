Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEACF660E68
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jan 2023 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjAGLtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Jan 2023 06:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjAGLse (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2023 06:48:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BE30548;
        Sat,  7 Jan 2023 03:48:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C55B81F8A;
        Sat,  7 Jan 2023 11:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C499C43392;
        Sat,  7 Jan 2023 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673092104;
        bh=VTHYtUz3OxxwIjeHECLj9I/wTerQL3qNkUG2k0mTR8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qOa/1i97apW+ROtARA4M8NUqOhckmJ+TqWQR1dT5DD8dAHXLz6uQvpTmzw6TiCHHg
         NLf85Z3Lm8CJS4H/h3bWaTAk9g5u4aV3T5jRMSTjEzE+UAwwXYKszzLT26l5Mb3S28
         80xJo8x02/Xo8t54fpqZvmQjL1JtX+Ep1jzOPXHE9oRuS0+zogjpdlD2XXXGn6cyoU
         hID9AqNFaM+zmc/Boo/9kcuXC/ghNlFa4jAIG7OTCmUk0pIaA8VJZhuy9hOl9oW0kI
         9XvIhwI/vyCbEZCFWyZD7XxAuzYHZCku7MOWzUqzsWKTQTFLAxQ9geCb1MUFhJG3rC
         zRfsuWAy/lI7Q==
Received: by mail-ej1-f42.google.com with SMTP id qk9so9031609ejc.3;
        Sat, 07 Jan 2023 03:48:24 -0800 (PST)
X-Gm-Message-State: AFqh2ko+xMqX/xACB4oKXUu8BuwFpk+XneOl//ms3PIq2pWYLrWMhrVX
        FN6easlvSxVAR8E8vDv1na6+TlwuLAABbzZe19A=
X-Google-Smtp-Source: AMrXdXsq/i9/Nu38s6tEkyJaWEjtXp+PKs2w/3v6SEZyzEE384j2KgTR88394juTV7MRj4ar2cUwXc9J0hCdBqvthqI=
X-Received: by 2002:a17:907:8024:b0:84d:df2:81f5 with SMTP id
 ft36-20020a170907802400b0084d0df281f5mr633884ejc.406.1673092102402; Sat, 07
 Jan 2023 03:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20230103033531.2011112-1-guoren@kernel.org> <20230103033531.2011112-4-guoren@kernel.org>
 <36314eb6-e41d-30b9-9ac4-12b88a108b7b@ghiti.fr> <CAJF2gTTSretKkJGNV7Y6iJboPuAWUQ=to=RPA8_-Nz8dnufGAg@mail.gmail.com>
 <Y7VrEMJtwC7v7oNy@FVFF77S0Q05N>
In-Reply-To: <Y7VrEMJtwC7v7oNy@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 7 Jan 2023 19:48:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSwE81vtSaCxrVnRk9NsYtT1ukptudLAdLs28MLDgTXrg@mail.gmail.com>
Message-ID: <CAJF2gTSwE81vtSaCxrVnRk9NsYtT1ukptudLAdLs28MLDgTXrg@mail.gmail.com>
Subject: Re: [PATCH -next V12 3/7] riscv: entry: Add noinstr to prevent
 instrumentation inserted
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, arnd@arndb.de,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, ben@decadent.org.uk, bjorn@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
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

On Wed, Jan 4, 2023 at 8:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jan 04, 2023 at 09:40:38AM +0800, Guo Ren wrote:
> > On Tue, Jan 3, 2023 at 5:12 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > >
> > > Hi Guo,
> > >
> > > On 1/3/23 04:35, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Without noinstr the compiler is free to insert instrumentation (thi=
nk
> > > > all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're =
not
> > > > yet ready to run this early in the entry path, for instance it coul=
d
> > > > rely on RCU which isn't on yet, or expect lockdep state. (by peterz=
)
> > > >
> > > > Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.pr=
ogramming.kicks-ass.net/
> > > > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >   arch/riscv/kernel/traps.c | 4 ++--
> > > >   arch/riscv/mm/fault.c     | 2 +-
> > > >   2 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > > index 549bde5c970a..96ec76c54ff2 100644
> > > > --- a/arch/riscv/kernel/traps.c
> > > > +++ b/arch/riscv/kernel/traps.c
> > > > @@ -95,9 +95,9 @@ static void do_trap_error(struct pt_regs *regs, i=
nt signo, int code,
> > > >   }
> > > >
> > > >   #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIV=
E)
> > > > -#define __trap_section               __section(".xip.traps")
> > > > +#define __trap_section __noinstr_section(".xip.traps")
> > > >   #else
> > > > -#define __trap_section
> > > > +#define __trap_section noinstr
> > > >   #endif
> > > >   #define DO_ERROR_INFO(name, signo, code, str)                    =
           \
> > > >   asmlinkage __visible __trap_section void name(struct pt_regs *reg=
s) \
> > > > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > > > index d86f7cebd4a7..b26f68eac61c 100644
> > > > --- a/arch/riscv/mm/fault.c
> > > > +++ b/arch/riscv/mm/fault.c
> > > > @@ -204,7 +204,7 @@ static inline bool access_error(unsigned long c=
ause, struct vm_area_struct *vma)
> > > >    * This routine handles page faults.  It determines the address a=
nd the
> > > >    * problem, and then passes it off to one of the appropriate rout=
ines.
> > > >    */
> > > > -asmlinkage void do_page_fault(struct pt_regs *regs)
> > > > +asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
> > >
> > >
> > > (I dug the archive but can't find the series before v4, so sorry if i=
t
> > > was already answered)
> > >
> > > I think we should not disable the instrumentation of those trap handl=
ers
> > > as at least profiling them with ftrace would provide valuable
> > > information (and gcov would be nice too): why do we need to do that? =
A
> > > trap very early in the boot process is not recoverable anyway.
> > Everything that calls irqentry_enter() should be noinstr, and this
> > patch prepares for the next generic_entry convert.
> >
> > eg:
> > asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
> > {
> >         irqentry_state_t state =3D irqentry_enter(regs);
> >
> >         __do_page_fault(regs);
> >
> >         local_irq_disable();
> >
> >         irqentry_exit(regs, state);
> > }
> > NOKPROBE_SYMBOL(do_page_fault);
> >
> > You still could profile __do_page_fault.
> >
> > >
> > > And I took a look at other architectures, none of them disables the
> > > instrumentation on do_page_fault.
> > That's not true, have a look at power & arm64. All of them have some
> > limitations at the entry of page_fault.
>
> Well, arm64's can't be kprobed, but is *can* be traced with ftrace, and *=
can*
> be instrumented with KASAN and friends. I'm not sure that we actually nee=
d to
> inhibit kprobes for do_page_fault, and we might be able to relax that.
>
> As a general thing, we've tried to centralize all the necesarily-noinstr =
bits
> in arch/arm64/kernel/entry-common.c, and keep everything else as instrume=
ntable
> as possible.
>
> I'd recommend doing similar, and have a central file for any entry bits w=
hich
> can't live in the generic entry code, and keep the rest instrumentable. T=
hat
> will make it easier to maintain and verify.

Okay, here is the v13 [1]. I've centralized all the necesarily-noinstr
bits in arch/riscv/kernel/traps.c.

[1] https://lore.kernel.org/linux-riscv/20230107113838.3969149-1-guoren@ker=
nel.org/

>
> Thanks,
> Mark.



--=20
Best Regards
 Guo Ren
