Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2F623518
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKIUyp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiKIUyS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:18 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661062D759;
        Wed,  9 Nov 2022 12:54:16 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so17241862pgh.4;
        Wed, 09 Nov 2022 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHQxOX05VuPCuHlsy0vXM0F/fWibSFir6W5PfPRogHE=;
        b=l6rdGXRkcWN+drGlDK/ZEvZzAwEKNDPZu4svTBS14EpXmNxaOJH2Oe0VOOUwg4ncO8
         /JhToHQMwQ8+09f8mVeyCvPlvSVCzQlk6SiWbVmfOhsJv/0iwWxn5nCk0Q2RpfhBfVkb
         Jp0qM8251r5tuOpwaL5sUScpGxMSnkGfwKLikOyX8CXgaMMHzf8j4ZHFRXzsFsVG2su4
         /65cwkIqR2pD37SAOFdRAS/ivnr/hVR6bdx+smVqLoCrYBPI/tK1dlLLNMlT7FowxXlU
         fYNpG+B6SkmI9yry3sZkZV1+YqnSKVNYKryFQcejbJO2g4BCiY+A4kqVLUdRlMvCGDEX
         k96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHQxOX05VuPCuHlsy0vXM0F/fWibSFir6W5PfPRogHE=;
        b=7GYCowDJrvvYMKXw2xpRHH4+CMlBGqD2/ypVZM8DliW3/tc5TvJme2fI9myNbNLsiX
         hK1hs02sLrhE6CfOC8Uo0PX8g4hWDSPG0DYLCnargoWKTfReCKbx2waWTXTnrxscDi97
         6PaFgumkiV2oTan6q1vqn7kQpDRcIgZ6Pc9KX5mb3OxKKoJ3di5BRt2KACsK6gp22LVx
         fu/vlFu30kB7px5NPQXNHUY4tv4kDyLvnd3QyC2EXYQCpmz5F8J34Kd9w8+8zzHqU2KX
         2t3Wx4u8isA+4IVuXwomev7i9e+Tr+VbQAT+cP4v2kAm/Ekoa/o75DQ2W/1pvxV9kxVm
         uBDg==
X-Gm-Message-State: ANoB5plUT0cdSK0i6DgQj9Ouhg4UMuB57FYSW8VJ5AUfu+L5hE59B4K1
        MMna/lQ1dSDoJaUJfKqEviA=
X-Google-Smtp-Source: AA0mqf6C2Mi/rVU6cQ41Ll9xJELaEDOtpVMObe/H66xo9SZIrnxQM4m7KlxJaJnETtYShGOnOcdMuA==
X-Received: by 2002:a63:f403:0:b0:470:6ed3:5454 with SMTP id g3-20020a63f403000000b004706ed35454mr16573050pgi.191.1668027255837;
        Wed, 09 Nov 2022 12:54:15 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:15 -0800 (PST)
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
Subject: [RFC PATCH 14/17] x86/hyperv: Add smp support for sev-snp guest
Date:   Wed,  9 Nov 2022 15:53:49 -0500
Message-Id: <20221109205353.984745-15-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
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
 arch/x86/include/asm/sev.h        |  13 +++
 arch/x86/include/asm/svm.h        |  55 ++++++++++-
 arch/x86/kernel/cpu/mshyperv.c    | 147 +++++++++++++++++++++++++++++-
 include/asm-generic/hyperv-tlfs.h |  18 ++++
 4 files changed, 230 insertions(+), 3 deletions(-)

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
index 0361626841bc..fc54d3e7f817 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -328,8 +328,61 @@ struct vmcb_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
-	u8 reserved_6[72];
+
+	/*
+	 * The following part of the save area is valid only for
+	 * SEV-ES guests when referenced through the GHCB or for
+	 * saving to the host save area.
+	 */
+	u8 reserved_7[72];
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
index f0c97210c64a..b266f648e5cd 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -41,6 +41,10 @@
 #include <asm/realmode.h>
 #include <asm/e820/api.h>
 
+#define EN_SEV_SNP_PROCESSOR_INFO_ADDR	 0x802000
+#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define HV_AP_SEGMENT_LIMIT		0xffffffff
+
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
 struct ms_hyperv_info ms_hyperv;
@@ -232,6 +236,136 @@ static void __init hv_smp_prepare_boot_cpu(void)
 #endif
 }
 
