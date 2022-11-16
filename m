Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FB362C290
	for <lists+linux-arch@lfdr.de>; Wed, 16 Nov 2022 16:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbiKPP3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Nov 2022 10:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiKPP3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2022 10:29:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E134731D;
        Wed, 16 Nov 2022 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4XDB6ZbR3Awa7mOslon9xFqMWj0psrdiARhozQeRyJA=; b=gYnS7fY4SiIk8LhruYi5TSnTVA
        fStgfkd5Z/zbz8yQZBnmnhyWOOmhlrhRObDB9G2KJoco51LBuhZxVkVxbSBrTCQ/HtHWliung+7ZZ
        HbZe3Froz8dQdsOphMI16X4jllstvINRTH3i5h+4adnzIV8bwm2odcxdw/4ACLq7NTIENgyfmZxmW
        flqbgkCx8yOd3LgZHd01MR5R1P5lI3CSROlGEycIvrRPVhabpLUb0rptouTmOLEERLT81z+aE6Z4G
        +eccUWkk2tCLQB+FJ0eM8fcpEENqemtpoKisOMtzDEaLdPH2PhfiSrDXw+vDx7DBnwdyTpMo06laG
        hxV51fpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovKLj-00HX9A-0P; Wed, 16 Nov 2022 15:29:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC2C03006DC;
        Wed, 16 Nov 2022 16:29:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A500120832696; Wed, 16 Nov 2022 16:29:05 +0100 (CET)
Date:   Wed, 16 Nov 2022 16:29:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com,
        linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org,
        pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org,
        vincent.guittot@linaro.org, mpe@ellerman.id.au,
        chenhuacai@kernel.org, christophe.leroy@csgroup.eu,
        linux-acpi@vger.kernel.org, agross@kernel.org,
        geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org,
        mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net,
        pmladek@suse.com, linux-pm@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-um@lists.infradead.org, npiggin@gmail.com,
        tglx@linutronix.de, linux-omap@vger.kernel.org,
        dietmar.eggemann@arm.com, andreyknvl@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, senozhatsky@chromium.org,
        svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        mark.rutland@arm.com, linux-ia64@vger.kernel.org,
        dave.hansen@linux.intel.com,
        virtualization@lists.linux-foundation.org,
        James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com,
        thierry.reding@gmail.com, kernel@xen0n.name, cl@linux.com,
        linux-s390@vger.kernel.org, vschneid@redhat.com,
        john.ogness@linutronix.de, ysato@users.sourceforge.jp,
        linux-sh@vger.kernel.org, festevam@gmail.com, deller@gmx.de,
        daniel.lezcano@linaro.org, jonathanh@nvidia.com, dennis@kernel.org,
        lenb@kernel.org, linux-xtensa@linux-xtensa.org,
        kernel@pengutronix.de, gor@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        shorne@gmail.com, chris@zankel.net, sboyd@kernel.org,
        dinguyen@kernel.org, bristot@redhat.com,
        alexander.shishkin@linux.intel.com, fweisbec@gmail.com,
        lpieralisi@kernel.org, atishp@atishpatra.org,
        linux@rasmusvillemoes.dk, kasan-dev@googlegroups.com,
        will@kernel.org, boris.ostrovsky@oracle.com, khilman@kernel.org,
        linux-csky@vger.kernel.org, pv-drivers@vmware.com,
        linux-snps-arc@lists.infradead.org, mgorman@suse.de,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        ulli.kroll@googlemail.com, linux-clk@vger.kernel.org,
        rostedt@goodmis.org, ink@jurassic.park.msu.ru, bcain@quicinc.com,
        tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
        ryabinin.a.a@gmail.com, sudeep.holla@arm.com, shawnguo@kernel.org,
        davem@davemloft.net, dalias@libc.org, tony@atomide.com,
        amakhalov@vmware.com, konrad.dybcio@somainline.org,
        bjorn.andersson@linaro.org, glider@google.com, hpa@zytor.com,
        sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-riscv@lists.infradead.org, vincenzo.frascino@arm.com,
        anton.ivanov@cambridgegreys.com, jonas@southpole.se,
        yury.norov@gmail.com, richard@nod.at, x86@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, aou@eecs.berkeley.edu,
        hca@linux.ibm.com, richard.henderson@linaro.org,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        acme@kernel.org, paul.walmsley@sifive.com,
        linux-tegra@vger.kernel.org, namhyung@kernel.org,
        andriy.shevchenko@linux.intel.com, jpoimboe@kernel.org,
        dvyukov@google.com, jgross@suse.com, monstr@monstr.eu,
        linux-mips@vger.kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, bp@alien8.de, johannes@sipsolutions.net,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 12/44] cpuidle,dt: Push RCU-idle into driver
Message-ID: <Y3UBwYNY15ETUKy9@hirez.programming.kicks-ass.net>
References: <20220919095939.761690562@infradead.org>
 <20220919101521.139727471@infradead.org>
 <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqTWd4W5Ofk76CtC4X43dxBTNHtmY9YzN355-vpviLsPw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Sorry; things keep getting in the way of finishing this :/

As such, I need a bit of time to get on-track again..

On Tue, Oct 04, 2022 at 01:03:57PM +0200, Ulf Hansson wrote:

> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -1200,6 +1200,8 @@ static int acpi_processor_setup_lpi_stat
> >                 state->target_residency = lpi->min_residency;
> >                 if (lpi->arch_flags)
> >                         state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> > +               if (lpi->entry_method == ACPI_CSTATE_FFH)
> > +                       state->flags |= CPUIDLE_FLAG_RCU_IDLE;
> 
> I assume the state index here will never be 0?
> 
> If not, it may lead to that acpi_processor_ffh_lpi_enter() may trigger
> CPU_PM_CPU_IDLE_ENTER_PARAM() to call ct_cpuidle_enter|exit() for an
> idle-state that doesn't have the CPUIDLE_FLAG_RCU_IDLE bit set.

I'm not quite sure I see how. AFAICT this condition above implies
acpi_processor_ffh_lpi_enter() gets called, no?

Which in turn is an unconditional __CPU_PM_CPU_IDLE_ENTER() user, so
even if idx==0, it ends up in ct_idle_{enter,exit}().

> 
> >                 state->enter = acpi_idle_lpi_enter;
> >                 drv->safe_state_index = i;
> >         }
> > --- a/drivers/cpuidle/cpuidle-arm.c
> > +++ b/drivers/cpuidle/cpuidle-arm.c
> > @@ -53,6 +53,7 @@ static struct cpuidle_driver arm_idle_dr
> >          * handler for idle state index 0.
> >          */
> >         .states[0] = {
> > +               .flags                  = CPUIDLE_FLAG_RCU_IDLE,
> 
> Comparing arm64 and arm32 idle-states/idle-drivers, the $subject
> series ends up setting the CPUIDLE_FLAG_RCU_IDLE for the ARM WFI idle
> state (state zero), but only for the arm64 and psci cases (mostly
> arm64). For arm32 we would need to update the ARM_CPUIDLE_WFI_STATE
> too, as that is what most arm32 idle-drivers are using. My point is,
> the code becomes a bit inconsistent.

True.

> Perhaps it's easier to avoid setting the CPUIDLE_FLAG_RCU_IDLE bit for
> all of the ARM WFI idle states, for both arm64 and arm32?

As per the below?

> 
> >                 .enter                  = arm_enter_idle_state,
> >                 .exit_latency           = 1,
> >                 .target_residency       = 1,

> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -282,14 +282,18 @@ extern s64 cpuidle_governor_latency_req(
> >         int __ret = 0;                                                  \
> >                                                                         \
> >         if (!idx) {                                                     \
> > +               ct_idle_enter();                                        \
> 
> According to my comment above, we should then drop these calls to
> ct_idle_enter and ct_idle_exit() here. Right?

Yes, if we ensure idx==0 never has RCU_IDLE set then these must be
removed.

> >                 cpu_do_idle();                                          \
> > +               ct_idle_exit();                                         \
> >                 return idx;                                             \
> >         }                                                               \
> >                                                                         \
> >         if (!is_retention)                                              \
> >                 __ret =  cpu_pm_enter();                                \
> >         if (!__ret) {                                                   \
> > +               ct_idle_enter();                                        \
> >                 __ret = low_level_idle_enter(state);                    \
> > +               ct_idle_exit();                                         \
> >                 if (!is_retention)                                      \
> >                         cpu_pm_exit();                                  \
> >         }                                                               \
> >

So the basic premise is that everything that needs RCU inside the idle
callback must set CPUIDLE_FLAG_RCU_IDLE and by doing that promise to
call ct_idle_{enter,exit}() themselves.

Setting RCU_IDLE is required when there is RCU usage, however even if
there is no RCU usage, setting RCU_IDLE is fine, as long as
ct_idle_{enter,exit}() then get called.


So does the below (delta) look better to you?

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1218,7 +1218,7 @@ static int acpi_processor_setup_lpi_stat
 		state->target_residency = lpi->min_residency;
 		if (lpi->arch_flags)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
-		if (lpi->entry_method == ACPI_CSTATE_FFH)
+		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
 			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
 		state->enter = acpi_idle_lpi_enter;
 		drv->safe_state_index = i;
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -53,7 +53,7 @@ static struct cpuidle_driver arm_idle_dr
 	 * handler for idle state index 0.
 	 */
 	.states[0] = {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
+		.flags			= 0,
 		.enter                  = arm_enter_idle_state,
 		.exit_latency           = 1,
 		.target_residency       = 1,
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -357,7 +357,7 @@ static int psci_idle_init_cpu(struct dev
 	 * PSCI idle states relies on architectural WFI to be represented as
 	 * state index 0.
 	 */
-	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
+	drv->states[0].flags = 0;
 	drv->states[0].enter = psci_enter_idle_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -72,7 +72,7 @@ static struct cpuidle_driver qcom_spm_id
 	.owner = THIS_MODULE,
 	.states[0] = {
 		.enter			= spm_enter_idle_state,
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
+		.flags			= 0,
 		.exit_latency		= 1,
 		.target_residency	= 1,
 		.power_usage		= UINT_MAX,
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -337,7 +337,7 @@ static int sbi_cpuidle_init_cpu(struct d
 	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
 
 	/* RISC-V architectural WFI to be represented as state index 0. */
-	drv->states[0].flags = CPUIDLE_FLAG_RCU_IDLE;
+	drv->states[0].flags = 0;
 	drv->states[0].enter = sbi_cpuidle_enter_state;
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -282,9 +282,7 @@ extern s64 cpuidle_governor_latency_req(
 	int __ret = 0;							\
 									\
 	if (!idx) {							\
-		ct_idle_enter();					\
 		cpu_do_idle();						\
-		ct_idle_exit();						\
 		return idx;						\
 	}								\
 									\
