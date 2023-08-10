Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54B777DD7
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjHJQNW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbjHJQNH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:13:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971E3C32;
        Thu, 10 Aug 2023 09:04:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bcad794ad4so8395095ad.3;
        Thu, 10 Aug 2023 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683474; x=1692288274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7FB9Vxp0+WyI1KuAkoksmy5QM/XFX9os/58JlPRcHE=;
        b=glCwwTkjf8Uu+nfvqC8lsvnDKhodhaELn8VBqXmXLcfNlTORjbcxd7Exa7cXnJaXO5
         TE50A4LHkJrEpSIbgwS+NSoIxTrY4WEE9LoECNKDg2umt3tV2i5HswEzuhh1H7qYhZjk
         oZ4KS+Cbr7GC9l2G97C6MgEhAwlIUgNdBh0xVnK3bLYnPtDLCpKC/OdHkVzeeO5SfNe1
         W7hOINHFAtTYtpkgCASxySy/MVv96DymXFmiVPofBw/3oaeHzUIyC4auZWeClfqeted+
         DlHrBrwjqSIui+kqAleBllo8Oi1H60S8GH4gH7/9s9baZNPU1y8VWbtm5Jw3P/X2T48j
         81MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683474; x=1692288274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7FB9Vxp0+WyI1KuAkoksmy5QM/XFX9os/58JlPRcHE=;
        b=Fb9eel1m23mYGRvI7jy/HOWGcBmGksPw5Wvb9T5tIeCdlcG9Zh9udeaNn3OnW1e7ik
         792jOtIdmGc5xa8HVDVuwLhFUclMvg0ubOhOpJQdwtjF78po4qY1Kj9AVZo+khe90wP4
         p/HN+DhOK28SnVeZbFa+j4+rrhnyAyw97jeYBzQOBaWRoSbQf0OiqnV+1oG0WASQnZsV
         +/xhCSJX5z3vYTffy5HuMG+ny/Busjoaja23AD8TSs3BKVuqgtG7EclinFJlFu04vtxI
         Vmsl4DCdbFLsjw7N/uYnLeDldEB+DFgN6sGbJ5Rhh13NrG775+SHDuo9jg7DJ6b7PPGT
         KyJA==
X-Gm-Message-State: AOJu0YxR+uosQGdemIoYPApvlV7ktvlT2JYpVnSpXtFfSDcRQvnFQdHq
        9DdS6d+8t98rxnbRfE/FwWQ=
X-Google-Smtp-Source: AGHT+IG4WSiCPryeLT8UQTo/c5UBRxGIyGaTJhuwhevjMgjbBQLV3MrmKE9iihRvCJ3NoEelJxY6WQ==
X-Received: by 2002:a17:902:70c1:b0:1bb:a834:696 with SMTP id l1-20020a17090270c100b001bba8340696mr2212002plt.29.1691683474562;
        Thu, 10 Aug 2023 09:04:34 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:c620:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b895a17429sm1948821plo.280.2023.08.10.09.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:33 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V5 7/8] x86/hyperv: Add smp support for SEV-SNP guest
Date:   Thu, 10 Aug 2023 12:04:10 -0400
Message-Id: <20230810160412.820246-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810160412.820246-1-ltykernel@gmail.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
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

From: Tianyu Lan <tiala@microsoft.com>

In the AMD SEV-SNP guest, AP needs to be started up via sev es
save area and Hyper-V requires to call HVCALL_START_VP hypercall
to pass the gpa of sev es save area with AP's vp index and VTL(Virtual
trust level) parameters. Override wakeup_secondary_cpu_64 callback
with hv_snp_boot_ap.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c             | 100 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |  14 +++++
 arch/x86/kernel/cpu/mshyperv.c    |  13 +++-
 include/asm-generic/hyperv-tlfs.h |   1 +
 4 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b2b5cb19fac9..ee08a0cd6da3 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -18,11 +18,20 @@
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 #include <asm/mtrr.h>
+#include <asm/coco.h>
+#include <asm/io_apic.h>
+#include <asm/sev.h>
+#include <asm/realmode.h>
+#include <asm/e820/api.h>
+#include <asm/desc.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 #define GHCB_USAGE_HYPERV_CALL	1
 
+static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
+
 union hv_ghcb {
 	struct ghcb ghcb;
 	struct {
@@ -357,6 +366,97 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
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
index 07cad6c2af56..8dce3c8ce038 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -48,6 +48,13 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
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
@@ -232,12 +239,19 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
+<<<<<<< ours
+static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
+=======
+static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
+static inline void hv_sev_init_mem_and_cpu(void) {}
+>>>>>>> theirs
 #endif
 
 extern bool hv_isolation_type_snp(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5398fb2f4d39..c2ccb49b49c2 100644
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
@@ -502,8 +512,7 @@ static void __init ms_hyperv_init_platform(void)
 
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

