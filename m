Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361B5BC88F
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiISKV7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiISKR4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 06:17:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F522BEB;
        Mon, 19 Sep 2022 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qeP5TW9pPwNmun+WKlC/DjHHSTDp0gQF0cfrlfUPbu0=; b=GUjNE5F0Y2PTZQyBjYcZZQyfIY
        o10NohuUOmP0Se3tuwt+mZXT1hGRNK5CGZStjItvyMGkJrGiclWBhtSkJb0QLL0eaPJ8M9M25L5S3
        h8RuPus74/eSIerE4a1LP/Lqij4WU3nZxoMfY3eqapRQTeR49iDMFDMMZwZKd+WpEnH2S8i8pu2aR
        LQ0/Ju4u3Q7GytTGjg74VG0Rmm7JMkh5rxZo5vhHGU43eY4281Nvjq9JFzRqioj1iIiLdgpt599dA
        lic7Z9caX4wSpoMwY+baJQksUBkbg5+ASXDjzrmhQlGn4NSzA5AZxQaFGoM87rxjLSi8dh5ZwC3J6
        +/tHjSyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaDq8-004bA4-CU; Mon, 19 Sep 2022 10:17:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E3E7302F46;
        Mon, 19 Sep 2022 12:16:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 690642BAC75A9; Mon, 19 Sep 2022 12:16:22 +0200 (CEST)
Message-ID: <20220919101522.358582588@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 19 Sep 2022 12:00:09 +0200
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
Subject: [PATCH v2 30/44] cpuidle,xenpv: Make more PARAVIRT_XXL noinstr clean
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

vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0xde: call to wbinvd() leaves .noinstr.text section
vmlinux.o: warning: objtool: default_idle+0x4: call to arch_safe_halt() leaves .noinstr.text section
vmlinux.o: warning: objtool: xen_safe_halt+0xa: call to HYPERVISOR_sched_op.constprop.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
---
 arch/x86/include/asm/paravirt.h      |    6 ++++--
 arch/x86/include/asm/special_insns.h |    4 ++--
 arch/x86/include/asm/xen/hypercall.h |    2 +-
 arch/x86/kernel/paravirt.c           |   14 ++++++++++++--
 arch/x86/xen/enlighten_pv.c          |    2 +-
 arch/x86/xen/irq.c                   |    2 +-
 6 files changed, 21 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -168,7 +168,7 @@ static inline void __write_cr4(unsigned
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static inline void arch_safe_halt(void)
+static __always_inline void arch_safe_halt(void)
 {
 	PVOP_VCALL0(irq.safe_halt);
 }
@@ -178,7 +178,9 @@ static inline void halt(void)
 	PVOP_VCALL0(irq.halt);
 }
 
-static inline void wbinvd(void)
+extern noinstr void pv_native_wbinvd(void);
+
+static __always_inline void wbinvd(void)
 {
 	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
 }
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -115,7 +115,7 @@ static inline void wrpkru(u32 pkru)
 }
 #endif
 
-static inline void native_wbinvd(void)
+static __always_inline void native_wbinvd(void)
 {
 	asm volatile("wbinvd": : :"memory");
 }
@@ -179,7 +179,7 @@ static inline void __write_cr4(unsigned
 	native_write_cr4(x);
 }
 
-static inline void wbinvd(void)
+static __always_inline void wbinvd(void)
 {
 	native_wbinvd();
 }
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -382,7 +382,7 @@ MULTI_stack_switch(struct multicall_entr
 }
 #endif
 
-static inline int
+static __always_inline int
 HYPERVISOR_sched_op(int cmd, void *arg)
 {
 	return _hypercall2(int, sched_op, cmd, arg);
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -233,6 +233,11 @@ static noinstr void pv_native_set_debugr
 	native_set_debugreg(regno, val);
 }
 
+noinstr void pv_native_wbinvd(void)
+{
+	native_wbinvd();
+}
+
 static noinstr void pv_native_irq_enable(void)
 {
 	native_irq_enable();
@@ -242,6 +247,11 @@ static noinstr void pv_native_irq_disabl
 {
 	native_irq_disable();
 }
+
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
 #endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -273,7 +283,7 @@ struct paravirt_patch_template pv_ops =
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
-	.cpu.wbinvd		= native_wbinvd,
+	.cpu.wbinvd		= pv_native_wbinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
 	.cpu.read_msr_safe	= native_read_msr_safe,
@@ -307,7 +317,7 @@ struct paravirt_patch_template pv_ops =
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
-	.irq.safe_halt		= native_safe_halt,
+	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
 #endif /* CONFIG_PARAVIRT_XXL */
 
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1019,7 +1019,7 @@ static const typeof(pv_ops) xen_cpu_ops
 
 		.write_cr4 = xen_write_cr4,
 
-		.wbinvd = native_wbinvd,
+		.wbinvd = pv_native_wbinvd,
 
 		.read_msr = xen_read_msr,
 		.write_msr = xen_write_msr,
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -24,7 +24,7 @@ noinstr void xen_force_evtchn_callback(v
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
 
-static void xen_safe_halt(void)
+static noinstr void xen_safe_halt(void)
 {
 	/* Blocking includes an implicit local_irq_enable(). */
 	if (HYPERVISOR_sched_op(SCHEDOP_block, NULL) != 0)


