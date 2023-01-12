Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F066802B
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 20:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjALT7Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 14:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjALT6b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 14:58:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3D24E;
        Thu, 12 Jan 2023 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dY+sZF8zXVTImEusizdFam+mvD2uBaZ1sCttd0zpvx8=; b=j8TQ8t09IgELQKWksGBtI2ytKh
        pl1eHvaCJsnvxEv3UZnAHZzXY8/DatsPW/DvWOzGfrp159hq9PkH1R2mk80AkUwNnV23MbM3VXk9S
        aHTCDYPoAWwhIXCDoOhwZadFG8TpQgXTBYmBr06QAE/dQt/rsGspfhVNq70IDTtZ4SyL9C86jhQ8O
        iPmiqmKtWMiye8NF1XSccdlAXxBY2ADAcQ88Cq6GtXfD8ft+VpJQpX97vOLZQ2G+cqUvN1wEE5T0R
        eGidhLHEBJsPp8wG+NJ5bnTlafvqHcjiTkEwNapZjYTA4Pu5AO87/liDLgzA9SW6Le+OtcYoOojwJ
        RdV1d5uw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pG3he-005OgC-FK; Thu, 12 Jan 2023 19:57:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0FBA303457;
        Thu, 12 Jan 2023 20:57:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3A2002CCF62BF; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195541.477416709@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 20:43:49 +0100
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
Subject: [PATCH v3 35/51] trace,hardirq: No moar _rcuidle() tracing
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

Robot reported that trace_hardirqs_{on,off}() tickle the forbidden
_rcuidle() tracepoint through local_irq_{en,dis}able().

For 'sane' configs, these calls will only happen with RCU enabled and
as such can use the regular tracepoint. This also means it's possible
to trace them from NMI context again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace_preemptirq.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -20,6 +20,15 @@
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
 /*
+ * ...
+ */
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#define trace(point)	trace_##point
+#else
+#define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
+#endif
+
+/*
  * Like trace_hardirqs_on() but without the lockdep invocation. This is
  * used in the low level entry code where the ordering vs. RCU is important
  * and lockdep uses a staged approach which splits the lockdep hardirq
@@ -28,8 +37,7 @@ static DEFINE_PER_CPU(int, tracing_irq_c
 void trace_hardirqs_on_prepare(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -40,8 +48,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_prepar
 void trace_hardirqs_on(void)
 {
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
-			trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_enable)(CALLER_ADDR0, CALLER_ADDR1);
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -63,8 +70,7 @@ void trace_hardirqs_off_finish(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 
 }
@@ -78,8 +84,7 @@ void trace_hardirqs_off(void)
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
-		if (!in_nmi())
-			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
+		trace(irq_disable)(CALLER_ADDR0, CALLER_ADDR1);
 	}
 }
 EXPORT_SYMBOL(trace_hardirqs_off);


