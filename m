Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5841668076
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbjALT7i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 14:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjALT7Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E881089;
        Thu, 12 Jan 2023 11:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9z+4CWfQMO+ElFQ60iDcVJO2pPanU43MIsqpSKsLu08=; b=Qqod01hbcDRSoMsHp2FGB2yRt/
        657wthIO1WvpTIc8UJxry1BepGtlDwE7epFhhEiyVvYd20FumrIlq3K+vaV0ZtQy7OHhU1Ha6Vy+d
        u0SWb3lIPqXVymeSnZvxVUtagcGxMJy0Xe74jYFZx3+0fLic59abuep7mI8xDIZhMBlZ3t6vzavRb
        Uv1EVPbqUKMaMYAg9feMtnwldJEBNOwkWJYHJ9H531eMj1aqNuc6W4X31PojT7WMjEw5m15cdtiiL
        lKCURu3mZO9ph5F7yR6vShuu1trhYOgXzpxqstDK3EURxd4NXPx8gIyyUp3NSoc32+cD1hUu18TSA
        o+sF+wjQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG3ht-005P60-6o; Thu, 12 Jan 2023 19:57:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B1D030347F;
        Thu, 12 Jan 2023 20:57:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 725472CD066E4; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195542.274096325@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 20:44:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
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
        shorne@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
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
Subject: [PATCH v3 48/51] cpuidle,arch: Mark all ct_cpuidle_enter() callers __cpuidle
References: <20230112194314.845371875@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For all cpuidle drivers that use CPUIDLE_FLAG_RCU_IDLE, ensure that
all functions that call ct_cpuidle_enter() are marked __cpuidle.

