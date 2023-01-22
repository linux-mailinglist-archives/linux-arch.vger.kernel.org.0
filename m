Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DEA676AE1
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjAVCr5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjAVCrW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:47:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543A24481;
        Sat, 21 Jan 2023 18:46:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso3944605pjp.3;
        Sat, 21 Jan 2023 18:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfzaNmMXTvYjZaqBx5BRGh5/YKdqJuGZMdeNixaODzI=;
        b=CftyTjTfQaZlq6X+W/d9ddvb3E7GIsvuW56grnwYN/kjL2hPuns+Lv2zmf17h+Bz80
         gbHbRV1L8cabmqUYsjDWnLabuuY3Fs2fdwyNow7dZX5lYjA7hJmqoT1VL4JTMZwgf/iP
         xRTEsQOgqV0xsq+8+EjD22xPS0quK+jPa6L/Sy1KHJjQ+yHsp92f12rKF4U9gBbT2b9r
         gxvd53MiamSbL1spRy4c3k01MsHuL/cZQKZ8cO5DUN7B2AZQQFJ3RUYYXXw9gx4VS7mW
         BZA9YUfo9CWDXAMW8z4+5ZBTnla0ngLZLEzfeZ02prI0eganSll9A3Z4+ob8VlwpmvTp
         d6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfzaNmMXTvYjZaqBx5BRGh5/YKdqJuGZMdeNixaODzI=;
        b=sysE2oWkeupsYkoczfiePeBYTgchXDICspFd8cEqnveBs5iYg43/k7L+G1RHymQu21
         DvpzhDpi8b6n1rdcwMJUomqssvDGvOYAtZJPeAais7jQdCfOkpv7bRcWAQxeHNw33+f+
         +ONHlsfTIl7JA5sfsORG4/GlzijmUpYAtWctk1pnDlMghJCckNj0Z1PXmVU+KUx3KDVa
         yvy3JTwfFaMG9NFuRifvMDWUmVS78K/0sLk1up23ua/FMgQ2dHsqu/KyRcXIWuRxVo5f
         vs5vaO6BijxxAL9Dg4NbgIQA+0YTnVBdV//DvHxQ6BbYL04syxPAOZhN0Pc+VDHwDSNw
         fzhQ==
X-Gm-Message-State: AFqh2koMMVk6CeTfb4Zk4uZ1K3lrjodqjlVeF1/Dipuz3GnTnIdQhJbN
        HUOeBKR40ZldSWT4SODa6sQ=
X-Google-Smtp-Source: AMrXdXueHgf+64MbPOvUl3iPQC56zhsQqJoJWPq4Yf/nM88fQTLxW966nL9hfBqm61ZqY3d5YnD66Q==
X-Received: by 2002:a05:6a21:1646:b0:ac:29b4:11bc with SMTP id no6-20020a056a21164600b000ac29b411bcmr19655447pzb.21.1674355592364;
        Sat, 21 Jan 2023 18:46:32 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:31 -0800 (PST)
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
Subject: [RFC PATCH V3 15/16] x86/sev: optimize system vector processing invoked from #HV exception
Date:   Sat, 21 Jan 2023 21:46:05 -0500
Message-Id: <20230122024607.788454-16-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
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
index aec8dc4443d1..03af871f08e9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -412,6 +412,12 @@ SYM_CODE_START(\asmsym)
 
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
index 03d99fad9e76..b1a98c2a52f8 100644
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
@@ -214,51 +224,11 @@ static void do_exc_hv(struct pt_regs *regs)
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
@@ -376,6 +346,14 @@ static bool sev_restricted_injection_enabled(void)
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
@@ -403,6 +381,8 @@ void __init sev_snp_init_hv_handling(void)
 	apic_set_eoi_write(hv_doorbell_apic_eoi_write);
 
 	local_irq_restore(flags);
+
+	construct_sysvec_table();
 }
 
 static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2e0ee14229bf..aeadb4754b00 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -339,6 +339,13 @@ SECTIONS
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

