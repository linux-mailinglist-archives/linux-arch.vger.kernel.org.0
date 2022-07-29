Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A773D585282
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jul 2022 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiG2P00 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jul 2022 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbiG2P0Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jul 2022 11:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9FC32E;
        Fri, 29 Jul 2022 08:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED18961B69;
        Fri, 29 Jul 2022 15:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583E9C433D6;
        Fri, 29 Jul 2022 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659108382;
        bh=u7iMRCibJGPgHojnAneRfpJQLfO1v9UeCr7NEqXA5r0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j/ssGM4UwMLUBLCP78RosSv+xdTA5IxQuurJEQkAk0bXcmXPO93JJUXNFsdGh+1wg
         +oQu9G8HFTFvq7oWLnSNFUXfz91zcbExFBxbHvUUrLwuFGec8y0pgDI7OkmIEUiDsJ
         xuSOA0nMD0LfFRMzO/hFHpmNupsJvKL62OZ7Ogs2Sct+xobNCKamTbCGFqWe+ziWO5
         X1ZeZmjvoSs9jG1zXifbRaMvzpG1WXKjUcVgoHT0G2I9F3u+FSVuGP4WeqriMREnTB
         5LhXtVu1diWGmPLJYP56buqhIf3r1Jp2kzJeotpuUGt61TvxvtDbwosjkjOrYw33Op
         oX8J8MWyCJV3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0AF325C033E; Fri, 29 Jul 2022 08:26:22 -0700 (PDT)
Date:   Fri, 29 Jul 2022 08:26:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
        linux@armlinux.org.uk, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com,
        khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        frederic@kernel.org, quic_neeraju@quicinc.com,
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
        rcu@vger.kernel.org, rh0@fb.com
Subject: Re: [PATCH 04/36] cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE
Message-ID: <20220729152622.GM2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
 <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
 <20220729102458.GA1695@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729102458.GA1695@lespinasse.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 29, 2022 at 03:24:58AM -0700, Michel Lespinasse wrote:
> On Thu, Jul 28, 2022 at 10:20:53AM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 25, 2022 at 12:43:06PM -0700, Michel Lespinasse wrote:
> > > On Wed, Jun 08, 2022 at 04:27:27PM +0200, Peter Zijlstra wrote:
> > > > Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> > > > Xeons") wrecked intel_idle in two ways:
> > > > 
> > > >  - must not have tracing in idle functions
> > > >  - must return with IRQs disabled
> > > > 
> > > > Additionally, it added a branch for no good reason.
> > > > 
> > > > Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > 
> > > After this change was introduced, I am seeing "WARNING: suspicious RCU
> > > usage" when booting a kernel with debug options compiled in. Please
> > > see the attached dmesg output. The issue starts with commit 32d4fd5751ea
> > > and is still present in v5.19-rc8.
> > > 
> > > I'm not sure, is this too late to fix or revert in v5.19 final ?
> > 
> > I finally got a chance to take a quick look at this.
> > 
> > The rcu_eqs_exit() function is making a lockdep complaint about
> > being invoked with interrupts enabled.  This function is called from
> > rcu_idle_exit(), which is an expected code path from cpuidle_enter_state()
> > via its call to rcu_idle_exit().  Except that rcu_idle_exit() disables
> > interrupts before invoking rcu_eqs_exit().
> > 
> > The only other call to rcu_idle_exit() does not disable interrupts,
> > but it is via rcu_user_exit(), which would be a very odd choice for
> > cpuidle_enter_state().
> > 
> > It seems unlikely, but it might be that it is the use of local_irq_save()
> > instead of raw_local_irq_save() within rcu_idle_exit() that is causing
> > the trouble.  If this is the case, then the commit shown below would
> > help.  Note that this commit removes the warning from lockdep, so it
> > is necessary to build the kernel with CONFIG_RCU_EQS_DEBUG=y to enable
> > equivalent debugging.
> > 
> > Could you please try your test with the -rce commit shown below applied?
> 
> Thanks for looking into it.

And thank you for trying this shot in the dark!