( due to lack of noinstr validation on these platforms it is entirely
  possible this isn't complete )

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c         |    4 ++--
 arch/arm/mach-imx/cpuidle-imx6sx.c        |    4 ++--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c              |    2 +-
 arch/arm64/kernel/cpuidle.c               |    2 +-
 drivers/cpuidle/cpuidle-arm.c             |    4 ++--
 drivers/cpuidle/cpuidle-big_little.c      |    4 ++--
 drivers/cpuidle/cpuidle-mvebu-v7.c        |    6 +++---
 drivers/cpuidle/cpuidle-psci.c            |   17 ++++++-----------
 drivers/cpuidle/cpuidle-qcom-spm.c        |    4 ++--
 drivers/cpuidle/cpuidle-riscv-sbi.c       |   10 +++++-----
 drivers/cpuidle/cpuidle-tegra.c           |   10 +++++-----
 12 files changed, 33 insertions(+), 38 deletions(-)

--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -17,8 +17,8 @@
 static int num_idle_cpus = 0;
 static DEFINE_RAW_SPINLOCK(cpuidle_lock);
 
-static int imx6q_enter_wait(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
+static __cpuidle int imx6q_enter_wait(struct cpuidle_device *dev,
+				      struct cpuidle_driver *drv, int index)
 {
 	raw_spin_lock(&cpuidle_lock);
 	if (++num_idle_cpus == num_online_cpus())
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -30,8 +30,8 @@ static int imx6sx_idle_finish(unsigned l
 	return 0;
 }
 
-static int imx6sx_enter_wait(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
+static __cpuidle int imx6sx_enter_wait(struct cpuidle_device *dev,
+				       struct cpuidle_driver *drv, int index)
 {
 	imx6_set_lpm(WAIT_UNCLOCKED);
 
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -224,8 +224,8 @@ static void __init save_l2x0_context(voi
  *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
  *	3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
  */
-int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
-			 bool rcuidle)
+__cpuidle int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state,
+				   bool rcuidle)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu);
 	unsigned int save_state = 0, cpu_logic_state = PWRDM_POWER_RET;
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -175,7 +175,7 @@ static int omap34xx_do_sram_idle(unsigne
 	return 0;
 }
 
-void omap_sram_idle(bool rcuidle)
+__cpuidle void omap_sram_idle(bool rcuidle)
 {
 	/* Variable to tell what needs to be saved and restored
 	 * in omap_sram_idle*/
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -62,7 +62,7 @@ int acpi_processor_ffh_lpi_probe(unsigne
 	return psci_acpi_cpu_init_idle(cpu);
 }
 
-int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+__cpuidle int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	u32 state = lpi->address;
 
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -31,8 +31,8 @@
  * Called from the CPUidle framework to program the device to the
  * specified target state selected by the governor.
  */
-static int arm_enter_idle_state(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int arm_enter_idle_state(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int idx)
 {
 	/*
 	 * Pass idle state index to arm_cpuidle_suspend which in turn
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -122,8 +122,8 @@ static int notrace bl_powerdown_finisher
  * Called from the CPUidle framework to program the device to the
  * specified target state selected by the governor.
  */
-static int bl_enter_powerdown(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int bl_enter_powerdown(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int idx)
 {
 	cpu_pm_enter();
 	ct_cpuidle_enter();
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -25,9 +25,9 @@
 
 static int (*mvebu_v7_cpu_suspend)(int);
 
-static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+static __cpuidle int mvebu_v7_enter_idle(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
 {
 	int ret;
 	bool deepidle = false;
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -49,14 +49,9 @@ static inline u32 psci_get_domain_state(
 	return __this_cpu_read(domain_state);
 }
 
-static inline int psci_enter_state(int idx, u32 state)
-{
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
-}
-
-static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
-					  struct cpuidle_driver *drv, int idx,
-					  bool s2idle)
+static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
+						    struct cpuidle_driver *drv, int idx,
+						    bool s2idle)
 {
 	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
 	u32 *states = data->psci_states;
@@ -192,12 +187,12 @@ static void psci_idle_init_cpuhp(void)
 		pr_warn("Failed %d while setup cpuhp state\n", err);
 }
 
-static int psci_enter_idle_state(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int psci_enter_idle_state(struct cpuidle_device *dev,
+					   struct cpuidle_driver *drv, int idx)
 {
 	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 
-	return psci_enter_state(idx, state[idx]);
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state[idx]);
 }
 
 static const struct of_device_id psci_idle_state_match[] = {
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -58,8 +58,8 @@ static int qcom_cpu_spc(struct spm_drive
 	return ret;
 }
 
-static int spm_enter_idle_state(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
+static __cpuidle int spm_enter_idle_state(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int idx)
 {
 	struct cpuidle_qcom_spm_data *data = container_of(drv, struct cpuidle_qcom_spm_data,
 							  cpuidle_driver);
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -93,8 +93,8 @@ static int sbi_suspend(u32 state)
 		return sbi_suspend_finisher(state, 0, 0);
 }
 
-static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
-				   struct cpuidle_driver *drv, int idx)
+static __cpuidle int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
+					     struct cpuidle_driver *drv, int idx)
 {
 	u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
 	u32 state = states[idx];
@@ -106,9 +106,9 @@ static int sbi_cpuidle_enter_state(struc
 							     idx, state);
 }
 
-static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
-					  struct cpuidle_driver *drv, int idx,
-					  bool s2idle)
+static __cpuidle int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
+						   struct cpuidle_driver *drv, int idx,
+						   bool s2idle)
 {
 	struct sbi_cpuidle_data *data = this_cpu_ptr(&sbi_cpuidle_data);
 	u32 *states = data->states;
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -160,8 +160,8 @@ static int tegra_cpuidle_coupled_barrier
 	return 0;
 }
 
-static int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
-				     int index, unsigned int cpu)
+static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
+					       int index, unsigned int cpu)
 {
 	int err;
 
@@ -226,9 +226,9 @@ static int tegra_cpuidle_adjust_state_in
 	return index;
 }
 
-static int tegra_cpuidle_enter(struct cpuidle_device *dev,
-			       struct cpuidle_driver *drv,
-			       int index)
+static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
 {
 	bool do_rcu = drv->states[index].flags & CPUIDLE_FLAG_RCU_IDLE;
 	unsigned int cpu = cpu_logical_map(dev->cpu);


