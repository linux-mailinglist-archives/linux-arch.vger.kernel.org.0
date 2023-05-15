Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8450703596
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbjEORAG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbjEOQ7h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C397D93;
        Mon, 15 May 2023 09:59:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24df4ecdb87so8736421a91.0;
        Mon, 15 May 2023 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169970; x=1686761970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDqTF/fOVqtE1U4Nb2g4gjHAczzXhE+BziL/j2n+Nm0=;
        b=WJUgKGDZATb/N/lGfCNGID1DSBcd9WG5Gy/ITkBHMxAbs3QDkNpX9EauUpGd638a0g
         QraBGA1qxNQ56lyjw1yx40vsskbmdTIwtVOWmiA2HgJMGuqJBpc2A+U22f0XtjZAjLSD
         d9Xy8tyv3w+e41tIj40TKqWNcH+moar0e30O99oqMJPV5w5DEOuOhjtI/AqninDjFODQ
         X2F8UrNZzNKZEdM4QxOuvh919iRhlcwYrOUuDBZHFsF6EFN7/1WPSJV28DN7/aKTMv31
         b/VjejhXQ2w1lwkDZ6BqybeBC/614fEtSYblnzmWtTws/YnFeacXR9/BksbFEnVPzZw9
         l6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169970; x=1686761970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDqTF/fOVqtE1U4Nb2g4gjHAczzXhE+BziL/j2n+Nm0=;
        b=cWiAfLZ96yhVe2Sk/K8bA7qyQRYiWLFGmZoqt9bESuF5SPM6ofIWYZxgkmULziHX3i
         zUE0/gk+phrtRxlHXR91Kx+Umoxcwhs0d59V7M12MhD8yWXLyP+UTso4NhbVCx+dGowH
         wYnMlL1HbOTnNDy10HNn/oZE4vezDwKd0fTyuTjr8uRt6sorQqTh5IijX7LG86jPXl0w
         SA+l37VrsHw1+PLw4gIbVnrUK4TA4+L+XkfqK1kojRQmku4ELsro1qfjguM3p+xPnAIS
         iY7Ch5hdaOthkubuHLXSsy7mQoRezCG418Tkyw/6AzI04ZFMAX6rhxGSrhwXZXViHZ9R
         EtpQ==
X-Gm-Message-State: AC+VfDy4FJ7VmtGSilto4VhVkCiIRc2kOQ9vIJTtrWaGsez1pgBsYy8l
        1Aijy4KD4eBaYi2hVrapSGw=
X-Google-Smtp-Source: ACHHUZ4vo7Esr56dS1nxDrgMzjavv2V8cUANRiRo68X6dg8bP6ZM+3vwN4GbiUrMLco7ms59b1l/RA==
X-Received: by 2002:a17:90b:4a51:b0:247:5654:fcf3 with SMTP id lb17-20020a17090b4a5100b002475654fcf3mr33965931pjb.11.1684169970097;
        Mon, 15 May 2023 09:59:30 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:29 -0700 (PDT)
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
Subject: [RFC PATCH V6 04/14] x86/sev: optimize system vector processing invoked from #HV exception
Date:   Mon, 15 May 2023 12:59:06 -0400
Message-Id: <20230515165917.1306922-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
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
index 400ca555bd48..ac3d758670b3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -157,6 +157,16 @@ struct sev_snp_runtime_data {
 
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
@@ -228,51 +238,11 @@ static void do_exc_hv(struct pt_regs *regs)
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
@@ -398,6 +368,14 @@ static bool sev_restricted_injection_enabled(void)
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
@@ -422,6 +400,8 @@ void __init sev_snp_init_hv_handling(void)
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

