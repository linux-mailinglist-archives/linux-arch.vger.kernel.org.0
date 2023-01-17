Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329E66DAF4
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jan 2023 11:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjAQK1e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Jan 2023 05:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjAQK1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jan 2023 05:27:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C9303CD;
        Tue, 17 Jan 2023 02:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oxrJBZkAaCeFAHBiyHLFWLeqn2s4gXmFVHT68O/MsFk=; b=GQsHqdtN/iREDQ8vi1O4Be1MrZ
        rseA9/3ogzxQ6xZE4SqLUZG4sV/QDZjvMovg65N0xIIgCnRPbkND1+nwy51nHnBc5DWNJS4XUBAN9
        DGhO4XvtgUfXh3DGTlKQTq1yWaZoEocA9mKp7m7181bsUQeP0yUWn9Ocr+1xM7l1a0UxxyRm82Zw+
        z3mRAtrbo2NEuxCbyqDel031QfZM7HOcrBLOGqBY1RekqMov5sENJSTJquxMwFQpH1Z5aFuaq2SxP
        yues13giahhBFOzG58JwmbeFuKGXFy4M+qN2H/Xcy0ClAmlPum6BOEWDZwYNw11AStmRYs4JMNKUo
        mE/sBfbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHjAz-009alg-LZ; Tue, 17 Jan 2023 10:26:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC3A53005C9;
        Tue, 17 Jan 2023 11:26:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3475201C94B3; Tue, 17 Jan 2023 11:26:29 +0100 (CET)
Date:   Tue, 17 Jan 2023 11:26:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        nsekhar@ti.com, brgl@bgdev.pl, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, shawnguo@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com,
        khilman@kernel.org, krzysztof.kozlowski@linaro.org,
        alim.akhtar@samsung.com, catalin.marinas@arm.com, will@kernel.org,
        guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        pv-drivers@vmware.com, boris.ostrovsky@oracle.com,
        chris@zankel.net, jcmvbkbc@gmail.com, rafael@kernel.org,
        lenb@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, atishp@atishpatra.org,
        Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        rostedt@goodmis.org, mhiramat@kernel.org, frederic@kernel.org,
        paulmck@kernel.org, pmladek@suse.com, senozhatsky@chromium.org,
        john.ogness@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 00/51] cpuidle,rcu: Clean up the mess
Message-ID: <Y8Z31UbzG3LJgAXE@hirez.programming.kicks-ass.net>
References: <20230112194314.845371875@infradead.org>
 <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8WCWAuQSHN651dA@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 16, 2023 at 04:59:04PM +0000, Mark Rutland wrote:

> I'm sorry to have to bear some bad news on that front. :(

Moo, something had to give..


> IIUC what's happenign here is the PSCI cpuidle driver has entered idle and RCU
> is no longer watching when arm64's cpu_suspend() manipulates DAIF. Our
> local_daif_*() helpers poke lockdep and tracing, hence the call to
> trace_hardirqs_off() and the RCU usage.

Right, strictly speaking not needed at this point, IRQs should have been
traced off a long time ago.

> I think we need RCU to be watching all the way down to cpu_suspend(), and it's
> cpu_suspend() that should actually enter/exit idle context. That and we need to
> make cpu_suspend() and the low-level PSCI invocation noinstr.
> 
> I'm not sure whether 32-bit will have a similar issue or not.

I'm not seeing 32bit or Risc-V have similar issues here, but who knows,
maybe I missed somsething.

In any case, the below ought to cure the ARM64 case and remove that last
known RCU_NONIDLE() user as a bonus.

---
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 41974a1a229a..42e19fff40ee 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -67,10 +67,10 @@ __cpuidle int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 	u32 state = lpi->address;
 
 	if (ARM64_LPI_IS_RETENTION_STATE(lpi->arch_flags))
-		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(psci_cpu_suspend_enter,
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM_RCU(psci_cpu_suspend_enter,
 						lpi->index, state);
 	else
-		return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
+		return CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(psci_cpu_suspend_enter,
 					     lpi->index, state);
 }
 #endif
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index e7163f31f716..0fbdf5fe64d8 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -4,6 +4,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/pgtable.h>
+#include <linux/cpuidle.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -104,6 +105,10 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 * From this point debug exceptions are disabled to prevent
 	 * updates to mdscr register (saved and restored along with
 	 * general purpose registers) from kernel debuggers.
