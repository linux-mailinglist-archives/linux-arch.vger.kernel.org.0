Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6F630B82
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiKSDtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiKSDrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAEDC1F4D;
        Fri, 18 Nov 2022 19:47:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b11so6099620pjp.2;
        Fri, 18 Nov 2022 19:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W/ga+rb85UmynzkXZMkLPydLwV3k2KVfEjUszZdz7c=;
        b=ebrGewTU3dV0JdfmvjHowccZWPmRVcYBZLJunNbUni+y/kT50wvLLKV9Pc/OY4a8lr
         GOx6f5iB6ijRkAP0uriXtwYPffZHvK9fD7YsVskKhD35gwgEjRsYzqenxgKQmM826+zA
         PBqZTkQlJROx7D+Od3YosIJ94/vnUQzF5rh+lz/ZCd+O6j3k2I5VI78JDFDCq+ZsF1Bo
         CeLLzO4KKZKB0CO9S+7eFSblaC05lgOCBpooWLkxjC0RGi2lRJJDc8HiwkNIXzqu1tGe
         BQbp1EtamcjmGw02qyFTpK5rcMFqSdJmYzyoni8rzy1vXhgjLz8W80yVgSgffLuckJ33
         O8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W/ga+rb85UmynzkXZMkLPydLwV3k2KVfEjUszZdz7c=;
        b=sf6rq4Cjm8/aQrY+Mm6BaWUtxF9UkQe5MOAzPY9MNDv7B5xKE/K9se6uV501BAYbtl
         ZUoRmAasGH6YbLrCHE5hLi1T2dlVzvUU6wcxbzjcAv3tdNRAwnxE00dUNodzveRKhNg3
         ptXvCGt6AO/+vLy248g5Z4MtL0M0/PsteHKiGZKnN9TH4t3H1t6kCW5+xJ4G1zVKYj/9
         bBO66KRpJkDv7lwA2Q4h9bNxsAgxVkcX1biTcfM7mKlwydavnSEwLG+mN0+kq1pzVK1S
         vO8Cxv0g29gb7wwFZdOoOyOP6B7RDHAhkT6FTIkD8aMTHfoyIWKkDlDfWBUIOWtLNSAZ
         /tjQ==
X-Gm-Message-State: ANoB5pmq0SQimO7EFRGjeN4HP7HrkIyj2Eax1gB4u4lMk5nNosf3zSHZ
        UsZBxumixxwNB18LAxR9EUw=
X-Google-Smtp-Source: AA0mqf6oEXz+pia7JgE20F2ViUK4iORI4m8VEQPx8Gm11vkvXbxytlN/XHDGShW1ePq7w3AsYYvORA==
X-Received: by 2002:a17:902:748b:b0:186:8111:adff with SMTP id h11-20020a170902748b00b001868111adffmr2423710pll.81.1668829621710;
        Fri, 18 Nov 2022 19:47:01 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:47:01 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V2 17/18] x86/sev: optimize system vector processing invoked from #HV exception
Date:   Fri, 18 Nov 2022 22:46:31 -0500
Message-Id: <20221119034633.1728632-18-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index fe460cf44ab5..05f4fcc60652 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -409,6 +409,12 @@ SYM_CODE_START(\asmsym)
 
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
index 23cd025f97dc..5a2f59022c98 100644
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
@@ -222,51 +232,11 @@ static void do_exc_hv(struct pt_regs *regs)
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
@@ -381,6 +351,14 @@ static bool sev_restricted_injection_enabled(void)
 	return sev_status & MSR_AMD64_SEV_RESTRICTED_INJECTION_ENABLED;
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
 	struct sev_snp_runtime_data *snp_data;
@@ -405,6 +383,8 @@ void __init sev_snp_init_hv_handling(void)
 	apic_set_eoi_write(hv_doorbell_apic_eoi_write);
 
 	local_irq_restore(flags);
+
+	construct_sysvec_table();
 }
 
 static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 15f29053cec4..160c7cdaa3de 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -322,6 +322,13 @@ SECTIONS
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

