Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D122A5844DB
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jul 2022 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiG1RU6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jul 2022 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiG1RU5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2022 13:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A55B79D;
        Thu, 28 Jul 2022 10:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9229461D0F;
        Thu, 28 Jul 2022 17:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75B3C433D7;
        Thu, 28 Jul 2022 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659028854;
        bh=3juGR+P+/PoNu1lEhZFgztJ6A9LmEO7Lb+rh9Y4NDdw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ajcg/8L4izAZKa2mPe4A6mwD2xhNPSF6zD8jqYYYRNqfhpnanJCwPLkeDTtzMAAXY
         M7oUXZ6CZuH31IjVxAqM2gRnsWZITNKb55wlZ5JnD/DUCRDg3UdeAIrzeX0lNHjHAR
         wzgi3C8wJdIpBMqt7sc3STjd7C0uykM6U86/xrKMdBkv3A6gpbtO4hXjJ5l+TjHaLy
         e4DKSoCgdb1tzebEFm0O9AJWb9AqCOKWaWW3sVozalRIPGLkf5E1tw9aRE4zu/+akq
         X3FcajNE+AfhyfG4rrsgNdfZt/xVPEzBnwFe9tFjDbwwql6CH8YXjM30w46DcxQYCb
         8dZ4kaIUmww0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9739D5C0B3E; Thu, 28 Jul 2022 10:20:53 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:20:53 -0700
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
Message-ID: <20220728172053.GA3607379@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220608142723.103523089@infradead.org>
 <20220608144516.172460444@infradead.org>
 <20220725194306.GA14746@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725194306.GA14746@lespinasse.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 25, 2022 at 12:43:06PM -0700, Michel Lespinasse wrote:
> On Wed, Jun 08, 2022 at 04:27:27PM +0200, Peter Zijlstra wrote:
> > Commit c227233ad64c ("intel_idle: enable interrupts before C1 on
> > Xeons") wrecked intel_idle in two ways:
> > 
> >  - must not have tracing in idle functions
> >  - must return with IRQs disabled
> > 
> > Additionally, it added a branch for no good reason.
> > 
> > Fixes: c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> After this change was introduced, I am seeing "WARNING: suspicious RCU
> usage" when booting a kernel with debug options compiled in. Please
> see the attached dmesg output. The issue starts with commit 32d4fd5751ea
> and is still present in v5.19-rc8.
> 
> I'm not sure, is this too late to fix or revert in v5.19 final ?

I finally got a chance to take a quick look at this.

The rcu_eqs_exit() function is making a lockdep complaint about
being invoked with interrupts enabled.  This function is called from
rcu_idle_exit(), which is an expected code path from cpuidle_enter_state()
via its call to rcu_idle_exit().  Except that rcu_idle_exit() disables
interrupts before invoking rcu_eqs_exit().

The only other call to rcu_idle_exit() does not disable interrupts,
but it is via rcu_user_exit(), which would be a very odd choice for
cpuidle_enter_state().

It seems unlikely, but it might be that it is the use of local_irq_save()
instead of raw_local_irq_save() within rcu_idle_exit() that is causing
the trouble.  If this is the case, then the commit shown below would
help.  Note that this commit removes the warning from lockdep, so it
is necessary to build the kernel with CONFIG_RCU_EQS_DEBUG=y to enable
equivalent debugging.

Could you please try your test with the -rce commit shown below applied?

							Thanx, Paul

------------------------------------------------------------------------

commit ed4ae5eff4b38797607cbdd80da394149110fb37
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue May 17 21:00:04 2022 -0700

    rcu: Apply noinstr to rcu_idle_enter() and rcu_idle_exit()
    
    This commit applies the "noinstr" tag to the rcu_idle_enter() and
    rcu_idle_exit() functions, which are invoked from portions of the idle
    loop that cannot be instrumented.  These tags require reworking the
    rcu_eqs_enter() and rcu_eqs_exit() functions that these two functions
    invoke in order to cause them to use normal assertions rather than
    lockdep.  In addition, within rcu_idle_exit(), the raw versions of
    local_irq_save() and local_irq_restore() are used, again to avoid issues
    with lockdep in uninstrumented code.
    
    This patch is based in part on an earlier patch by Jiri Olsa, discussions
    with Peter Zijlstra and Frederic Weisbecker, earlier changes by Thomas
    Gleixner, and off-list discussions with Yonghong Song.
    
    Link: https://lore.kernel.org/lkml/20220515203653.4039075-1-jolsa@kernel.org/
    Reported-by: Jiri Olsa <jolsa@kernel.org>
    Reported-by: Alexei Starovoitov <ast@kernel.org>
    Reported-by: Andrii Nakryiko <andrii@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Reviewed-by: Yonghong Song <yhs@fb.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a6..9a5edab5558c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -631,8 +631,8 @@ static noinstr void rcu_eqs_enter(bool user)
 		return;
 	}
 
-	lockdep_assert_irqs_disabled();
 	instrumentation_begin();
+	lockdep_assert_irqs_disabled();
 	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
@@ -659,9 +659,9 @@ static noinstr void rcu_eqs_enter(bool user)
  * If you add or remove a call to rcu_idle_enter(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_enter(void)
+void noinstr rcu_idle_enter(void)
 {
-	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	rcu_eqs_enter(false);
 }
 EXPORT_SYMBOL_GPL(rcu_idle_enter);
@@ -861,7 +861,7 @@ static void noinstr rcu_eqs_exit(bool user)
 	struct rcu_data *rdp;
 	long oldval;
 
-	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	rdp = this_cpu_ptr(&rcu_data);
 	oldval = rdp->dynticks_nesting;
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
@@ -896,13 +896,13 @@ static void noinstr rcu_eqs_exit(bool user)
  * If you add or remove a call to rcu_idle_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_idle_exit(void)
+void noinstr rcu_idle_exit(void)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	rcu_eqs_exit(false);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(rcu_idle_exit);
 