+	 *
+	 * Strictly speaking the trace_hardirqs_off() here is superfluous,
+	 * hardirqs should be firmly off by now. This really ought to use
+	 * something like raw_local_daif_save().
 	 */
 	flags = local_daif_save();
 
@@ -120,6 +125,8 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	 */
 	arm_cpuidle_save_irq_context(&context);
 
+	ct_cpuidle_enter();
+
 	if (__cpu_suspend_enter(&state)) {
 		/* Call the suspend finisher */
 		ret = fn(arg);
@@ -133,8 +140,11 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		 */
 		if (!ret)
 			ret = -EOPNOTSUPP;
+
+		ct_cpuidle_exit();
 	} else {
-		RCU_NONIDLE(__cpu_suspend_exit());
+		ct_cpuidle_exit();
+		__cpu_suspend_exit();
 	}
 
 	arm_cpuidle_restore_irq_context(&context);
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 4fc4e0381944..312a34ef28dc 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -69,16 +69,12 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	else
 		pm_runtime_put_sync_suspend(pd_dev);
 
-	ct_cpuidle_enter();
-
 	state = psci_get_domain_state();
 	if (!state)
 		state = states[idx];
 
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
-	ct_cpuidle_exit();
-
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
 	else
@@ -192,7 +188,7 @@ static __cpuidle int psci_enter_idle_state(struct cpuidle_device *dev,
 {
 	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state[idx]);
+	return CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(psci_cpu_suspend_enter, idx, state[idx]);
 }
 
 static const struct of_device_id psci_idle_state_match[] = {
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e7bcfca4159f..f3a044fa4652 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -462,11 +462,22 @@ int psci_cpu_suspend_enter(u32 state)
 	if (!psci_power_state_loses_context(state)) {
 		struct arm_cpuidle_irq_context context;
 
+		ct_cpuidle_enter();
 		arm_cpuidle_save_irq_context(&context);
 		ret = psci_ops.cpu_suspend(state, 0);
 		arm_cpuidle_restore_irq_context(&context);
+		ct_cpuidle_exit();
 	} else {
+		/*
+		 * ARM64 cpu_suspend() wants to do ct_cpuidle_*() itself.
+		 */
+		if (!IS_ENABLED(CONFIG_ARM64))
+			ct_cpuidle_enter();
+
 		ret = cpu_suspend(state, psci_suspend_finisher);
+
+		if (!IS_ENABLED(CONFIG_ARM64))
+			ct_cpuidle_exit();
 	}
 
 	return ret;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 630c879143c7..3183aeb7f5b4 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -307,7 +307,7 @@ extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 #define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter,			\
 				idx,					\
 				state,					\
-				is_retention)				\
+				is_retention, is_rcu)			\
 ({									\
 	int __ret = 0;							\
 									\
@@ -319,9 +319,11 @@ extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 	if (!is_retention)						\
 		__ret =  cpu_pm_enter();				\
 	if (!__ret) {							\
-		ct_cpuidle_enter();					\
+		if (!is_rcu)						\
+			ct_cpuidle_enter();				\
 		__ret = low_level_idle_enter(state);			\
-		ct_cpuidle_exit();					\
+		if (!is_rcu)						\
+			ct_cpuidle_exit();				\
 		if (!is_retention)					\
 			cpu_pm_exit();					\
 	}								\
@@ -330,15 +332,21 @@ extern s64 cpuidle_governor_latency_req(unsigned int cpu);
 })
 
 #define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 0)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 0, 0)
 
 #define CPU_PM_CPU_IDLE_ENTER_RETENTION(low_level_idle_enter, idx)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 1)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, idx, 1, 0)
 
 #define CPU_PM_CPU_IDLE_ENTER_PARAM(low_level_idle_enter, idx, state)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 0)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 0, 0)
+
+#define CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(low_level_idle_enter, idx, state)	\
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 0, 1)
 
 #define CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(low_level_idle_enter, idx, state)	\
-	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 1)
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 1, 0)
+
+#define CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM_RCU(low_level_idle_enter, idx, state)	\
+	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, state, 1, 1)
 
 #endif /* _LINUX_CPUIDLE_H */
