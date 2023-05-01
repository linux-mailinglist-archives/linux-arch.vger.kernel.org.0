Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F96F2F92
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjEAI6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjEAI61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:58:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F8F10FC;
        Mon,  1 May 2023 01:57:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf70676b6so5085595ad.3;
        Mon, 01 May 2023 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931463; x=1685523463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wBt0G1QFo4NtGX3g2+/rfz7AKOqUQ37AswMPeAUefc=;
        b=K0GsFvLZi+NTMp5b2aDHPdL/dQ7jbtBXeFGlQ85s/7irbFyvYr8TOXCb2A9x+vCxHD
         yQVdwFXZ6mvzbEj31j6GgXewEiscn78Wo+3oWx8lVMhH2xa9MS2guu+hQK6MryaObOek
         UPGum2hj5/L/vu5zAptkkH8UKdjO0Fzceb5e/DDWy6wjpmtj9LiUI0tCqf6/ofq0VbFb
         vZjhoPRgxk3RW/qYaWsI9+6XE2JNDRUzSDT5vlE5hJS7kBmF5OhCxtC+1bDbjcWRlBPm
         Rxuu6JGNJz1am4lXoEi52wp9MctJXd3cfaBKBYJyyxoDUBGKT+50ijdbOUd0ohFSKUej
         WhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931463; x=1685523463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wBt0G1QFo4NtGX3g2+/rfz7AKOqUQ37AswMPeAUefc=;
        b=MNVDu8lIXS7RvZC+Qu3qXwRfz6XsgCzxJmpUZ9cXwutqUWauvAj7UIqHLMt9mV9NTB
         05hRH8ltl9v2mPyaczv4neWdfQkg1/0pcQGiZqLt3CLs7H9Uaz2GV6hYQSPg/TxBhqvx
         dNZrR9dAKlnQmhWyuS9YVMCMG8a6bfOtsukRMQ6xSpAc9jglDl8XwPm5b7bIF3iMQpRj
         BQncJLKCuDkDLCppH99xeexfzABj24dJFj28gsgGfRqXNs+dHDjXdResMLGsuuLfKz6v
         bvi7NdWrd1uuS9/48CgryNJfiiP/lDEMjy8XyrW8pSaTKuD8aIZa9SeRY/xqPqpfGRNS
         8TCQ==
X-Gm-Message-State: AC+VfDxJJeHE+oXR/LnHfKYrbF76VLzIlz4PG1hk08oHWEXBUuqEqo3p
        YBAswwLZ2+tKF94dYeox0mw=
X-Google-Smtp-Source: ACHHUZ7U2KxnkJCHcrB6MnhTK/YZGVwFveC6H20olw60JgnLKpIJ80RElHJHjfKq+tG1KJ+DIOidRw==
X-Received: by 2002:a17:903:11c4:b0:1a6:7ed1:7ce4 with SMTP id q4-20020a17090311c400b001a67ed17ce4mr15054784plh.44.1682931462740;
        Mon, 01 May 2023 01:57:42 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:42 -0700 (PDT)
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
Subject: [RFC PATCH V5 09/15] x86/hyperv: Add smp support for sev-snp guest
Date:   Mon,  1 May 2023 04:57:19 -0400
Message-Id: <20230501085726.544209-10-ltykernel@gmail.com>
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

From: Tianyu Lan <tiala@microsoft.com>

The wakeup_secondary_cpu callback was populated with wakeup_
cpu_via_vmgexit() which doesn't work for Hyper-V and Hyper-V
requires to call Hyper-V specific hvcall to start APs. So override
it with Hyper-V specific hook to start AP sev_es_save_area data
structure.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change sicne RFC v3:
       * Replace struct sev_es_save_area with struct
         vmcb_save_area
       * Move code from mshyperv.c to ivm.c

Change since RFC v2:
       * Add helper function to initialize segment
       * Fix some coding style
