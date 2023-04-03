Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35EF6D4F75
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCRqI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjDCRow (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A830DD;
        Mon,  3 Apr 2023 10:44:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w4so28788424plg.9;
        Mon, 03 Apr 2023 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLIZsKwb/Fiqfvq7w/cI7yvHscawpRIWUMLmHd0mf5o=;
        b=fjf92n0dw0W70GKRm2BWERl2DClz3HWPZdXaAZrCpsGGp1/qKQjcrMcBf/68QUfoep
         KhTF2nrpMZ/aztYQVk0xk1diDf4ByJbqj9S0O7qi6ooTjs7pVhBrCX1QOfIBExHJhFtP
         R5PCeLyy8rqXPcNruoB/1ns6fxMSlrb+h86N5W0DxNeyvR/ErM8G3F7YlbwcK4lwNtI6
         79tJpJvGwOyXc8S83U4MDuCHd7dvJOh/7TvSCrGP/budNZ62Q0n2rBsPG3H+VAm5buKg
         7pZThddZN3D0k+ZtKe/rEL0AFYqkDiwvBK6Num+zN19GkcEI4Qy6Jtu+qVcq+KLjxxRs
         tiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLIZsKwb/Fiqfvq7w/cI7yvHscawpRIWUMLmHd0mf5o=;
        b=O2Rrx63N6Q/TOwCv5O5VZuPS5aVl/BeUEbmhY7Ey0ZNrBiF84RWkoFkptlZVAk1qx1
         JcKwetx4CfS42sLdeKkt3dUrsoYH+mRO+s6CYGyuNhZVCeTdvbBTuJMPL5U/czrcN5VC
         fXyXfEBs7D6sKlH5axyxK0oiX6IvFJ+oJ3yBcbTw18zMAa2UG8w6e4Q1fJPiawRriEdO
         hYVhPiOKvv9aQGe1vve4sZvcWy0PiSji2SEJdz+1ejyD3xPIg9fusjmYnJLD9K5658LA
         gbwyf99seyTn3sl3WQJ1mVtbY/epROV4m4LyfMHfGSvgeefkVuS+3xD5Wo8bl7On30nK
         b4Iw==
X-Gm-Message-State: AAQBX9dgrA0iI8L5ScYP2an5A/0Ju+X8uLGNO+flc9EI+dPfappycq35
        BqfZDFy4D7TruejEeZzbdq0=
X-Google-Smtp-Source: AKy350YHd0a+6UzrP8X+j2amAzAEzbG1MK2R+yLhVtWdREMB7NF1P6VBcNU7EOa8tGEveSjLCMRFnw==
X-Received: by 2002:a17:903:32c7:b0:1a2:8871:b419 with SMTP id i7-20020a17090332c700b001a28871b419mr21645144plr.23.1680543869792;
        Mon, 03 Apr 2023 10:44:29 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:29 -0700 (PDT)
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
Subject: [RFC PATCH V4 15/17] x86/sev: optimize system vector processing invoked from #HV exception
Date:   Mon,  3 Apr 2023 13:44:03 -0400
Message-Id: <20230403174406.4180472-16-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index efa56dfde19e..802fb6dec244 100644
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
index 7fcb3b548215..2c964f7ac7dc 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -151,6 +151,16 @@ struct sev_snp_runtime_data {
 
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
@@ -216,51 +226,11 @@ static void do_exc_hv(struct pt_regs *regs)
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
@@ -383,6 +353,14 @@ static bool sev_restricted_injection_enabled(void)
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
@@ -407,6 +385,8 @@ void __init sev_snp_init_hv_handling(void)
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

