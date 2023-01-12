Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8057F668099
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 21:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbjALT7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 14:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjALT7R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 14:59:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CFE21B1;
        Thu, 12 Jan 2023 11:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=grsvYP38q4MnN8oBsFSgy8h24Veck5RfPmpq2ugRYPM=; b=sAS+cVfJZnxSjVZ+cWnQizLCZi
        uzGVUsOf3anafnENfDcz5DBxNwmF2u/05pvc6A0c+OdcaX2m7Qx3mQCWD2r8+RXAQmr6AABwQQUqG
        Xnn1+diWHWxMGA10WHWQkPrlviiLNwKR8l/igNBPuc/Urss/XPLwrgEzGEkTLbJF2i3zM2wEUdQId
        iXvs8/Thb5QmoGtDr5BpPsofdym80GCpPly/+P1kmFfpKKXI1eKi4k9Kt5ZS1McOXBTe8WNh0qvx1
        Mira4VG3zNGY/eh9MdDKDjG1vDtIkJ7jl+e56WDxEl8scNd8fDZtJTeB77Tp7XyQzYbmD4z6YExxk
        sfEhC80A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG3hs-005P5E-9Z; Thu, 12 Jan 2023 19:57:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 360EB30347C;
        Thu, 12 Jan 2023 20:57:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E8FA2CD066EC; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195542.212914195@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 20:44:01 +0100
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
Subject: [PATCH v3 47/51] cpuidle: Ensure ct_cpuidle_enter() is always called from noinstr/__cpuidle
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

Tracing (kprobes included) and other compiler instrumentation relies
on a normal kernel runtime. Therefore all functions that disable RCU
should be noinstr, as should all functions that are called while RCU
is disabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle.c |   37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -137,11 +137,13 @@ int cpuidle_find_deepest_state(struct cp
 }
 
 #ifdef CONFIG_SUSPEND
-static void enter_s2idle_proper(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev, int index)
+static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
+					 struct cpuidle_device *dev, int index)
 {
-	ktime_t time_start, time_end;
 	struct cpuidle_state *target_state = &drv->states[index];
+	ktime_t time_start, time_end;
+
+	instrumentation_begin();
 
 	time_start = ns_to_ktime(local_clock());
 
@@ -152,13 +154,18 @@ static void enter_s2idle_proper(struct c
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
-	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE)) {
 		ct_cpuidle_enter();
+		/* Annotate away the indirect call */
+		instrumentation_begin();
+	}
 	target_state->enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		raw_local_irq_disable();
-	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE)) {
+		instrumentation_end();
 		ct_cpuidle_exit();
+	}
 	tick_unfreeze();
 	start_critical_timings();
 
@@ -166,6 +173,7 @@ static void enter_s2idle_proper(struct c
 
 	dev->states_usage[index].s2idle_time += ktime_us_delta(time_end, time_start);
 	dev->states_usage[index].s2idle_usage++;
+	instrumentation_end();
 }
 
 /**
@@ -200,8 +208,9 @@ int cpuidle_enter_s2idle(struct cpuidle_
  * @drv: cpuidle driver for this cpu
  * @index: index into the states table in @drv of the state to enter
  */
-int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
-			int index)
+noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
+				 struct cpuidle_driver *drv,
+				 int index)
 {
 	int entered_state;
 
@@ -209,6 +218,8 @@ int cpuidle_enter_state(struct cpuidle_d
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
 	ktime_t time_start, time_end;
 
+	instrumentation_begin();
+
 	/*
 	 * Tell the time framework to switch to a broadcast timer because our
 	 * local timer will be shut down.  If a local timer is used from another
@@ -235,15 +246,21 @@ int cpuidle_enter_state(struct cpuidle_d
 	time_start = ns_to_ktime(local_clock());
 
 	stop_critical_timings();
-	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE)) {
 		ct_cpuidle_enter();
+		/* Annotate away the indirect call */
+		instrumentation_begin();
+	}
 
 	entered_state = target_state->enter(dev, drv, index);
+
 	if (WARN_ONCE(!irqs_disabled(), "%ps leaked IRQ state", target_state->enter))
 		raw_local_irq_disable();
 
-	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE)) {
+		instrumentation_end();
 		ct_cpuidle_exit();
+	}
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
@@ -306,6 +323,8 @@ int cpuidle_enter_state(struct cpuidle_d
 		dev->states_usage[index].rejected++;
 	}
 
+	instrumentation_end();
+
 	return entered_state;
 }
 


