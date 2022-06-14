Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7666F54B7B6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiFNRd0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbiFNRdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 13:33:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77C763056C;
        Tue, 14 Jun 2022 10:33:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD0DD1762;
        Tue, 14 Jun 2022 10:33:22 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.41.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0913F66F;
        Tue, 14 Jun 2022 10:33:04 -0700 (PDT)
Date:   Tue, 14 Jun 2022 18:33:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        pv-drivers@vmware.com, boris.ostrovsky@oracle.com,
        chris@zankel.net, jcmvbkbc@gmail.com, rafael@kernel.org,
        lenb@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 00/36] cpuidle,rcu: Cleanup the mess
Message-ID: <YqjGTFEWSJGGOjNA@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
 <YqhuwQjmZyOVSiLI@FVFF77S0Q05N>
 <Yqi+Nqz1J8wI5GcX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqi+Nqz1J8wI5GcX@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 14, 2022 at 06:58:30PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 14, 2022 at 12:19:29PM +0100, Mark Rutland wrote:
> > On Wed, Jun 08, 2022 at 04:27:23PM +0200, Peter Zijlstra wrote:
> > > Hi All! (omg so many)
> > 
> > Hi Peter,
> > 
> > Sorry for the delay; my plate has also been rather full recently. I'm beginning
> > to page this in now.
> 
> No worries; we all have too much to do ;-)
> 
> > > These here few patches mostly clear out the utter mess that is cpuidle vs rcuidle.
> > > 
> > > At the end of the ride there's only 2 real RCU_NONIDLE() users left
> > > 
> > >   arch/arm64/kernel/suspend.c:            RCU_NONIDLE(__cpu_suspend_exit());
> > >   drivers/perf/arm_pmu.c:                 RCU_NONIDLE(armpmu_start(event, PERF_EF_RELOAD));
> > 
> > The latter of these is necessary because apparently PM notifiers are called
> > with RCU not watching. Is that still the case today (or at the end of this
> > series)? If so, that feels like fertile land for more issues (yaey...). If not,
> > we should be able to drop this.
> 
> That should be fixed; fingers crossed :-)

Cool; I'll try to give that a spin when I'm sat next to some relevant hardware. :)

> > >   kernel/cfi.c:   RCU_NONIDLE({
> > > 
> > > (the CFI one is likely dead in the kCFI rewrite) and there's only a hand full
> > > of trace_.*_rcuidle() left:
> > > 
> > >   kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> > >   kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> > >   kernel/trace/trace_preemptirq.c:                        trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
> > >   kernel/trace/trace_preemptirq.c:                        trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
> > >   kernel/trace/trace_preemptirq.c:                trace_preempt_enable_rcuidle(a0, a1);
> > >   kernel/trace/trace_preemptirq.c:                trace_preempt_disable_rcuidle(a0, a1);
> > > 
> > > All of them are in 'deprecated' code that is unused for GENERIC_ENTRY.
> > I think those are also unused on arm64 too?
> > 
> > If not, I can go attack that.
> 
> My grep spots:
> 
> arch/arm64/kernel/entry-common.c:               trace_hardirqs_on();
> arch/arm64/include/asm/daifflags.h:     trace_hardirqs_off();
> arch/arm64/include/asm/daifflags.h:             trace_hardirqs_off();

Ah; I hadn't realised those used trace_.*_rcuidle() behind the scenes.

That affects local_irq_{enable,disable,restore}() too (which is what the
daifflags.h bits are emulating), and also the generic entry code's
irqentry_exit().

So it feels to me like we should be fixing those more generally? e.g. say that
with a new STRICT_ENTRY[_RCU], we can only call trace_hardirqs_{on,off}() with
RCU watching, and alter the definition of those?

> The _on thing should be replaced with something like:
> 
> 	trace_hardirqs_on_prepare();
> 	lockdep_hardirqs_on_prepare();
> 	instrumentation_end();
> 	rcu_irq_exit();
> 	lockdep_hardirqs_on(CALLER_ADDR0);
> 
> (as I think you know, since you have some of that already). And
> something similar for the _off thing, but with _off_finish().

Sure; I knew that was necessary for the outermost parts of entry (and I think
that's all handled), I just hadn't realised that trace_hardirqs_{on,off} did
the rcuidle thing in the middle.

It'd be nice to not have to open-code the whole sequence everywhere for the
portions which run after entry and are instrumentable, so (as above) I reckon
we want to make trace_hardirqs_{on,off}() not do the rcuidle part
unnecessarily (which IIUC is an end-goal anyway)?

> > > I've touched a _lot_ of code that I can't test and likely broken some of it :/
> > > In particular, the whole ARM cpuidle stuff was quite involved with OMAP being
> > > the absolute 'winner'.
> > > 
> > > I'm hoping Mark can help me sort the remaining ARM64 bits as he moves that to
> > > GENERIC_ENTRY.
> > 
> > Moving to GENERIC_ENTRY as a whole is going to take a tonne of work
> > (refactoring both arm64 and the generic portion to be more amenable to each
> > other), but we can certainly move closer to that for the bits that matter here.
> 
> I know ... been there etc.. :-)
> 
> > Maybe we want a STRICT_ENTRY option to get rid of all the deprecated stuff that
> > we can select regardless of GENERIC_ENTRY to make that easier.
> 
> Possible yeah.
> 
> > > I've also got a note that says ARM64 can probably do a WFE based
> > > idle state and employ TIF_POLLING_NRFLAG to avoid some IPIs.
> > 
> > Possibly; I'm not sure how much of a win that'll be given that by default we'll
> > have a ~10KHz WFE wakeup from the timer, but we could take a peek.
> 
> Ohh.. I didn't know it woke up *that* often. I just know Will made use
> of it in things like smp_cond_load_relaxed() which would be somewhat
> similar to a very shallow idle state that looks at the TIF word.

We'll get some saving, I'm just not sure where that falls on the curve of idle
states. FWIW the wakeup *can* be disabled (and it'd be nice to when we have
WFxT instructions which take a timeout), it jsut happens to be on by default
for reasons.

Thanks,
Mark.
