Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B056D4F63
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjDCRo6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjDCRoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E212D4B;
        Mon,  3 Apr 2023 10:44:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id r7-20020a17090b050700b002404be7920aso29377036pjz.5;
        Mon, 03 Apr 2023 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Efu5rhOggzlI0kcT150AQduXmzuRafJrSYFqNtQftrI=;
        b=gQ/WrzwVffRoPeh+XgYJeBIyAd1XhgHgkvI44mtrOyV0nJmBs+PM7ErifjlKkjnli7
         /fcZFSJW4X9o6A1t4+VrpuoXRelg2CdaS8i/q0yx6uYYbb8DjSAtIF7I+aAyalemtaF5
         rI/CepYF3bjYAmrkvm263Ldxh+yLisZ8JffYyl5XKHigosYttCmR45CjCHxyh1vwLDxY
         s022Cu2AvpJzj2IU3ABd42dFGLc6t+zKcIAx75oM1NDoKjzIUhzDzsAoclu4+Bq3uoRa
         RoYF19AxDbfeGy4U47l22rLdupg+wC8ZchXmQjM0EG7Ynf2spNmuHamGRVF6KX8L+Mxg
         iWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Efu5rhOggzlI0kcT150AQduXmzuRafJrSYFqNtQftrI=;
        b=hglE5vco06cEAmlIgu56cyi1Iktpw+oM7+3vYrGdmS6sJ1/fTHdWgtNa57Xj9ywUcU
         PPamSolIyXiZJP5m5qAbNtZTVWSzIqBvsTsQBWPv1lISsM79g1MiMZ1Kl+pJ2Imxd2D4
         MNGQSLeT+UPHcr3jv8keW76e1vyp3UVfX/ju9usruCIR3d1ilmNp+7O+4DRO3M7RR99l
         yGxOMDe+k64Bf8O2zv10pyW0jm48oqrWphBzMo1ZGylNDHAaecOwAln4C7qzCKxHOVVq
         eDkTY0DQA9vi714ZOvq3FG2TPaBDuteNz4e9yzyjnC/1+efYTD2/Uer+gB+WusYetuy0
         7qwA==
X-Gm-Message-State: AAQBX9f21HBltvrUxusQpqr92ygQ8HiEpESsMeYq+6Jst7JYHR1CRQGl
        lM7vJ+2UwYHWHNjfbKaiqp0=
X-Google-Smtp-Source: AKy350aFdkCUQuqf3H8aJn3BQxPFh1mNDKkOo4VE2zYt41+OzuCzgh401vVBvzTJWng/+jZlsVNOzQ==
X-Received: by 2002:a17:902:ec8b:b0:1a2:87a2:c91a with SMTP id x11-20020a170902ec8b00b001a287a2c91amr21118850plg.34.1680543863287;
        Mon, 03 Apr 2023 10:44:23 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:22 -0700 (PDT)
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
Subject: [RFC PATCH V4 10/17] x86/hyperv: Add smp support for sev-snp guest
Date:   Mon,  3 Apr 2023 13:43:58 -0400
Message-Id: <20230403174406.4180472-11-ltykernel@gmail.com>
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
index c0f3fa924163..51243148b8e6 100644
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
@@ -437,6 +441,91 @@ __init void hv_sev_init_mem_and_cpu(void)
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
 void __init hv_vtom_init(void)
 {
 	/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index a4a59007b5f2..e23c987deb7a 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -55,6 +55,20 @@ struct memory_map_entry {
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
@@ -253,6 +267,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
+int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void hv_ghcb_msr_write(u64 msr, u64 value);
@@ -261,6 +277,7 @@ bool hv_ghcb_negotiate_protocol(void);
 void hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
 void hv_sev_init_mem_and_cpu(void);
+int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
@@ -268,6 +285,7 @@ static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
 static inline void hv_sev_init_mem_and_cpu(void) {}
+static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
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
index cb1ee53ad3b1..bcf970901512 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -423,7 +423,20 @@ struct sev_es_save_area {
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
index 71820bbf9e90..829234ba8da5 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -300,6 +300,16 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 
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
@@ -503,8 +513,7 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition)
-		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
+	smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
 	/*
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a640ef..b3f95fcb8b18 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1080,7 +1080,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
 	 */
 	vmsa->vmpl		= 0;
-	vmsa->sev_features	= sev_status >> 2;
+	vmsa->sev_features.val = sev_status >> 2;
 
 	/* Switch the page over to a VMSA page now that it is initialized */
 	ret = snp_set_vmsa(vmsa, true);
@@ -1097,7 +1097,7 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
 	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
-	ghcb_set_rax(ghcb, vmsa->sev_features);
+	ghcb_set_rax(ghcb, vmsa->sev_features.val);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
 	ghcb_set_sw_exit_info_1(ghcb, ((u64)apic_id << 32) | SVM_VMGEXIT_AP_CREATE);
 	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index ea406e901469..b2f14aa608f7 100644
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
@@ -220,6 +222,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_PORT_ID		17
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
+#define HV_STATUS_TIME_OUT                     0x78
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
@@ -779,6 +782,22 @@ struct hv_input_unmap_device_interrupt {
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