+static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
+
+int hv_snp_boot_ap(int cpu, unsigned long start_ip)
+{
+	struct vmcb_save_area *vmsa = (struct vmcb_save_area *)
+		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	struct desc_ptr gdtr;
+	u64 ret, retry = 5;
+	struct hv_enable_vp_vtl_input *enable_vtl_input;
+	struct hv_start_virtual_processor_input *start_vp_input;
+	union sev_rmp_adjust rmp_adjust;
+	void **arg;
+	unsigned long flags;
+
+	*(void **)per_cpu_ptr(hyperv_pcpu_input_arg, cpu) = ap_start_input_arg;
+
+	hv_vp_index[cpu] = cpu;
+
+	/* Prevent APs from entering busy calibration loop */
+	preset_lpj = lpj_fine;
+
+	/* Replace the provided real-mode start_ip */
+	start_ip = (unsigned long)secondary_startup_64_no_verify;
+
+	native_store_gdt(&gdtr);
+
+	vmsa->gdtr.base = gdtr.address;
+	vmsa->gdtr.limit = gdtr.size;
+
+	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
+	if (vmsa->es.selector) {
+		vmsa->es.base = 0;
+		vmsa->es.limit = HV_AP_SEGMENT_LIMIT;
+		vmsa->es.attrib = *(u16 *)(vmsa->gdtr.base + vmsa->es.selector + 5);
+		vmsa->es.attrib = (vmsa->es.attrib & 0xFF) | ((vmsa->es.attrib >> 4) & 0xF00);
+	}
+
+	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
+	if (vmsa->cs.selector) {
+		vmsa->cs.base = 0;
+		vmsa->cs.limit = HV_AP_SEGMENT_LIMIT;
+		vmsa->cs.attrib = *(u16 *)(vmsa->gdtr.base + vmsa->cs.selector + 5);
+		vmsa->cs.attrib = (vmsa->cs.attrib & 0xFF) | ((vmsa->cs.attrib >> 4) & 0xF00);
+	}
+
+	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
+	if (vmsa->ss.selector) {
+		vmsa->ss.base = 0;
+		vmsa->ss.limit = HV_AP_SEGMENT_LIMIT;
+		vmsa->ss.attrib = *(u16 *)(vmsa->gdtr.base + vmsa->ss.selector + 5);
+		vmsa->ss.attrib = (vmsa->ss.attrib & 0xFF) | ((vmsa->ss.attrib >> 4) & 0xF00);
+	}
+
+	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
+	if (vmsa->ds.selector) {
+		vmsa->ds.base = 0;
+		vmsa->ds.limit = HV_AP_SEGMENT_LIMIT;
+		vmsa->ds.attrib = *(u16 *)(vmsa->gdtr.base + vmsa->ds.selector + 5);
+		vmsa->ds.attrib = (vmsa->ds.attrib & 0xFF) | ((vmsa->ds.attrib >> 4) & 0xF00);
+	}
+
+	vmsa->efer = native_read_msr(MSR_EFER);
+
+	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
+	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
+	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
+
+	vmsa->xcr0 = 1;
+	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
+	vmsa->rip = (u64)start_ip;
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
+	arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	if (unlikely(!*arg)) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	if (ms_hyperv.vtl != 0) {
+		enable_vtl_input = (struct hv_enable_vp_vtl_input *)*arg;
+		memset(enable_vtl_input, 0, sizeof(*enable_vtl_input));
+		enable_vtl_input->partitionid = -1;
+		enable_vtl_input->vpindex = cpu;
+		enable_vtl_input->targetvtl = ms_hyperv.vtl;
+		*(u64 *)&enable_vtl_input->context[0] = __pa(vmsa) | 1;
+
+		ret = hv_do_hypercall(HVCALL_ENABLE_VP_VTL, enable_vtl_input, NULL);
+		if (ret != 0) {
+			pr_err("HvCallEnableVpVtl failed: %llx\n", ret);
+			goto done;
+		}
+	}
+
+	start_vp_input = (struct hv_start_virtual_processor_input *)*arg;
+	memset(start_vp_input, 0, sizeof(*start_vp_input));
+	start_vp_input->partitionid = -1;
+	start_vp_input->vpindex = cpu;
+	start_vp_input->targetvtl = ms_hyperv.vtl;
+	*(u64 *)&start_vp_input->context[0] = __pa(vmsa) | 1;
+
+	do {
+		ret = hv_do_hypercall(HVCALL_START_VIRTUAL_PROCESSOR,
+				      start_vp_input, NULL);
+	} while (ret == HV_STATUS_TIME_OUT && retry--);
+
+	if (ret != 0) {
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
@@ -241,6 +375,16 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 
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
@@ -489,8 +633,7 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition)
-		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
+	smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
 	/*
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 6e2a090e2649..7072adbf5540 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -139,6 +139,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
 #define HVCALL_SEND_IPI				0x000b
+#define HVCALL_ENABLE_VP_VTL			0x000f
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
 #define HVCALL_SEND_IPI_EX			0x0015
@@ -156,6 +157,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
 #define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
@@ -763,6 +765,22 @@ struct hv_input_unmap_device_interrupt {
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

