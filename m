Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4671A24B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjFAPRP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjFAPQ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48079193;
        Thu,  1 Jun 2023 08:16:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650352b89f6so430957b3a.0;
        Thu, 01 Jun 2023 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632598; x=1688224598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJrY+3BKhCyIpt2KlCOdPmzAbDXEeG+dEF3DJAIJD+A=;
        b=mgzXD40Bg2V4kgffJ67CzHxGDOY9pG/fBT5qMoTNokDaKDv8ZDmMHRZhDon390clXA
         SRp3Ke6ZdJ3bwm+3h7DLWn49rxO+ZfdExetnVmWJKR1jqxtwMhXMAfn9sZGGauA81Jp1
         mkyRrs/zCUP9FaisLYt+ARqVhaRW3y83quAuFr5G4vSnIAgfyG+S3IBc8OEqVsGr04Or
         eAQ5Cmojem9c7pkRe7u8XdPT9OlBPZc3k8bBkB9wEFdJLt55+OqHkqf1y7x/1oOBYAGq
         vyt3mhi2newu40VPgRBiXp3krcJ9RTmJfJzc5kcpyKYSdTPR89xuZkoOhRBzMGhmKn43
         HO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632598; x=1688224598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJrY+3BKhCyIpt2KlCOdPmzAbDXEeG+dEF3DJAIJD+A=;
        b=gbO6lMsKklvldrX++txST3ImaSH6ZdI5rPijupWDpIAhV3DQRnqNdSmLU67Yw00gBm
         p5sRzZ8lJOv6s3eDPXXsFmqnbUz1QfG+sqN3Z6II4pylT5KPGCJoVIcp2HrM9xOq4XUO
         kN3XEVFa+iv05pfofr2VjhsL8icPFMAFYiVrdOYmsZa8fPvkXaAWwGtPUMIOIzHkf6v4
         bFyBO+VGV7SIiPkPNDzhCkdTH767tluwdb+DMTuwclgAW16Zvd/L0ynfjTGn0cmD7AAi
         Npu6RmtYI3c/u9Oyk3Cuen+A9Z1botW3MB1I9zYzE2Hfb4LPMflvVIiL5ZFVVpGfZTou
         NbrQ==
X-Gm-Message-State: AC+VfDwQQg9PFDCqkM3Lvslm7KmD9SR4S+Wx1hE7LqUAFmoMROW67YWI
        e7LpJSI6VnT+/+t3xwoJL/c=
X-Google-Smtp-Source: ACHHUZ5E9WCd8VsDEv6XraP+Y6XRHWnoRA8wZcRMOS6f9J9VcssB9zZltzM34BuFjmLINY+7EUcBuA==
X-Received: by 2002:a05:6a20:7fa7:b0:10f:8499:1b75 with SMTP id d39-20020a056a207fa700b0010f84991b75mr8243045pzj.9.1685632597910;
        Thu, 01 Jun 2023 08:16:37 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:37 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 8/9] x86/hyperv: Add smp support for SEV-SNP guest
Date:   Thu,  1 Jun 2023 11:16:21 -0400
Message-Id: <20230601151624.1757616-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
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

From: Tianyu Lan <tiala@microsoft.com>

In the AMD SEV-SNP guest, AP needs to be started up via sev es
save area and Hyper-V requires to call HVCALL_START_VP hypercall
to pass the gpa of sev es save area with AP's vp index and VTL(Virtual
trust level) parameters. Override wakeup_secondary_cpu_64 callback
with hv_snp_boot_ap.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c             | 95 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |  9 +++
 arch/x86/kernel/cpu/mshyperv.c    | 13 ++++-
 include/asm-generic/hyperv-tlfs.h |  1 +
 4 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index e735507d0f54..238d73752dd8 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -22,11 +22,15 @@
 #include <asm/sev.h>
 #include <asm/realmode.h>
 #include <asm/e820/api.h>
+#include <asm/desc.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 #define GHCB_USAGE_HYPERV_CALL	1
 
