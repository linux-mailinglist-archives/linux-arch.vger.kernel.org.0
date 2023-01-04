Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0D65D1FE
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 13:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjADMDh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 07:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbjADMDf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 07:03:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77AA032180;
        Wed,  4 Jan 2023 04:03:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9D031042;
        Wed,  4 Jan 2023 04:04:15 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C581C3F587;
        Wed,  4 Jan 2023 04:03:30 -0800 (PST)
Date:   Wed, 4 Jan 2023 12:03:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, arnd@arndb.de,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, ben@decadent.org.uk, bjorn@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH -next V12 3/7] riscv: entry: Add noinstr to prevent
 instrumentation inserted
Message-ID: <Y7VrEMJtwC7v7oNy@FVFF77S0Q05N>
References: <20230103033531.2011112-1-guoren@kernel.org>
 <20230103033531.2011112-4-guoren@kernel.org>
 <36314eb6-e41d-30b9-9ac4-12b88a108b7b@ghiti.fr>
 <CAJF2gTTSretKkJGNV7Y6iJboPuAWUQ=to=RPA8_-Nz8dnufGAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTSretKkJGNV7Y6iJboPuAWUQ=to=RPA8_-Nz8dnufGAg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 04, 2023 at 09:40:38AM +0800, Guo Ren wrote:
> On Tue, Jan 3, 2023 at 5:12 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
> >
> > Hi Guo,
> >
> > On 1/3/23 04:35, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Without noinstr the compiler is free to insert instrumentation (think
> > > all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> > > yet ready to run this early in the entry path, for instance it could
> > > rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
> > >
> > > Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/
> > > Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >   arch/riscv/kernel/traps.c | 4 ++--
> > >   arch/riscv/mm/fault.c     | 2 +-
> > >   2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > index 549bde5c970a..96ec76c54ff2 100644
> > > --- a/arch/riscv/kernel/traps.c
> > > +++ b/arch/riscv/kernel/traps.c
> > > @@ -95,9 +95,9 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
> > >   }
> > >
> > >   #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> > > -#define __trap_section               __section(".xip.traps")
> > > +#define __trap_section __noinstr_section(".xip.traps")
> > >   #else
> > > -#define __trap_section
> > > +#define __trap_section noinstr
> > >   #endif
> > >   #define DO_ERROR_INFO(name, signo, code, str)                               \
> > >   asmlinkage __visible __trap_section void name(struct pt_regs *regs) \
> > > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > > index d86f7cebd4a7..b26f68eac61c 100644
> > > --- a/arch/riscv/mm/fault.c
> > > +++ b/arch/riscv/mm/fault.c
> > > @@ -204,7 +204,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
> > >    * This routine handles page faults.  It determines the address and the
> > >    * problem, and then passes it off to one of the appropriate routines.
> > >    */
> > > -asmlinkage void do_page_fault(struct pt_regs *regs)
> > > +asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
> >
> >
> > (I dug the archive but can't find the series before v4, so sorry if it
> > was already answered)
> >
> > I think we should not disable the instrumentation of those trap handlers
> > as at least profiling them with ftrace would provide valuable
> > information (and gcov would be nice too): why do we need to do that? A
> > trap very early in the boot process is not recoverable anyway.
> Everything that calls irqentry_enter() should be noinstr, and this
> patch prepares for the next generic_entry convert.
> 
> eg:
> asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
> {
>         irqentry_state_t state = irqentry_enter(regs);
> 
>         __do_page_fault(regs);
> 
>         local_irq_disable();
> 
>         irqentry_exit(regs, state);
> }
> NOKPROBE_SYMBOL(do_page_fault);
> 
> You still could profile __do_page_fault.
> 
> >
> > And I took a look at other architectures, none of them disables the
> > instrumentation on do_page_fault.
> That's not true, have a look at power & arm64. All of them have some
> limitations at the entry of page_fault.

Well, arm64's can't be kprobed, but is *can* be traced with ftrace, and *can*
be instrumented with KASAN and friends. I'm not sure that we actually need to
inhibit kprobes for do_page_fault, and we might be able to relax that.

As a general thing, we've tried to centralize all the necesarily-noinstr bits
in arch/arm64/kernel/entry-common.c, and keep everything else as instrumentable
as possible.

I'd recommend doing similar, and have a central file for any entry bits which
can't live in the generic entry code, and keep the rest instrumentable. That
will make it easier to maintain and verify.

Thanks,
Mark.
