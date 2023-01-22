Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC7676ACE
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjAVCrJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjAVCqi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:38 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9A244B2;
        Sat, 21 Jan 2023 18:46:26 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g205so6572333pfb.6;
        Sat, 21 Jan 2023 18:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKsYBhUiGWrJMP3oFh0QsZHqdKYC98gA0Kk1SEN2638=;
        b=JnyU3r5P59FIt0CzVytNJkRp0yv4FvnJi+puDlVTnHlbTW30gMAqMTGfyk5dh1/FDL
         HXC796YPVPqCuL9Fxr2/Aa0WC9N2c+Ob5Hzm9net0UO8zx+nP3ERYRkqHUsraCzaD7nT
         nqMbrkX+tqCm4ULlvjkl29za3bTS1MycHhhBRgnZq+HvcklygSZ1wCxSIOI5ZnW2bWxa
         wDEGtx3LjNIznCCVLGmov0EK/1VN47CrYqJCZx79A43w67k5wwAm2GE8sI25BMAlK2iu
         95eS/DrrxBFJA9iwmHXck0J+kFxZ021jXHW1tnTFJ5kMZPXHyyWpiaP5v3MjUJv7AYFT
         LZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKsYBhUiGWrJMP3oFh0QsZHqdKYC98gA0Kk1SEN2638=;
        b=wIwU0uWmMpNXxR1IUDXY++t6tpLZcqALiAFbJ5u7hJowqqm2g5O6KoLKG1fI1eqsQq
         mp1bD9aeGrBmaibwYeUN0r0quWZ/2zY/B3N2Z7P9U7jrNG1oN3GPZwtE4PDdRxcXbIE9
         JZ+kUSYwVCxWf/+7aYHHwbhCu05iQCsaoq4QC/ILiMCxukiY13W7npla92TOBXhYnTnJ
         5EB7cIcsFzxlmjfmaG4u+m6c1oRgFmQcLhbShNPjZQQfnA9VXQtS4Di19dXnEE3cWgr+
         WcbJxOj3SbWRaEtwmjvc3EYexvZVKPYicPT7LAVBF6zpehpS3UEtGjceEsx7S+r1dAY7
         93zA==
X-Gm-Message-State: AFqh2kqGxWr+/LZ2WREoI9Vm/KmZG+jOZHVltpKJhileNA2VCTUaUjbj
        VimEyQfCHgekJ82kDS5eBr8=
X-Google-Smtp-Source: AMrXdXvLmUN6lR8nFN7+4RUYdAxz/QQvP+Aa6TuqEw12tMBhTByU1S1Dr4pnYS1XLpoXoav9wkKJOw==
X-Received: by 2002:a62:e80e:0:b0:576:1c37:5720 with SMTP id c14-20020a62e80e000000b005761c375720mr22999361pfi.4.1674355585672;
        Sat, 21 Jan 2023 18:46:25 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:25 -0800 (PST)
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
Subject: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp guest
Date:   Sat, 21 Jan 2023 21:46:00 -0500
Message-Id: <20230122024607.788454-11-ltykernel@gmail.com>
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

From: Tianyu Lan <tiala@microsoft.com>

The wakeup_secondary_cpu callback was populated with wakeup_
cpu_via_vmgexit() which doesn't work for Hyper-V. Override it
with Hyper-V specific hook which uses HVCALL_START_VIRTUAL_
PROCESSOR hvcall to start AP with vmsa data structure.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC v2:
       * Add helper function to initialize segment
       * Fix some coding style
---
 arch/x86/include/asm/mshyperv.h   |   2 +
 arch/x86/include/asm/sev.h        |  13 ++++
 arch/x86/include/asm/svm.h        |  47 +++++++++++++
 arch/x86/kernel/cpu/mshyperv.c    | 112 ++++++++++++++++++++++++++++--
 include/asm-generic/hyperv-tlfs.h |  19 +++++
 5 files changed, 189 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 7266d71d30d6..c69051eec0e1 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -203,6 +203,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
