Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7AF6A6A79
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 11:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCAKIX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 05:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCAKIR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 05:08:17 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9324193E8;
        Wed,  1 Mar 2023 02:08:12 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2ADDF20B9C3F;
        Wed,  1 Mar 2023 02:08:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2ADDF20B9C3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677665292;
        bh=OYa68YyAk6BHCC4U7q1Fo42kWp3VDQ8A24b1eSVGdVE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IAjrLgKs8YqbWTUWjiMzRwwT9QMFhIEblD1Row90MD2lXyOh7xT6C1pvXUE+XuoVz
         iIaZGJ6/7FV6y5iGgNVdcDTDQWTPB4inpkIOKXrsSKX4XXarO8usBEV1cHP+IYTwZb
         2s18EZRUz+5JUYcfZDd5Kr3DveBCwcQBpz4pILKQ=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/2] x86/hyperv: VTL support for Hyper-V
Date:   Wed,  1 Mar 2023 02:08:08 -0800
Message-Id: <1677665288-6879-3-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1677665288-6879-1-git-send-email-ssengar@linux.microsoft.com>
References: <1677665288-6879-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VTL helps enable Hyper-V Virtual Secure Mode (VSM) feature. VSM is a
set of hypervisor capabilities and enlightenments offered to host and
guest partitions which enable the creation and management of new
security boundaries within operating system software. VSM achieves
and maintains isolation through VTLs.

Add early initialization for Virtual Trust Levels (VTL). This includes
initializing the x86 platform for VTL and enabling boot support for
secondary CPUs to start in targeted VTL context. For now, only enable
the code for targeted VTL level as 2.

In VTL, AP has to start directly in the 64-bit mode, bypassing the
usual 16-bit -> 32-bit -> 64-bit mode transition sequence that occurs
after waking up an AP with SIPI whose vector points to the 16-bit AP
startup trampoline code.

This commit also moves hv_get_nmi_reason function to header file, so
that it can be reused by VTL.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/Kconfig                   |  23 +++
 arch/x86/hyperv/Makefile           |   1 +
 arch/x86/hyperv/hv_vtl.c           | 242 +++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  75 +++++++++
 arch/x86/include/asm/mshyperv.h    |  14 ++
 arch/x86/kernel/cpu/mshyperv.c     |   6 +-
 include/asm-generic/hyperv-tlfs.h  |   4 +
 7 files changed, 360 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_vtl.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 947e24714c28..e0d074bd04ce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -781,6 +781,29 @@ menuconfig HYPERVISOR_GUEST
 
 if HYPERVISOR_GUEST
 
