Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA56F2F8C
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjEAI70 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjEAI6e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:58:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF201BE8;
        Mon,  1 May 2023 01:57:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a814fe0ddeso23141085ad.2;
        Mon, 01 May 2023 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931470; x=1685523470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sETQK8RjhVsgIajuVOBT7+FI6vT6vJ37bjN6FDEcyA=;
        b=C/iU8ACLnuOD9qFnz6IALxfJtg5iuvllq+tnhyAXeX1mkBQ2z9QJIS626TSQL30SKX
         FH9joSl+/RitbSY4sITqOTUB4N7ITQrDvULKQ4Wsk/1Sj72VZfb6cIy9Lqp+z8H2Alzo
         VIK/UnvOvUMniBTeHD5tBw5Bop/GTQxMSqVcRnUwH+UGTnXmLM4d6EPv9rqmlX3fBArd
         harTT0Z7qj/uWShBHZSu4iou6AKNWenKRL9BhQpRPreip2rpvS2T3kT0FLk0k8NRpOtY
         b7H2FNIA0lpccxk9FbIhIWndKcog+KA252SpPkZTmMnzQPFaPT7+BL9+B6PhgRBvQ0Jd
         gDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931470; x=1685523470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sETQK8RjhVsgIajuVOBT7+FI6vT6vJ37bjN6FDEcyA=;
        b=BD7fPJerXm2JNyIhu6fPkjnsNo89Psnz8uWK6+ChqJcDt3txLp7Aaqi8ruoFkB6yR+
         w2y6W+dQ7oCvM3BzosewfIYT602SARzojNVd8nvJwufeH0jqT7m1xdaOqHPj03kLW3xS
         drsia9bCoUa8mqorxGw/zTVi0J7stDjhCjoWoUMfq9g/bydru7rgu+0S7KTwKBykQRlL
         65QuyB3pTDKArqCkuM6F4G/PJv+JgB4O7MaFrp2E9JIFyEJyHiTi7NuxWERCVz99QIHN
         Q/5p4N3UXgUlfwXnIgVbRQoQuc+VBemURox6+jdU/uTh1i2Ex9lo5tW+kn4LHKrKgFgu
         pVtg==
X-Gm-Message-State: AC+VfDxnwrsvVKd7DyZw8rTcQC3yl8L2sFOeQZ+nVcMBHqL25qNc6Wp9
        FukCfqSfLqM3FrC+aEmMSTY6SU+DarK9Sg==
X-Google-Smtp-Source: ACHHUZ4kXFKQeoxBoIYVEn+wH4u/FMzRthp9bUneus6Mw8YwcAgdiPNdbHUVpmXhaEcbHL/aXNwjeA==
X-Received: by 2002:a17:903:1c2:b0:1a6:dfb3:5f4b with SMTP id e2-20020a17090301c200b001a6dfb35f4bmr15071450plh.55.1682931469725;
        Mon, 01 May 2023 01:57:49 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:49 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V5 14/15] x86/sev: optimize system vector processing invoked from #HV exception
Date:   Mon,  1 May 2023 04:57:24 -0400
Message-Id: <20230501085726.544209-15-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Construct system vector table and dispatch system vector exceptions through
sysvec_table from #HV exception handler instead of explicitly calling each
system vector. The system vector table is created dynamically and is placed
in a new named ELF section.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/entry/entry_64.S     |  6 +++
 arch/x86/kernel/sev.c         | 70 +++++++++++++----------------------
 arch/x86/kernel/vmlinux.lds.S |  7 ++++
 3 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 147b850babf6..f86b319d0a9e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -419,6 +419,12 @@ SYM_CODE_START(\asmsym)
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
+	.if \vector >= FIRST_SYSTEM_VECTOR && \vector < NR_VECTORS
+		.section .system_vectors, "aw"
+		.byte \vector
+		.quad \cfunc
+		.previous
+	.endif
 .endm
 
 /*
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b6dafeb0edbe..b6becf158598 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -153,6 +153,16 @@ struct sev_snp_runtime_data {
 
 static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
 
+static void (*sysvec_table[NR_VECTORS - FIRST_SYSTEM_VECTOR])
+		(struct pt_regs *regs) __ro_after_init;
+
+struct sysvec_entry {
+	unsigned char vector;
+	void (*sysvec_func)(struct pt_regs *regs);
+} __packed;
+
+extern struct sysvec_entry __system_vectors[], __system_vectors_end[];
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
@@ -218,51 +228,11 @@ static void do_exc_hv(struct pt_regs *regs)
 		} else if (pending_events.vector == IA32_SYSCALL_VECTOR) {
 			WARN(1, "syscall shouldn't happen\n");
 		} else if (pending_events.vector >= FIRST_SYSTEM_VECTOR) {
-			switch (pending_events.vector) {
-#if IS_ENABLED(CONFIG_HYPERV)
-			case HYPERV_STIMER0_VECTOR:
-				sysvec_hyperv_stimer0(regs);
-				break;
-			case HYPERVISOR_CALLBACK_VECTOR:
-				sysvec_hyperv_callback(regs);
-				break;
-#endif
-#ifdef CONFIG_SMP
-			case RESCHEDULE_VECTOR:
-				sysvec_reschedule_ipi(regs);
-				break;
-			case IRQ_MOVE_CLEANUP_VECTOR:
-				sysvec_irq_move_cleanup(regs);
-				break;
-			case REBOOT_VECTOR:
-				sysvec_reboot(regs);
-				break;
-			case CALL_FUNCTION_SINGLE_VECTOR:
-				sysvec_call_function_single(regs);
-				break;
-			case CALL_FUNCTION_VECTOR:
-				sysvec_call_function(regs);
-				break;
-#endif
-#ifdef CONFIG_X86_LOCAL_APIC
-			case ERROR_APIC_VECTOR:
-				sysvec_error_interrupt(regs);
-				break;
-			case SPURIOUS_APIC_VECTOR:
-				sysvec_spurious_apic_interrupt(regs);
-				break;
-			case LOCAL_TIMER_VECTOR:
-				sysvec_apic_timer_interrupt(regs);
-				break;
-			case X86_PLATFORM_IPI_VECTOR:
-				sysvec_x86_platform_ipi(regs);
-				break;
-#endif
-			case 0x0:
-				break;
-			default:
-				panic("Unexpected vector %d\n", vector);
-				unreachable();
+			if (!(sysvec_table[pending_events.vector - FIRST_SYSTEM_VECTOR])) {
+				WARN(1, "system vector entry 0x%x is NULL\n",
+				     pending_events.vector);
+			} else {
+				(*sysvec_table[pending_events.vector - FIRST_SYSTEM_VECTOR])(regs);
 			}
 		} else {
 			common_interrupt(regs, pending_events.vector);
@@ -385,6 +355,14 @@ static bool sev_restricted_injection_enabled(void)
 	return sev_status & MSR_AMD64_SNP_RESTRICTED_INJ;
 }
 
+static void __init construct_sysvec_table(void)
+{
+	struct sysvec_entry *p;
+
+	for (p = __system_vectors; p < __system_vectors_end; p++)
+		sysvec_table[p->vector - FIRST_SYSTEM_VECTOR] = p->sysvec_func;
+}
+
 void __init sev_snp_init_hv_handling(void)
 {
 	struct sev_es_runtime_data *data;
@@ -409,6 +387,8 @@ void __init sev_snp_init_hv_handling(void)
 	apic_set_eoi_write(hv_doorbell_apic_eoi_write);
 
 	local_irq_restore(flags);
+
+	construct_sysvec_table();
 }
 
 static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 25f155205770..c37165d8e877 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -338,6 +338,13 @@ SECTIONS
 		*(.altinstr_replacement)
 	}
 
+	. = ALIGN(8);
+	.system_vectors : AT(ADDR(.system_vectors) - LOAD_OFFSET) {
+		__system_vectors = .;
+		*(.system_vectors)
+		__system_vectors_end = .;
+	}
+
 	. = ALIGN(8);
 	.apicdrivers : AT(ADDR(.apicdrivers) - LOAD_OFFSET) {
 		__apicdrivers = .;
-- 
2.25.1