> After checking out Peter's commit 32d4fd5751ea,
> cherry picking your commit ed4ae5eff4b3,
> and setting CONFIG_RCU_EQS_DEBUG=y in addition of my usual debug config,
> I am now seeing this a few seconds into the boot:
> 
> [    3.010650] ------------[ cut here ]------------
> [    3.010651] WARNING: CPU: 0 PID: 0 at kernel/sched/clock.c:397 sched_clock_tick+0x27/0x60

And this is again a complaint about interrupts not being disabled.

But it does appear that the problem was the lockdep complaint, and
eliminating that did take care of part of the problem.  But lockdep
remained enabled, and you therefore hit the next complaint.

> [    3.010657] Modules linked in:
> [    3.010660] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc1-test-00005-g1be22fea0611 #1
> [    3.010662] Hardware name: LENOVO 30BFS44D00/1036, BIOS S03KT51A 01/17/2022
> [    3.010663] RIP: 0010:sched_clock_tick+0x27/0x60

The most straightforward way to get to sched_clock_tick() from
cpuidle_enter_state() is via the call to sched_clock_idle_wakeup_event().

Except that it disables interrupts before invoking sched_clock_tick().

> [    3.010665] Code: 1f 40 00 53 eb 02 5b c3 66 90 8b 05 2f c3 40 01 85 c0 74 18 65 8b 05 60 88 8f 4e 85 c0 75 0d 65 8b 05 a9 85 8f 4e 85 c0 74 02 <0f> 0b e8 e2 6c 89 00 48 c7 c3 40 d5 02 00
>  89 c0 48 03 1c c5 c0 98
> [    3.010667] RSP: 0000:ffffffffb2803e28 EFLAGS: 00010002
> [    3.010670] RAX: 0000000000000001 RBX: ffffc8ce7fa07060 RCX: 0000000000000001
> [    3.010671] RDX: 0000000000000000 RSI: ffffffffb268dd21 RDI: ffffffffb269ab13
> [    3.010673] RBP: 0000000000000001 R08: ffffffffffc300d5 R09: 000000000002be80
> [    3.010674] R10: 000003625b53183a R11: ffffa012b802b7a4 R12: ffffffffb2aa9e80
> [    3.010675] R13: ffffffffb2aa9e00 R14: 0000000000000001 R15: 0000000000000000
> [    3.010677] FS:  0000000000000000(0000) GS:ffffa012b8000000(0000) knlGS:0000000000000000
> [    3.010678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.010680] CR2: ffffa012f81ff000 CR3: 0000000c99612001 CR4: 00000000003706f0
> [    3.010681] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    3.010682] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    3.010683] Call Trace:
> [    3.010685]  <TASK>
> [    3.010688]  cpuidle_enter_state+0xb7/0x4b0
> [    3.010694]  cpuidle_enter+0x29/0x40
> [    3.010697]  do_idle+0x1d4/0x210
> [    3.010702]  cpu_startup_entry+0x19/0x20
> [    3.010704]  rest_init+0x117/0x1a0
> [    3.010708]  arch_call_rest_init+0xa/0x10
> [    3.010711]  start_kernel+0x6d8/0x6ff
> [    3.010716]  secondary_startup_64_no_verify+0xce/0xdb
> [    3.010728]  </TASK>
> [    3.010729] irq event stamp: 44179
> [    3.010730] hardirqs last  enabled at (44179): [<ffffffffb2000ccb>] asm_sysvec_apic_timer_interrupt+0x1b/0x20
> [    3.010734] hardirqs last disabled at (44177): [<ffffffffb22003f0>] __do_softirq+0x3f0/0x498
> [    3.010736] softirqs last  enabled at (44178): [<ffffffffb2200332>] __do_softirq+0x332/0x498
> [    3.010738] softirqs last disabled at (44171): [<ffffffffb16c760b>] irq_exit_rcu+0xab/0xf0
> [    3.010741] ---[ end trace 0000000000000000 ]---

Would you be willing to try another shot in the dark, but untested
this time?  I freely admit that this is getting strange.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index e374c0c923dae..279f557bf60bb 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -394,7 +394,7 @@ notrace void sched_clock_tick(void)
 	if (!static_branch_likely(&sched_clock_running))
 		return;
 
-	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 
 	scd = this_scd();
 	__scd_stamp(scd);