+int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void hv_ghcb_msr_write(u64 msr, u64 value);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271bb6d8e..e34aaf730220 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -86,6 +86,19 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
+union sev_rmp_adjust {
+	u64 as_uint64;
+	struct {
+		unsigned long target_vmpl : 8;
+		unsigned long enable_read : 1;
+		unsigned long enable_write : 1;
+		unsigned long enable_user_execute : 1;
+		unsigned long enable_kernel_execute : 1;
+		unsigned long reserved1 : 4;
+		unsigned long vmsa : 1;
+	};
+};
+
 /* SNP Guest message request */
 struct snp_req_data {
 	unsigned long req_gpa;
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index cb1ee53ad3b1..f8b321a11ee4 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -336,6 +336,53 @@ struct vmcb_save_area {
 	u64 last_excp_to;
 	u8 reserved_0x298[72];
 	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+	u8 reserved_7b[4];
+	u32 pkru;
+	u8 reserved_7a[20];
+	u64 reserved_8;		/* rax already available at 0x01f8 */
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u64 reserved_9;		/* rsp already available at 0x01d8 */
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_10[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	union {
+		u64 sev_features;
+		struct {
+			u64 sev_feature_snp			: 1;
+			u64 sev_feature_vtom			: 1;
+			u64 sev_feature_reflectvc		: 1;
+			u64 sev_feature_restrict_injection	: 1;
+			u64 sev_feature_alternate_injection	: 1;
+			u64 sev_feature_full_debug		: 1;
+			u64 sev_feature_reserved1		: 1;
+			u64 sev_feature_snpbtb_isolation	: 1;
+			u64 sev_feature_resrved2		: 56;
+		};
+	};
+	u64 vintr_ctrl;
+	u64 guest_error_code;
+	u64 virtual_tom;
+	u64 tlb_id;
+	u64 pcpu_id;
+	u64 event_inject;
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
 } __packed;
 
 /* Save area definition for SEV-ES and SEV-SNP guests */
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 197c8f2ec4eb..9d547751a1a7 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -39,6 +39,13 @@
 #include <asm/realmode.h>
 #include <asm/e820/api.h>
 
+/*
+ * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
+ * to start AP in enlightened SEV guest.
+ */
+#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define HV_AP_SEGMENT_LIMIT		0xffffffff
+
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
 struct ms_hyperv_info ms_hyperv;
@@ -230,6 +237,94 @@ static void __init hv_smp_prepare_boot_cpu(void)
 #endif
 }
 
+static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
+
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
+	struct vmcb_save_area *vmsa = (struct vmcb_save_area *)
+		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	struct desc_ptr gdtr;
+	u64 ret, retry = 5;
+	struct hv_start_virtual_processor_input *start_vp_input;
+	union sev_rmp_adjust rmp_adjust;
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
+	vmsa->sev_feature_snp = 1;
+	vmsa->sev_feature_restrict_injection = 1;
+
+	rmp_adjust.as_uint64 = 0;
+	rmp_adjust.target_vmpl = 1;
+	rmp_adjust.vmsa = 1;
+	ret = rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
+			rmp_adjust.as_uint64);
+	if (ret != 0) {
+		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
+		return ret;
+	}
+
+	local_irq_save(flags);
+	start_vp_input =
+		(struct hv_start_virtual_processor_input *)ap_start_input_arg;
+	memset(start_vp_input, 0, sizeof(*start_vp_input));
+	start_vp_input->partitionid = -1;
+	start_vp_input->vpindex = cpu;
+	start_vp_input->targetvtl = ms_hyperv.vtl;
+	*(u64 *)&start_vp_input->context[0] = __pa(vmsa) | 1;
+
+	do {
+		ret = hv_do_hypercall(HVCALL_START_VIRTUAL_PROCESSOR,
+				      start_vp_input, NULL);
+	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
+
+	if (!hv_result_success(ret)) {
+		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
+		goto done;
+	}
+
+done:
+	local_irq_restore(flags);
+	return ret;
+}
+
 static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 {
 #ifdef CONFIG_X86_64
@@ -239,6 +334,16 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 
 	native_smp_prepare_cpus(max_cpus);
 
+	/*
+	 *  Override wakeup_secondary_cpu callback for SEV-SNP
+	 *  enlightened guest.
+	 */
+	if (hv_isolation_type_en_snp())
+		apic->wakeup_secondary_cpu = hv_snp_boot_ap;
+
+	if (!hv_root_partition)
+		return;
+
 #ifdef CONFIG_X86_64
 	for_each_present_cpu(i) {
 		if (i == 0)
@@ -475,8 +580,7 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition)
-		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
+	smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
 	/*
@@ -501,7 +605,7 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
-	if (isolation_type_en_snp()) {
+	if (hv_isolation_type_en_snp()) {
 		/*
 		 * Hyper-V enlightened snp guest boots kernel
 		 * directly without bootloader and so roms,
@@ -511,7 +615,7 @@ static void __init ms_hyperv_init_platform(void)
 		x86_platform.legacy.rtc = 0;
 		x86_platform.set_wallclock = set_rtc_noop;
 		x86_platform.get_wallclock = get_rtc_noop;
-		x86_platform.legacy.reserve_bios_regions = x86_init_noop;
+		x86_platform.legacy.reserve_bios_regions = 0;
 		x86_init.resources.probe_roms = x86_init_noop;
 		x86_init.resources.reserve_resources = x86_init_noop;
 		x86_init.mpparse.find_smp_config = x86_init_noop;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index c1cc3ec36ad5..3d7c67be9f56 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -148,6 +148,7 @@ union hv_reference_tsc_msr {
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
 #define HVCALL_SEND_IPI				0x000b
+#define HVCALL_ENABLE_VP_VTL			0x000f
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
 #define HVCALL_SEND_IPI_EX			0x0015
@@ -165,6 +166,7 @@ union hv_reference_tsc_msr {
 #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
 #define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
@@ -219,6 +221,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_PORT_ID		17
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
+#define HV_STATUS_TIME_OUT                     0x78
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
@@ -778,6 +781,22 @@ struct hv_input_unmap_device_interrupt {
 	struct hv_interrupt_entry interrupt_entry;
 } __packed;
 
+struct hv_enable_vp_vtl_input {
+	u64 partitionid;
+	u32 vpindex;
+	u8 targetvtl;
+	u8 padding[3];
+	u8 context[0xe0];
+} __packed;
+
+struct hv_start_virtual_processor_input {
+	u64 partitionid;
+	u32 vpindex;
+	u8 targetvtl;
+	u8 padding[3];
+	u8 context[0xe0];
+} __packed;
+
 #define HV_SOURCE_SHADOW_NONE               0x0
 #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
 
-- 
2.25.1