+config HYPERV_VTL
+	bool "Enable VTL"
+	depends on X86_64 && HYPERV
+	default n
+	help
+	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
+	  enlightenments offered to host and guest partitions which enables
+	  the creation and management of new security boundaries within
+	  operating system software.
+
+	  VSM achieves and maintains isolation through Virtual Trust Levels
+	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
+	  being more privileged than lower levels. VTL0 is the least privileged
+	  level, and currently only other level supported is VTL2.
+
+	  Select this option to enable Hyper-V VTL configuration at boot
+	  time. This option initializes the x86 platform for VTL and add
+	  support to boot secondary CPUs directly in to 64 bit context as
+	  required by VTL.
+
+	  This option should only be enabled for the higher VTLs that is > 0.
+	  If unsure, say N.
+
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on HAVE_STATIC_CALL
diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 5d2de10809ae..a538df01181a 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
+obj-$(CONFIG_HYPERV_VTL)	+= hv_vtl.o
 
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
new file mode 100644
index 000000000000..0b67e1bf017d
--- /dev/null
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Author:
+ *   Saurabh Sengar <ssengar@microsoft.com>
+ */
+
+#include <asm/apic.h>
+#include <asm/boot.h>
+#include <asm/desc.h>
+#include <asm/i8259.h>
+#include <asm/mshyperv.h>
+#include <asm/realmode.h>
+
+extern struct boot_params boot_params;
+static struct real_mode_header hv_vtl_real_mode_header;
+
+static struct legacy_pic vtl_pic;
+
+static int vtl_pic_probe(void)
+{
+	null_legacy_pic.probe();
+	return vtl_pic.nr_legacy_irqs;
+}
+
+void __init hv_vtl_init_platform(void)
+{
+	pr_info("Initializing Hyper-V VTL\n");
+
+	x86_init.irqs.pre_vector_init = x86_init_noop;
+	x86_init.timers.timer_init = x86_init_noop;
+
+	x86_platform.get_wallclock = get_rtc_noop;
+	x86_platform.set_wallclock = set_rtc_noop;
+	x86_platform.get_nmi_reason = hv_get_nmi_reason;
+
+	x86_platform.legacy.i8042 = X86_LEGACY_I8042_PLATFORM_ABSENT;
+	x86_platform.legacy.rtc = 0;
+	x86_platform.legacy.warm_reset = 0;
+	x86_platform.legacy.reserve_bios_regions = 0;
+	x86_platform.legacy.devices.pnpbios = 0;
+	/*
+	 * Do not try to access the PIC (even if it is there).
+	 * Reserve 1 IRQ so that PCI MSIs to not get allocated to virq 0,
+	 * which is not generally considered a valid IRQ by Linux (and so
+	 * causes various problems).
+	 */
+	vtl_pic = null_legacy_pic;
+	vtl_pic.nr_legacy_irqs = 1;
+	vtl_pic.probe = vtl_pic_probe;
+	legacy_pic = &vtl_pic;
+}
+
+static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
+{
+	return ((u64)desc->base3 << 32) | ((u64)desc->base2 << 24) |
+		(desc->base1 << 16) | desc->base0;
+}
+
+static inline u32 hv_vtl_system_desc_limit(struct ldttss_desc *desc)
+{
+	return ((u32)desc->limit1 << 16) | (u32)desc->limit0;
+}
+
+typedef void (*secondary_startup_64_fn)(void*, void*);
+static void hv_vtl_ap_entry(void)
+{
+	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
+}
+
+static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
+{
+	u64 status;
+	struct hv_enable_vp_vtl *input;
+	unsigned long irq_flags;
+
+	struct desc_ptr gdt_ptr;
+	struct desc_ptr idt_ptr;
+
+	struct ldttss_desc *tss;
+	struct ldttss_desc *ldt;
+	struct desc_struct *gdt;
+
+	u64 rsp = initial_stack;
+	u64 rip = (u64)&hv_vtl_ap_entry;
+
+	native_store_gdt(&gdt_ptr);
+	store_idt(&idt_ptr);
+
+	gdt = (struct desc_struct *)((void *)(gdt_ptr.address));
+	tss = (struct ldttss_desc *)(gdt + GDT_ENTRY_TSS);
+	ldt = (struct ldttss_desc *)(gdt + GDT_ENTRY_LDT);
+
+	local_irq_save(irq_flags);
+
+	input = (struct hv_enable_vp_vtl *)(*this_cpu_ptr(hyperv_pcpu_input_arg));
+	memset(input, 0, sizeof(*input));
+
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->vp_index = target_vp_index;
+	input->target_vtl.target_vtl = HV_VTL_MGMT;
+
+	/*
+	 * The x86_64 Linux kernel follows the 16-bit -> 32-bit -> 64-bit
+	 * mode transition sequence after waking up an AP with SIPI whose
+	 * vector points to the 16-bit AP startup trampoline code. Here in
+	 * VTL2, we can't perform that sequence as the AP has to start in
+	 * the 64-bit mode.
+	 *
+	 * To make this happen, we tell the hypervisor to load a valid 64-bit
+	 * context (most of which is just magic numbers from the CPU manual)
+	 * so that AP jumps right to the 64-bit entry of the kernel, and the
+	 * control registers are loaded with values that let the AP fetch the
+	 * code and data and carry on with work it gets assigned.
+	 */
+
+	input->vp_context.rip = rip;
+	input->vp_context.rsp = rsp;
+	input->vp_context.rflags = 0x0000000000000002;
+	input->vp_context.efer = __rdmsr(MSR_EFER);
+	input->vp_context.cr0 = native_read_cr0();
+	input->vp_context.cr3 = __native_read_cr3();
+	input->vp_context.cr4 = native_read_cr4();
+	input->vp_context.msr_cr_pat = __rdmsr(MSR_IA32_CR_PAT);
+	input->vp_context.idtr.limit = idt_ptr.size;
+	input->vp_context.idtr.base = idt_ptr.address;
+	input->vp_context.gdtr.limit = gdt_ptr.size;
+	input->vp_context.gdtr.base = gdt_ptr.address;
+
+	/* Non-system desc (64bit), long, code, present */
+	input->vp_context.cs.selector = __KERNEL_CS;
+	input->vp_context.cs.base = 0;
+	input->vp_context.cs.limit = 0xffffffff;
+	input->vp_context.cs.attributes = 0xa09b;
+	/* Non-system desc (64bit), data, present, granularity, default */
+	input->vp_context.ss.selector = __KERNEL_DS;
+	input->vp_context.ss.base = 0;
+	input->vp_context.ss.limit = 0xffffffff;
+	input->vp_context.ss.attributes = 0xc093;
+
+	/* System desc (128bit), present, LDT */
+	input->vp_context.ldtr.selector = GDT_ENTRY_LDT * 8;
+	input->vp_context.ldtr.base = hv_vtl_system_desc_base(ldt);
+	input->vp_context.ldtr.limit = hv_vtl_system_desc_limit(ldt);
+	input->vp_context.ldtr.attributes = 0x82;
+
+	/* System desc (128bit), present, TSS, 0x8b - busy, 0x89 -- default */
+	input->vp_context.tr.selector = GDT_ENTRY_TSS * 8;
+	input->vp_context.tr.base = hv_vtl_system_desc_base(tss);
+	input->vp_context.tr.limit = hv_vtl_system_desc_limit(tss);
+	input->vp_context.tr.attributes = 0x8b;
+
+	status = hv_result(hv_do_hypercall(HVCALL_ENABLE_VP_VTL, input, NULL));
+
+	if (!hv_result_success(status) && status != HV_STATUS_VTL_ALREADY_ENABLED) {
+		pr_err("HVCALL_ENABLE_VP_VTL failed for VP : %d ! [Err: %#llx\n]",
+		       target_vp_index, status);
+		status = -EINVAL;
+		goto free_lock;
+	}
+
+	status = hv_result(hv_do_hypercall(HVCALL_START_VP, input, NULL));
+
+	if (!hv_result_success(status)) {
+		pr_err("HVCALL_START_VP failed for VP : %d ! [Err: %#llx]\n",
+		       target_vp_index, status);
+		status = -EINVAL;
+	}
+
+free_lock:
+	local_irq_restore(irq_flags);
+
+	return status;
+}
+
+static int hv_vtl_apicid_to_vp_id(u32 apic_id)
+{
+	u64 control;
+	u64 status;
+	unsigned long irq_flags;
+	struct hv_get_vp_from_apic_id_in *input;
+	u32 *output;
+
+	local_irq_save(irq_flags);
+
+	input = (struct hv_get_vp_from_apic_id_in *)(*this_cpu_ptr(hyperv_pcpu_input_arg));
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->apic_ids[0] = apic_id;
+
+	output = (u32 *)input;
+
+	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
+	status = hv_result(hv_do_hypercall(control, input, output));
+
+	local_irq_restore(irq_flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("failed to get vp id from apic id %d, status %#llx\n",
+		       apic_id, status);
+		return -EINVAL;
+	}
+
+	return output[0];
+}
+
+static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
+{
+	int vp_id;
+
+	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
+	vp_id = hv_vtl_apicid_to_vp_id(apicid);
+
+	if (vp_id < 0) {
+		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
+		return -EINVAL;
+	}
+	if (vp_id > ms_hyperv.max_vp_index) {
+		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_id, apicid);
+		return -EINVAL;
+	}
+
+	return hv_vtl_bringup_vcpu(vp_id, start_eip);
+}
+
+static int __init hv_vtl_early_init(void)
+{
+	/*
+	 * `boot_cpu_has` returns the runtime feature support,
+	 * and here is the earliest it can be used.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVE))
+		panic("XSAVE has to be disabled as it is not supported by this module.\n"
+			  "Please add 'noxsave' to the kernel command line.\n");
+
+	real_mode_header = &hv_vtl_real_mode_header;
+	apic->wakeup_secondary_cpu_64 = hv_vtl_wakeup_secondary_cpu;
+
+	return 0;
+}
+early_initcall(hv_vtl_early_init);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 0b73a809e9e1..08a6845a233d 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -713,6 +713,81 @@ union hv_msi_entry {
 	} __packed;
 };
 
+struct hv_x64_segment_register {
+	__u64 base;
+	__u32 limit;
+	__u16 selector;
+	union {
+		struct {
+			__u16 segment_type : 4;
+			__u16 non_system_segment : 1;
+			__u16 descriptor_privilege_level : 2;
+			__u16 present : 1;
+			__u16 reserved : 4;
+			__u16 available : 1;
+			__u16 _long : 1;
+			__u16 _default : 1;
+			__u16 granularity : 1;
+		} __packed;
+		__u16 attributes;
+	};
+} __packed;
+
+struct hv_x64_table_register {
+	__u16 pad[3];
+	__u16 limit;
+	__u64 base;
+} __packed;
+
+struct hv_init_vp_context_t {
+	u64 rip;
+	u64 rsp;
+	u64 rflags;
+
+	struct hv_x64_segment_register cs;
+	struct hv_x64_segment_register ds;
+	struct hv_x64_segment_register es;
+	struct hv_x64_segment_register fs;
+	struct hv_x64_segment_register gs;
+	struct hv_x64_segment_register ss;
+	struct hv_x64_segment_register tr;
+	struct hv_x64_segment_register ldtr;
+
+	struct hv_x64_table_register idtr;
+	struct hv_x64_table_register gdtr;
+
+	u64 efer;
+	u64 cr0;
+	u64 cr3;
+	u64 cr4;
+	u64 msr_cr_pat;
+} __packed;
+
+union hv_input_vtl {
+	u8 as_uint8;
+	struct {
+		u8 target_vtl: 4;
+		u8 use_target_vtl: 1;
+		u8 reserved_z: 3;
+	};
+} __packed;
+
+struct hv_enable_vp_vtl {
+	u64				partition_id;
+	u32				vp_index;
+	union hv_input_vtl		target_vtl;
+	u8				mbz0;
+	u16				mbz1;
+	struct hv_init_vp_context_t	vp_context;
+} __packed;
+
+struct hv_get_vp_from_apic_id_in {
+	u64 partition_id;
+	union hv_input_vtl target_vtl;
+	u8 res[7];
+	u32 apic_ids[];
+} __packed;
+
 #include <asm-generic/hyperv-tlfs.h>
 
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4c4c0ec3b62e..4ff549dcd49a 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -11,6 +11,10 @@
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
 
+#define HV_VTL_NORMAL 0x0
+#define HV_VTL_SECURE 0x1
+#define HV_VTL_MGMT   0x2
+
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
@@ -181,6 +185,11 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 	return hv_vp_assist_page[cpu];
 }
 
+static inline unsigned char hv_get_nmi_reason(void)
+{
+	return 0;
+}
+
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void set_hv_tscchange_cb(void (*cb)(void));
@@ -266,6 +275,11 @@ static inline int hv_set_mem_host_visibility(unsigned long addr, int numpages,
 }
 #endif /* CONFIG_HYPERV */
 
+#ifdef CONFIG_HYPERV_VTL
+void __init hv_vtl_init_platform(void);
+#else
+static inline void __init hv_vtl_init_platform(void) {}
+#endif
 
 #include <asm-generic/mshyperv.h>
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f36dc2f796c5..da5d13d29c4e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -250,11 +250,6 @@ static uint32_t  __init ms_hyperv_platform(void)
 	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
 }
 
-static unsigned char hv_get_nmi_reason(void)
-{
-	return 0;
-}
-
 #ifdef CONFIG_X86_LOCAL_APIC
 /*
  * Prior to WS2016 Debug-VM sends NMIs to all CPUs which makes
@@ -521,6 +516,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+	hv_vtl_init_platform();
 #endif
 	/*
 	 * TSC should be marked as unstable only after Hyper-V
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index b870983596b9..87258341fd7c 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -146,6 +146,7 @@ union hv_reference_tsc_msr {
 /* Declare the various hypercall operations. */
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
+#define HVCALL_ENABLE_VP_VTL			0x000f
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
 #define HVCALL_SEND_IPI				0x000b
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
@@ -165,6 +166,8 @@ union hv_reference_tsc_msr {
 #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
 #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
 #define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_START_VP				0x0099
+#define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
@@ -218,6 +221,7 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_PORT_ID		17
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
+#define HV_STATUS_VTL_ALREADY_ENABLED		134
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
-- 
2.34.1

