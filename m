Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213E9780A23
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376306AbjHRKaH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 06:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376260AbjHRK3f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 06:29:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDF2710;
        Fri, 18 Aug 2023 03:29:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68890d565b5so606207b3a.2;
        Fri, 18 Aug 2023 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354573; x=1692959373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwA8HYLzkcSN4hg78edlIWAIgc2T+ot9OaVYc9FXVKQ=;
        b=gxG1mtmj2CdGowcPzuEsRTmBwvPmXh0QBxN3pMUmTgbvP7a5IqqDW+DFxP+BEenddU
         PHR/IBs1a8hy3/L/KfBa/upQqN39xgVq3R8/WD6+QsIneWiY+34oPTsMqe72xiA/Tg87
         +ZBHj7XojPH8eARCTlgbDBXjdBRrs37UobjbIAAeHOJ9Ob2GQvUlfqoA4d98m/1OXs5Z
         0RdPnHQ3Q1aeTb3YERBtakUxDzRZBYHl0Pl2VDwc8PT4OeDttlp9L6FsIK0VRahXvCC1
         qyONp7480rAzajNpbtHpnxGcnydlKTVzHmQH51KWHuztdmw7LAlBLnsFSNttW9qJOaNv
         B29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354573; x=1692959373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwA8HYLzkcSN4hg78edlIWAIgc2T+ot9OaVYc9FXVKQ=;
        b=bIf/WMy3+FV9WiECSU+LJPFpWKuAyZU0COXlAIl+fg4RQs4IeGx9Lo4hodlyCL6AJ/
         KdAA2fqCNqxMwVRJ7zMuFKC0+IYsvUDZcgslJAo7qa17MotRy/JcUHUvLzDPzaZ1cwIV
         47/TVfZyr9SO3x//UjFsiAa97Ydunr1jKEiQrm33SkVerEBLGukKTxX3ciTHm6MngJ9q
         KQYYQ6n5LDBeCHM3mTUMa0KizrsYzYEuw33MAhdbkmcbTf35fBeUcbsf3QG5iqsMTYi3
         a+X+S7+HFmbKmaXjBzSyq6h0HBo8klRNkPi6mvAi/qK1Fyq/fZhsF+tlNO2khsQwa0GK
         6BHA==
X-Gm-Message-State: AOJu0YzGSBLYDa6G5XozjEVvIPQEjWF6HniYNibJIuTcs/OGkSG04qoU
        2HFRgkuu9L1pjs/BjngcFKQ=
X-Google-Smtp-Source: AGHT+IEKwJipxXoxGRqhBBwwseXfs5bqQyUtWmdy8Xf7Bzsi/xUAOH904ECw2ygG//6SpXH/V3dIjA==
X-Received: by 2002:a05:6a20:8421:b0:140:730b:4b3f with SMTP id c33-20020a056a20842100b00140730b4b3fmr3234474pzd.1.1692354573128;
        Fri, 18 Aug 2023 03:29:33 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:4545:4938:97f0:2e1f])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001b9be79729csm1386766plt.165.2023.08.18.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:32 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v7 7/8] x86/hyperv: Add smp support for SEV-SNP guest
Date:   Fri, 18 Aug 2023 06:29:17 -0400
Message-Id: <20230818102919.1318039-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818102919.1318039-1-ltykernel@gmail.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c             | 138 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |   8 ++
 arch/x86/kernel/cpu/mshyperv.c    |  11 ++-
 include/asm-generic/hyperv-tlfs.h |   1 +
 4 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b2b5cb19fac9..cbbd3af4c3da 100644
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
@@ -56,6 +65,8 @@ union hv_ghcb {
 	} hypercall;
 } __packed __aligned(HV_HYP_PAGE_SIZE);
 
+static DEFINE_PER_CPU(struct sev_es_save_area *, hv_sev_vmsa);
+
 static u16 hv_ghcb_version __ro_after_init;
 
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
@@ -357,6 +368,133 @@ static bool hv_is_private_mmio(u64 addr)
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
+static int snp_set_vmsa(void *va, bool vmsa)
+{
+	u64 attrs;
+
+	/*
+	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
+	 * using the RMPADJUST instruction. However, for the instruction to
+	 * succeed it must target the permissions of a lesser privileged
+	 * (higher numbered) VMPL level, so use VMPL1 (refer to the RMPADJUST
+	 * instruction in the AMD64 APM Volume 3).
+	 */
+	attrs = 1;
+	if (vmsa)
+		attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+}
+
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
+{
+	int err;
+
+	err = snp_set_vmsa(vmsa, false);
+	if (err)
+		pr_err("clear VMSA page failed (%u), leaking page\n", err);
+	else
+		free_page((unsigned long)vmsa);
+}
+
+int hv_snp_boot_ap(int cpu, unsigned long start_ip)
+{
+	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
+		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	struct sev_es_save_area *cur_vmsa;
+	struct desc_ptr gdtr;
+	u64 ret, retry = 5;
+	struct hv_enable_vp_vtl *start_vp_input;
+	unsigned long flags;
+
+	if (!vmsa)
+		return -ENOMEM;
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
+	ret = snp_set_vmsa(vmsa, true);
+	if (!ret) {
+		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
+		free_page((u64)vmsa);
+		return ret;
+	}
+
+	local_irq_save(flags);
+	start_vp_input = (struct hv_enable_vp_vtl *)ap_start_input_arg;
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
+	if (!hv_result_success(ret)) {
+		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
+		snp_cleanup_vmsa(vmsa);
+		vmsa = NULL;
+	}
+
+	cur_vmsa = per_cpu(hv_sev_vmsa, cpu);
+	/* Free up any previous VMSA page */
+	if (cur_vmsa)
+		snp_cleanup_vmsa(cur_vmsa);
+
+	/* Record the current VMSA page */
+	per_cpu(hv_sev_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
 void __init hv_vtom_init(void)
 {
 	/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 8660d6bca6f2..6bd9ae04d9c3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -49,6 +49,12 @@ extern u64 hv_current_partition_id;
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 extern bool hv_isolation_type_en_snp(void);
+/*
+ * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
+ * to start AP in enlightened SEV guest.
+ */
+#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define HV_AP_SEGMENT_LIMIT		0xffffffff
 
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
@@ -256,12 +262,14 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
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
+static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
 #endif
 
 extern bool hv_isolation_type_snp(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5398fb2f4d39..c56fc151b8db 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -295,6 +295,15 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 
 	native_smp_prepare_cpus(max_cpus);
 
+	/*
+	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
+	 *  enlightened guest.
+	 */
+	if (hv_isolation_type_en_snp()) {
+		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
+		return;
+	}
+
 #ifdef CONFIG_X86_64
 	for_each_present_cpu(i) {
 		if (i == 0)
@@ -502,7 +511,7 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition)
+	if (hv_root_partition || hv_isolation_type_en_snp())
 		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
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

