Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137265BC64F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiISKRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 06:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiISKRG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 06:17:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3321803;
        Mon, 19 Sep 2022 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0408VWH2WFH9JXFcPPgwTxDvr1YxbJ2d7rq21E3aJ8U=; b=kHVZnfdiABvtjPyXMTuvXb/Qm9
        09AKDvXlLmYco5rg5+lKhXzEfXaXLMAXiaXS6AjhRnHqScyUaTO2iINZvbgs8N78kwSfXMIpTU5WQ
        YbJDFfF895gdEVMmc6BsVajHcmDOKTDGJ8T+HnVoRXF2kkgnjxdOPEU4hgBjokhzRU8d5p+B5crjC
        /yiyfR6F5TpqK5jk8cvfleteP3e/jL/baMBCBbPynD9WUAl/ZQlsUs9qYKHEeSSf4RkeeRCfDBrOU
        SconuiF3R/DV9ndlHterUE8RIAQz9f77EQkpfOFe7OEu5IK5h7kvKhzF9SsjBWsyb2Q1kTUxmhYjA
        Jijh1grA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaDpH-004aiE-5T; Mon, 19 Sep 2022 10:16:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCEB1302E7C;
        Mon, 19 Sep 2022 12:16:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBD782BA4903E; Mon, 19 Sep 2022 12:16:21 +0200 (CEST)
Message-ID: <20220919101520.936337959@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Sep 2022 11:59:48 +0200
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
Subject: [PATCH v2 09/44] cpuidle,omap3: Push RCU-idle into driver
References: <20220919095939.761690562@infradead.org>
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

Doing RCU-idle outside the driver, only to then teporarily enable it
again before going idle is daft.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -133,7 +133,9 @@ static int omap3_enter_idle(struct cpuid
 	}
 
 	/* Execute ARM wfi */
+	ct_idle_enter();
 	omap_sram_idle();
+	ct_idle_exit();
 
 	/*
 	 * Call idle CPU PM enter notifier chain to restore
@@ -265,6 +267,7 @@ static struct cpuidle_driver omap3_idle_
 	.owner            = THIS_MODULE,
 	.states = {
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 2 + 2,
 			.target_residency = 5,
@@ -272,6 +275,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 10 + 10,
 			.target_residency = 30,
@@ -279,6 +283,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 50 + 50,
 			.target_residency = 300,
@@ -286,6 +291,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU RET + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 1500 + 1800,
 			.target_residency = 4000,
@@ -293,6 +299,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU OFF + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 2500 + 7500,
 			.target_residency = 12000,
@@ -300,6 +307,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU RET + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 3000 + 8500,
 			.target_residency = 15000,
@@ -307,6 +315,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU OFF + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 10000 + 30000,
 			.target_residency = 30000,
@@ -328,6 +337,7 @@ static struct cpuidle_driver omap3430_id
 	.owner            = THIS_MODULE,
 	.states = {
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 110 + 162,
 			.target_residency = 5,
@@ -335,6 +345,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 106 + 180,
 			.target_residency = 309,
@@ -342,6 +353,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 107 + 410,
 			.target_residency = 46057,
@@ -349,6 +361,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU RET + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 121 + 3374,
 			.target_residency = 46057,
@@ -356,6 +369,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU OFF + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 855 + 1146,
 			.target_residency = 46057,
@@ -363,6 +377,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU RET + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 7580 + 4134,
 			.target_residency = 484329,
@@ -370,6 +385,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU OFF + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 7505 + 15274,
 			.target_residency = 484329,