+static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
+
 union hv_ghcb {
 	struct ghcb ghcb;
 	struct {
@@ -449,6 +453,97 @@ __init void hv_sev_init_mem_and_cpu(void)
 	}
 }
 
+#define hv_populate_vmcb_seg(seg, gdtr_base)			\
+do {								\
+	if (seg.selector) {					\
+		seg.base = 0;					\
+		seg.limit = HV_AP_SEGMENT_LIMIT;		\
+		seg.attrib = *(u16 *)(gdtr_base + seg.selector + 5);	\
+		seg.attrib = (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
+	}							\
+} while (0)							\
+
+int hv_snp_boot_ap(int cpu, unsigned long start_ip)
+{
+	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
+		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	struct desc_ptr gdtr;
+	u64 ret, rmp_adjust, retry = 5;
+	struct hv_enable_vp_vtl *start_vp_input;
+	unsigned long flags;
+
+	native_store_gdt(&gdtr);
+
+	vmsa->gdtr.base = gdtr.address;
+	vmsa->gdtr.limit = gdtr.size;
+
+	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
+	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
+
+	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
+	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
+
+	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
+	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
+
+	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
+	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
+
+	vmsa->efer = native_read_msr(MSR_EFER);
+
+	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
+	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
+	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
+
+	vmsa->xcr0 = 1;
+	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
+	vmsa->rip = (u64)secondary_startup_64_no_verify;
+	vmsa->rsp = (u64)&ap_start_stack[PAGE_SIZE];
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl = 0;
+	vmsa->sev_features = sev_status >> 2;
+
+	/*
+	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
+	 * using the RMPADJUST instruction. However, for the instruction to
+	 * succeed it must target the permissions of a lesser privileged
+	 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
+	 * instruction in the AMD64 APM Volume 3).
+	 */
+	rmp_adjust = RMPADJUST_VMSA_PAGE_BIT | 1;
+	ret = rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
+			rmp_adjust);
+	if (ret != 0) {
+		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
+		return ret;
+	}
+
+	local_irq_save(flags);
+	start_vp_input =
+		(struct hv_enable_vp_vtl *)ap_start_input_arg;
+	memset(start_vp_input, 0, sizeof(*start_vp_input));
+	start_vp_input->partition_id = -1;
+	start_vp_input->vp_index = cpu;
+	start_vp_input->target_vtl.target_vtl = ms_hyperv.vtl;
+	*(u64 *)&start_vp_input->vp_context = __pa(vmsa) | 1;
+
+	do {
+		ret = hv_do_hypercall(HVCALL_START_VP,
+				      start_vp_input, NULL);
+	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(ret))
+		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
+	return ret;
+}
+
 void __init hv_vtom_init(void)
 {
 	/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 7a9a6cdc2ae9..804c67475054 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -65,6 +65,13 @@ struct memory_map_entry {
 	u32 reserved;
 };
 
+/*
+ * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
+ * to start AP in enlightened SEV guest.
+ */
+#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define HV_AP_SEGMENT_LIMIT		0xffffffff
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
@@ -271,6 +278,7 @@ bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
 void hv_sev_init_mem_and_cpu(void);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
@@ -278,6 +286,7 @@ static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
 static inline void hv_sev_init_mem_and_cpu(void) {}
+static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 48b9eab3daf6..fd37f47de134 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -295,6 +295,16 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 
 	native_smp_prepare_cpus(max_cpus);
 
+	/*
+	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
+	 *  enlightened guest.
+	 */
+	if (hv_isolation_type_en_snp())
+		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
+
+	if (!hv_root_partition)
+		return;
+
 #ifdef CONFIG_X86_64
 	for_each_present_cpu(i) {
 		if (i == 0)
@@ -501,8 +511,7 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition)
-		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
+	smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
 	/*
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index f4e4cc4f965f..fdac4a1714ec 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -223,6 +223,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_PORT_ID		17
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
+#define HV_STATUS_TIME_OUT                      120
 #define HV_STATUS_VTL_ALREADY_ENABLED		134
 
 /*
-- 
2.25.1

