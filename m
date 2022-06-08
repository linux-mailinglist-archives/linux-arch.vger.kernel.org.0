Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FED543372
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242463AbiFHOrO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242319AbiFHOrG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 10:47:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45114253FE4;
        Wed,  8 Jun 2022 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OtG2eksypqTPnibPh4fnaffiD2hY+EVznlbJ2kHLrow=; b=s4lrDypR2PUIwq5DKCGjh+oz4W
        NuxeruzrXNHTK2BcKEnwkioprVWjfJLPkgfJl49NvBc1ScRGAbi6IHwVe76KIbMnxjdkcpmvn5wet
        3eYWI/FImC55FL2x6Yx/qYueheCP2qt3qSdNl9P9N0LlknHKQ0jWpiRgO/bj5oEcu6Hwa7YVQSbPC
        22GQFhLji5K7+xrCckZ3sZixDyB/oZzz1dgkIdvOicqFDdspFZ3U79bMwNdWP31xZZ5aSXr9UzD8S
        K41BG1cgoZT9kf1wqRrFYYr6FX1r+dLgPTuXf4ixipRFDyavYNPibE598o+3OGh6R5+E+6ZEIgdiB
        GOcGvWHQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nywwy-00ChW3-Vf; Wed, 08 Jun 2022 14:46:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAD6C302D99;
        Wed,  8 Jun 2022 16:46:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5313720C0F9B9; Wed,  8 Jun 2022 16:46:18 +0200 (CEST)
Message-ID: <20220608144516.362668063@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Jun 2022 16:27:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
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
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
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
Subject: [PATCH 07/36] cpuidle,tegra: Push RCU-idle into driver
References: <20220608142723.103523089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Doing RCU-idle outside the driver, only to then temporarily enable it
again, at least twice, before going idle is daft.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle-tegra.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -180,9 +180,11 @@ static int tegra_cpuidle_state_enter(str
 	}
 
 	local_fiq_disable();
-	RCU_NONIDLE(tegra_pm_set_cpu_in_lp2());
+	tegra_pm_set_cpu_in_lp2();
 	cpu_pm_enter();
 
+	rcu_idle_enter();
+
 	switch (index) {
 	case TEGRA_C7:
 		err = tegra_cpuidle_c7_enter();
@@ -197,8 +199,10 @@ static int tegra_cpuidle_state_enter(str
 		break;
 	}
 
+	rcu_idle_exit();
+
 	cpu_pm_exit();
-	RCU_NONIDLE(tegra_pm_clear_cpu_in_lp2());
+	tegra_pm_clear_cpu_in_lp2();
 	local_fiq_enable();
 
 	return err ?: index;
@@ -226,6 +230,7 @@ static int tegra_cpuidle_enter(struct cp
 			       struct cpuidle_driver *drv,
 			       int index)
 {
+	bool do_rcu = drv->states[index].flags & CPUIDLE_FLAG_RCU_IDLE;
 	unsigned int cpu = cpu_logical_map(dev->cpu);
 	int ret;
 
@@ -233,9 +238,13 @@ static int tegra_cpuidle_enter(struct cp
 	if (dev->states_usage[index].disable)
 		return -1;
 
-	if (index == TEGRA_C1)
+	if (index == TEGRA_C1) {
+		if (do_rcu)
+			rcu_idle_enter();
 		ret = arm_cpuidle_simple_enter(dev, drv, index);
-	else
+		if (do_rcu)
+			rcu_idle_exit();
+	} else
 		ret = tegra_cpuidle_state_enter(dev, index, cpu);
 
 	if (ret < 0) {
@@ -285,7 +294,8 @@ static struct cpuidle_driver tegra_idle_
 			.exit_latency		= 2000,
 			.target_residency	= 2200,
 			.power_usage		= 100,
-			.flags			= CPUIDLE_FLAG_TIMER_STOP,
+			.flags			= CPUIDLE_FLAG_TIMER_STOP |
+						  CPUIDLE_FLAG_RCU_IDLE,
 			.name			= "C7",
 			.desc			= "CPU core powered off",
 		},
@@ -295,6 +305,7 @@ static struct cpuidle_driver tegra_idle_
 			.target_residency	= 10000,
 			.power_usage		= 0,
 			.flags			= CPUIDLE_FLAG_TIMER_STOP |
+						  CPUIDLE_FLAG_RCU_IDLE   |
 						  CPUIDLE_FLAG_COUPLED,
 			.name			= "CC6",
 			.desc			= "CPU cluster powered off",