---
 arch/x86/hyperv/ivm.c             | 89 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   | 18 +++++++
 arch/x86/include/asm/sev.h        | 13 +++++
 arch/x86/include/asm/svm.h        | 15 +++++-
 arch/x86/kernel/cpu/mshyperv.c    | 13 ++++-
 arch/x86/kernel/sev.c             |  4 +-
 include/asm-generic/hyperv-tlfs.h | 19 +++++++
 7 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 522eab55c0dd..0ef46f1874e6 100644
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
@@ -442,6 +446,91 @@ __init void hv_sev_init_mem_and_cpu(void)
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
+	vmsa->sev_features.snp = 1;
+	vmsa->sev_features.restrict_injection = 1;
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
+		ret = hv_do_hypercall(HVCALL_START_VP,
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
 void __init hv_vtom_init(void)
 {
 	/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 84e024ffacd5..5ade250ec771 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -65,6 +65,20 @@ struct memory_map_entry {
 	u32 reserved;
 };
 
+/*
+ * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
+ * to start AP in enlightened SEV guest.
+ */
+#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define HV_AP_SEGMENT_LIMIT		0xffffffff
+
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
@@ -263,6 +277,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
+int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void hv_ghcb_msr_write(u64 msr, u64 value);
@@ -271,6 +287,7 @@ bool hv_ghcb_negotiate_protocol(void);
 void hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
 void hv_sev_init_mem_and_cpu(void);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
@@ -278,6 +295,7 @@ static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
 static inline void hv_sev_init_mem_and_cpu(void) {}
+static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9d23c1..0d57cb1c1bb4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -88,6 +88,19 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
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
index 770dcf75eaa9..cd6bf989d918 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -425,7 +425,20 @@ struct sev_es_save_area {
 	u64 guest_exit_info_2;
 	u64 guest_exit_int_info;
 	u64 guest_nrip;
-	u64 sev_features;
+	union {
+		struct {
+			u64 snp                     : 1;
+			u64 vtom                    : 1;
+			u64 reflectvc               : 1;
+			u64 restrict_injection      : 1;
+			u64 alternate_injection     : 1;
+			u64 full_debug              : 1;
+			u64 reserved1               : 1;
+			u64 snpbtb_isolation        : 1;
+			u64 resrved2                : 56;
+		};
+		u64 val;
+	} sev_features;
 	u64 vintr_ctrl;
 	u64 guest_exit_code;
 	u64 virtual_tom;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index dea9b881180b..0c5f9f7bd7ba 100644
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
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b031244d6d2d..20f3fd8ade2f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1082,7 +1082,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
 	 */
 	vmsa->vmpl		= 0;
-	vmsa->sev_features	= sev_status >> 2;
+	vmsa->sev_features.val = sev_status >> 2;
 
 	/* Switch the page over to a VMSA page now that it is initialized */
 	ret = snp_set_vmsa(vmsa, true);
@@ -1099,7 +1099,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
-	ghcb_set_rax(ghcb, vmsa->sev_features);
+	ghcb_set_rax(ghcb, vmsa->sev_features.val);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
 	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
 	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index f4e4cc4f965f..959b075591b2 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -149,6 +149,7 @@ union hv_reference_tsc_msr {
 #define HVCALL_ENABLE_VP_VTL			0x000f
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
 #define HVCALL_SEND_IPI				0x000b
+#define HVCALL_ENABLE_VP_VTL			0x000f
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
 #define HVCALL_SEND_IPI_EX			0x0015
@@ -168,6 +169,7 @@ union hv_reference_tsc_msr {
 #define HVCALL_RETARGET_INTERRUPT		0x007e
 #define HVCALL_START_VP				0x0099
 #define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
+#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
@@ -223,6 +225,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_PORT_ID		17
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
+#define HV_STATUS_TIME_OUT                      120
 #define HV_STATUS_VTL_ALREADY_ENABLED		134
 
 /*
@@ -783,6 +786,22 @@ struct hv_input_unmap_device_interrupt {
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

