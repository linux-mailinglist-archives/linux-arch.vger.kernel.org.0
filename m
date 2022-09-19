Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D265BC843
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiISKVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 06:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiISKRu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 06:17:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A420322BEE;
        Mon, 19 Sep 2022 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rveYe0whW8HL+t/HGSaazkf4IJzq2XAc7vdeRKjh+gA=; b=DyFz/qHTNM/1mRCHIbJS7OwTB8
        S/KLJQER8Vj00sYb1K//4uQa9Vbf3Bm/RybCR+9MdNnB/0flyzx1hMwCgMip+O3gaajN5F6ipf5K/
        FnRgVFW+qSUhntfjVHXayN+eD8Ip7HOsp+oM15LdNW4kA9kz0hCqekQZGbUruGcxwzj6FGe3zmuIU
        29ApaydUL/8TRkvBFIvVAyOQZAfZIRHjc6NDooEbtCdl6Sxh0+89R2S5tbp/8j9+kY0MF1HEyVRiC
        nlsSpHgvqq5TTdV3ZaOfN1ewxlvNBx6/pld2xNYPQlTlNBHJO0GOeNY7fYTBjju2GOry7qCRQjel+
        Y/5wQ+hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaDq5-004b80-UG; Mon, 19 Sep 2022 10:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 221B2302F1C;
        Mon, 19 Sep 2022 12:16:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 45A1B2BABC0C2; Mon, 19 Sep 2022 12:16:22 +0200 (CEST)
Message-ID: <20220919101521.886766952@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Sep 2022 12:00:02 +0200
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
Subject: [PATCH v2 23/44] arm,smp: Remove trace_.*_rcuidle() usage
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

None of these functions should ever be ran with RCU disabled anymore.

Specifically, do_handle_IPI() is only called from handle_IPI() which
explicitly does irq_enter()/irq_exit() which ensures RCU is watching.

The problem with smp_cross_call() was, per commit 7c64cc0531fa ("arm: Use
_rcuidle for smp_cross_call() tracepoints"), that
cpuidle_enter_state_coupled() already had RCU disabled, but that's
long been fixed by commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
deeper into the idle path").

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/kernel/smp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -639,7 +639,7 @@ static void do_handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
+		trace_ipi_entry(ipi_types[ipinr]);
 
 	switch (ipinr) {
 	case IPI_WAKEUP:
@@ -686,7 +686,7 @@ static void do_handle_IPI(int ipinr)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+		trace_ipi_exit(ipi_types[ipinr]);
 }
 
 /* Legacy version, should go away once all irqchips have been converted */
@@ -709,7 +709,7 @@ static irqreturn_t ipi_handler(int irq,
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	trace_ipi_raise(target, ipi_types[ipinr]);
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 


