Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC566D5B6B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjDDJBT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDDJBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 05:01:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 345031BE3;
        Tue,  4 Apr 2023 02:01:11 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 75DF9210DD94;
        Tue,  4 Apr 2023 02:01:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75DF9210DD94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680598869;
        bh=YjwkN6oNVFUpa9gjv8NVfCyoligSRs26cxWXxmQGs0Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lFdfNrs/ci4nOrpsydoXiJUjVPjRAr6VewT0bgs7jh1jUnBcqTHYOLZJ1/iet5nDl
         srmKM/pSV/V7dsQ9C+Yd7+F0N7MsiEuuVSeEo73yYz1kljQIuH0jJYBYi+p9N2jq0j
         SyyNhfKLo3YCoW0swWSELh4APTlBwKN2aD94SgV8=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: [PATCH v4 5/5] x86/hyperv: VTL support for Hyper-V
Date:   Tue,  4 Apr 2023 02:01:04 -0700
Message-Id: <1680598864-16981-6-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Virtual Trust Levels (VTL) helps enable Hyper-V Virtual Secure Mode (VSM)
feature. VSM is a set of hypervisor capabilities and enlightenments
offered to host and guest partitions which enable the creation and
management of new security boundaries within operating system software.
VSM achieves and maintains isolation through VTLs.

Add early initialization for Virtual Trust Levels (VTL). This includes
initializing the x86 platform for VTL and enabling boot support for
secondary CPUs to start in targeted VTL context. For now, only enable
the code for targeted VTL level as 2.

When starting an AP at a VTL other than VTL0, the AP must start directly
in 64-bit mode, bypassing the usual 16-bit -> 32-bit -> 64-bit mode
transition sequence that occurs after waking up an AP with SIPI whose
vector points to the 16-bit AP startup trampoline code.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V4]
- replace initial_stack with current->thread.sp as per recent upstream changes

 arch/x86/hyperv/Makefile        |   1 +
 arch/x86/hyperv/hv_vtl.c        | 227 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |  10 ++
 arch/x86/kernel/cpu/mshyperv.c  |   1 +
 4 files changed, 239 insertions(+)
 create mode 100644 arch/x86/hyperv/hv_vtl.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 5d2de10809ae..3a1548054b48 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
+obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
 
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
new file mode 100644
index 000000000000..1ba5d3b99b16
--- /dev/null
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -0,0 +1,227 @@
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
+void __init hv_vtl_init_platform(void)
+{
+	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
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
+	int ret = 0;
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
+	u64 rsp = current->thread.sp;
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
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
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
+	status = hv_do_hypercall(HVCALL_ENABLE_VP_VTL, input, NULL);
+
+	if (!hv_result_success(status) &&
+	    hv_result(status) != HV_STATUS_VTL_ALREADY_ENABLED) {
+		pr_err("HVCALL_ENABLE_VP_VTL failed for VP : %d ! [Err: %#llx\n]",
+		       target_vp_index, status);
+		ret = -EINVAL;
+		goto free_lock;
+	}
+
+	status = hv_do_hypercall(HVCALL_START_VP, input, NULL);
+
+	if (!hv_result_success(status)) {
+		pr_err("HVCALL_START_VP failed for VP : %d ! [Err: %#llx]\n",
+		       target_vp_index, status);
+		ret = -EINVAL;
+	}
+
+free_lock:
+	local_irq_restore(irq_flags);
+
+	return ret;
+}
+
+static int hv_vtl_apicid_to_vp_id(u32 apic_id)
+{
+	u64 control;
+	u64 status;
+	unsigned long irq_flags;
+	struct hv_get_vp_from_apic_id_in *input;
+	u32 *output, ret;
+
+	local_irq_save(irq_flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->apic_ids[0] = apic_id;
+
+	output = (u32 *)input;
+
+	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
+	status = hv_do_hypercall(control, input, output);
+	ret = output[0];
+
+	local_irq_restore(irq_flags);
+
+	if (!hv_result_success(status)) {
+		pr_err("failed to get vp id from apic id %d, status %#llx\n",
+		       apic_id, status);
+		return -EINVAL;
+	}
+
+	return ret;
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
+	if (cpu_feature_enabled(X86_FEATURE_XSAVE))
+		panic("XSAVE has to be disabled as it is not supported by this module.\n"
+			  "Please add 'noxsave' to the kernel command line.\n");
+
+	real_mode_header = &hv_vtl_real_mode_header;
+	apic->wakeup_secondary_cpu_64 = hv_vtl_wakeup_secondary_cpu;
+
+	return 0;
+}
+early_initcall(hv_vtl_early_init);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 71ed240ef66d..de4ad38f7d74 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -19,6 +19,10 @@
  */
 #define HV_IOAPIC_BASE_ADDRESS 0xfec00000
 
+#define HV_VTL_NORMAL 0x0
+#define HV_VTL_SECURE 0x1
+#define HV_VTL_MGMT   0x2
+
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
@@ -276,6 +280,12 @@ static inline u64 hv_get_non_nested_register(unsigned int reg) { return 0; }
 #endif /* CONFIG_HYPERV */
 
 
+#ifdef CONFIG_HYPERV_VTL_MODE
+void __init hv_vtl_init_platform(void);
+#else
+static inline void __init hv_vtl_init_platform(void) {}
+#endif
+
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5ee02af57dac..5180e3c50184 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -519,6 +519,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+	hv_vtl_init_platform();
 #endif
 	/*
 	 * TSC should be marked as unstable only after Hyper-V
-- 
2.34.1

