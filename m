Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65C65BC84E
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiISKV3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiISKSL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 06:18:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6C22BD4;
        Mon, 19 Sep 2022 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TtR3uUdCvUM2x08kEUTStDUmM7q30GrToBg+SVCjhcg=; b=p3tL+i6FGsUGrTKP+tPE/3nrXS
        oFLq6N4xUorjt9PsB3timTWWpJWtYVybyNEQkmk+o2qdUnf4WK3w68YmoaNU+NybLUUtEEcjbTg6D
        Db/yUE0Um1TzLW7TtO6orgc6MxcwI5wxohO6RnpKt01YWH5J1Mzj752o/RHTBV4SupoLZ3dQtBU7C
        EUntj8nZeZZ6m3xjfVk7GomnIMDZ4oflUQ+8GZmbthEqN6SWCmMv2/7NKLnTeVYCV8sGf7/kzGpsI
        dS8u0HXd4FKA2f895S2R2CTFDDaG3PyrYWNO3B4/R/xzgFIY+nJGlu128iZJvFnu1oYEiga3xwwj5
        ndJdRXLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaDq6-00E2Bi-N5; Mon, 19 Sep 2022 10:17:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76D8F302F60;
        Mon, 19 Sep 2022 12:16:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 883CE2BAC75B8; Mon, 19 Sep 2022 12:16:22 +0200 (CEST)
Message-ID: <20220919101522.775353582@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Sep 2022 12:00:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
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
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        anup@brainfault.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jacob.jun.pan@linux.intel.com,
        atishp@atishpatra.org, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, fweisbec@gmail.com,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
Subject: [PATCH v2 36/44] cpuidle,omap4: Push RCU-idle into omap4_enter_lowpower()
References: <20220919095939.761690562@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

OMAP4 uses full SoC suspend modes as idle states, as such it needs the
whole power-domain and clock-domain code from the idle path.

All that code is not suitable to run with RCU disabled, as such push
RCU-idle deeper still.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yqcv6crSNKuSWoTu@atomide.com
---
 arch/arm/mach-omap2/common.h              |    6 ++++--
 arch/arm/mach-omap2/cpuidle44xx.c         |    8 ++------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   12 +++++++++++-
 arch/arm/mach-omap2/pm44xx.c              |    2 +-
 4 files changed, 18 insertions(+), 10 deletions(-)

--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -284,11 +284,13 @@ extern u32 omap4_get_cpu1_ns_pa_addr(voi
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
 extern int omap4_mpuss_init(void);
-extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
+extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
+				bool rcuidle);
 extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
-					unsigned int power_state)
+					unsigned int power_state,
+					bool rcuidle)
 {
 	cpu_do_idle();
 	return 0;
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -105,9 +105,7 @@ static int omap_enter_idle_smp(struct cp
 	}
 	raw_spin_unlock_irqrestore(&mpu_lock, flag);
 
-	ct_cpuidle_enter();
-	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
-	ct_cpuidle_exit();
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state, true);
 
 	raw_spin_lock_irqsave(&mpu_lock, flag);
 	if (cx->mpu_state_vote == num_online_cpus())
@@ -186,10 +184,8 @@ static int omap_enter_idle_coupled(struc
 		}
 	}
 
-	ct_cpuidle_enter();
-	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state, true);
 	cpu_done[dev->cpu] = true;
-	ct_cpuidle_exit();
 
 	/* Wakeup CPU1 only if it is not offlined */
 	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -33,6 +33,7 @@
  * and first to wake-up when MPUSS low power states are excercised
  */
 
+#include <linux/cpuidle.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/errno.h>
@@ -214,6 +215,7 @@ static void __init save_l2x0_context(voi
  * of OMAP4 MPUSS subsystem
  * @cpu : CPU ID
  * @power_state: Low power state.
+ * @rcuidle: RCU needs to be idled
  *
  * MPUSS states for the context save:
  * save_state =
@@ -222,7 +224,8 @@ static void __init save_l2x0_context(voi
  *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
  *	3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
  */
-int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
+int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
+			 bool rcuidle)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int save_state = 0, cpu_logic_state = PWRDM_POWER_RET;
@@ -268,6 +271,10 @@ int omap4_enter_lowpower(unsigned int cp
 	cpu_clear_prev_logic_pwrst(cpu);
 	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
 	pwrdm_set_logic_retst(pm_info->pwrdm, cpu_logic_state);
+
+	if (rcuidle)
+		ct_cpuidle_enter();
+
 	set_cpu_wakeup_addr(cpu, __pa_symbol(omap_pm_ops.resume));
 	omap_pm_ops.scu_prepare(cpu, power_state);
 	l2x0_pwrst_prepare(cpu, save_state);
@@ -283,6 +290,9 @@ int omap4_enter_lowpower(unsigned int cp
 	if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD) && cpu)
 		gic_dist_enable();
 
+	if (rcuidle)
+		ct_cpuidle_exit();
+
 	/*
 	 * Restore the CPUx power state to ON otherwise CPUx
 	 * power domain can transitions to programmed low power
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -76,7 +76,7 @@ static int omap4_pm_suspend(void)
 	 * domain CSWR is not supported by hardware.
 	 * More details can be found in OMAP4430 TRM section 4.3.4.2.
 	 */
-	omap4_enter_lowpower(cpu_id, cpu_suspend_state);
+	omap4_enter_lowpower(cpu_id, cpu_suspend_state, false);
 
 	/* Restore next powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {


