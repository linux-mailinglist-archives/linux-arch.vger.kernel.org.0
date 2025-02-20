Return-Path: <linux-arch+bounces-10257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9DA3E3F6
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DB817DA37
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606EB214A83;
	Thu, 20 Feb 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rMgvqENd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F0214214;
	Thu, 20 Feb 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076426; cv=none; b=iP64qd2te+c9u97OutTOfhCV8pPamw91jNJB9WjLdgnhvdjkw1+5VRV1WtlGS0Vdlf9gwgLJ8k6SA+Ki89C5PXfoqPFCkfn5pr37j20p3gBJnv2SjyKy+RFhQHxtsBi0oUGdsoMHUiZ8RRTs9x+JUcGFQO1iwhJvqmfwapJOZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076426; c=relaxed/simple;
	bh=9Hd8N3yhO7IJ07bojPOF9bK5EXjEU/i6QRAKx60a4HI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rea8FMUloyYYIBo6YSyenQRPiu4l2gMPx/x/N6sT866JCxAfuoB1K+tbGl00Cj0Uyc+jJJtSwXnI/g2P82/6hM3mAI1FLGkdwCyaX0bcvccGAQb3b5bmV38MbwQ8Cwn0+HNtEOz566hj6oNaDcK+GqX2dcMmrMkRk/SAuWmF/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rMgvqENd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 079332059196;
	Thu, 20 Feb 2025 10:33:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 079332059196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740076418;
	bh=pZYcBtyotntnb6ihw8FwEqgmcCvQh0sejhIZ9TpakUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMgvqENdQ3tmc0oee3/zJ+qQNq8RSIP8iOXV4pBvbQBUXGmC5T9sLVl6eIq5p/XPG
	 9lvVlX3Ac1/uZ4yXVmKWpOL99NrBxGTqTnFRcOHXM6p90i4WVhR4i9OVHw8aydmhhc
	 3fheJQt37wNta18YGS7QeVhm2X78hodP2oi+wx5c=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mhklinux@outlook.com,
	eahariha@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
Date: Thu, 20 Feb 2025 10:33:15 -0800
Message-Id: <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Introduce hv_current_partition_type to store the partition type
as an enum.

Right now this is limited to guest or root partition, but there will
be other kinds in future and the enum is easily extensible.

Set up hv_current_partition_type early in Hyper-V initialization with
hv_identify_partition_type(). hv_root_partition() just queries this
value, and shouldn't be called before that.

Making this check into a function sets the stage for adding a config
option to gate the compilation of root partition code. In particular,
hv_root_partition() can be stubbed out always be false if root
partition support isn't desired.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c       |  2 ++
 arch/x86/hyperv/hv_init.c          | 10 ++++-----
 arch/x86/kernel/cpu/mshyperv.c     | 24 ++------------------
 drivers/clocksource/hyperv_timer.c |  4 ++--
 drivers/hv/hv.c                    | 10 ++++-----
 drivers/hv/hv_common.c             | 35 +++++++++++++++++++++++++-----
 drivers/hv/vmbus_drv.c             |  2 +-
 drivers/iommu/hyperv-iommu.c       |  4 ++--
 include/asm-generic/mshyperv.h     | 15 +++++++++++--
 9 files changed, 61 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 29fcfd595f48..2265ea5ce5ad 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -61,6 +61,8 @@ static int __init hyperv_init(void)
 		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
 		ms_hyperv.misc_features);
 
+	hv_identify_partition_type();
+
 	ret = hv_common_init();
 	if (ret)
 		return ret;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9be1446f5bd3..ddeb40930bc8 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -90,7 +90,7 @@ static int hv_cpu_init(unsigned int cpu)
 		return 0;
 
 	hvp = &hv_vp_assist_page[cpu];
-	if (hv_root_partition) {
+	if (hv_root_partition()) {
 		/*
 		 * For root partition we get the hypervisor provided VP assist
 		 * page, instead of allocating a new page.
@@ -242,7 +242,7 @@ static int hv_cpu_die(unsigned int cpu)
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
 		union hv_vp_assist_msr_contents msr = { 0 };
-		if (hv_root_partition) {
+		if (hv_root_partition()) {
 			/*
 			 * For root partition the VP assist page is mapped to
 			 * hypervisor provided page, and thus we unmap the
@@ -317,7 +317,7 @@ static int hv_suspend(void)
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	int ret;
 
-	if (hv_root_partition)
+	if (hv_root_partition())
 		return -EPERM;
 
 	/*
@@ -518,7 +518,7 @@ void __init hyperv_init(void)
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 1;
 
-	if (hv_root_partition) {
+	if (hv_root_partition()) {
 		struct page *pg;
 		void *src;
 
@@ -592,7 +592,7 @@ void __init hyperv_init(void)
 	 * If we're running as root, we want to create our own PCI MSI domain.
 	 * We can't set this in hv_pci_init because that would be too late.
 	 */
-	if (hv_root_partition)
+	if (hv_root_partition())
 		x86_init.irqs.create_pci_msi_domain = hv_create_pci_msi_domain;
 #endif
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f285757618fc..4f01f424ea5b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -33,8 +33,6 @@
 #include <asm/numa.h>
 #include <asm/svm.h>
 
-/* Is Linux running as the root partition? */
-bool hv_root_partition;
 /* Is Linux running on nested Microsoft Hypervisor */
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
@@ -451,25 +449,7 @@ static void __init ms_hyperv_init_platform(void)
 	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
 		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
 
-	/*
-	 * Check CPU management privilege.
-	 *
-	 * To mirror what Windows does we should extract CPU management
-	 * features and use the ReservedIdentityBit to detect if Linux is the
-	 * root partition. But that requires negotiating CPU management
-	 * interface (a process to be finalized). For now, use the privilege
-	 * flag as the indicator for running as root.
-	 *
-	 * Hyper-V should never specify running as root and as a Confidential
-	 * VM. But to protect against a compromised/malicious Hyper-V trying
-	 * to exploit root behavior to expose Confidential VM memory, ignore
-	 * the root partition setting if also a Confidential VM.
-	 */
-	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
-	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
-		hv_root_partition = true;
-		pr_info("Hyper-V: running as root partition\n");
-	}
+	hv_identify_partition_type();
 
 	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
 		hv_nested = true;
@@ -618,7 +598,7 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition ||
+	if (hv_root_partition() ||
 	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
 		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index f00019b078a7..09549451dd51 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -582,7 +582,7 @@ static void __init hv_init_tsc_clocksource(void)
 	 * mapped.
 	 */
 	tsc_msr.as_uint64 = hv_get_msr(HV_MSR_REFERENCE_TSC);
-	if (hv_root_partition)
+	if (hv_root_partition())
 		tsc_pfn = tsc_msr.pfn;
 	else
 		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
@@ -627,7 +627,7 @@ void __init hv_remap_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return;
 
-	if (!hv_root_partition) {
+	if (!hv_root_partition()) {
 		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
 		     __func__);
 		return;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fab0690b5c41..a38f84548bc2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -144,7 +144,7 @@ int hv_synic_alloc(void)
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
 		 */
-		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
+		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (!hv_cpu->synic_message_page) {
@@ -272,7 +272,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
 	simp.simp_enabled = 1;
 
-	if (ms_hyperv.paravisor_present || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition()) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -291,7 +291,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (ms_hyperv.paravisor_present || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition()) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -367,7 +367,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 * addresses.
 	 */
 	simp.simp_enabled = 0;
-	if (ms_hyperv.paravisor_present || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition()) {
 		iounmap(hv_cpu->synic_message_page);
 		hv_cpu->synic_message_page = NULL;
 	} else {
@@ -379,7 +379,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
 	siefp.siefp_enabled = 0;
 
-	if (ms_hyperv.paravisor_present || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition()) {
 		iounmap(hv_cpu->synic_event_page);
 		hv_cpu->synic_event_page = NULL;
 	} else {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2120aead98d9..c5c5dc92ff21 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -34,8 +34,11 @@
 u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
 EXPORT_SYMBOL_GPL(hv_current_partition_id);
 
+enum hv_partition_type hv_current_partition_type;
+EXPORT_SYMBOL_GPL(hv_current_partition_type);
+
 /*
- * hv_root_partition, ms_hyperv and hv_nested are defined here with other
+ * ms_hyperv and hv_nested are defined here with other
  * Hyper-V specific globals so they are shared across all architectures and are
  * built only when CONFIG_HYPERV is defined.  But on x86,
  * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
@@ -43,9 +46,6 @@ EXPORT_SYMBOL_GPL(hv_current_partition_id);
  * here, allowing for an overriding definition in the module containing
  * ms_hyperv_init_platform().
  */
-bool __weak hv_root_partition;
-EXPORT_SYMBOL_GPL(hv_root_partition);
-
 bool __weak hv_nested;
 EXPORT_SYMBOL_GPL(hv_nested);
 
@@ -283,7 +283,7 @@ static void hv_kmsg_dump_register(void)
 
 static inline bool hv_output_page_exists(void)
 {
-	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
+	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
 }
 
 void __init hv_get_partition_id(void)
@@ -594,7 +594,7 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
 
 bool hv_is_hibernation_supported(void)
 {
-	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
+	return !hv_root_partition() && acpi_sleep_state_supported(ACPI_STATE_S4);
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
 
@@ -717,3 +717,26 @@ int hv_result_to_errno(u64 status)
 	}
 	return -EIO;
 }
+
+void hv_identify_partition_type(void)
+{
+	/* Assume guest role */
+	hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
+	/*
+	 * Check partition creation and cpu management privileges
+	 *
+	 * Hyper-V should never specify running as root and as a Confidential
+	 * VM. But to protect against a compromised/malicious Hyper-V trying
+	 * to exploit root behavior to expose Confidential VM memory, ignore
+	 * the root partition setting if also a Confidential VM.
+	 */
+	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
+	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
+	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
+		pr_info("Hyper-V: running as root partition\n");
+		if (IS_ENABLED(CONFIG_MSHV_ROOT))
+			hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
+		else
+			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
+	}
+}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 75eb1390b45c..22afebfc28ff 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2656,7 +2656,7 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
-	if (hv_root_partition && !hv_nested)
+	if (hv_root_partition() && !hv_nested)
 		return 0;
 
 	/*
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 2a86aa5d54c6..53e4b37716af 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -130,7 +130,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 	    x86_init.hyper.msi_ext_dest_id())
 		return -ENODEV;
 
-	if (hv_root_partition) {
+	if (hv_root_partition()) {
 		name = "HYPERV-ROOT-IR";
 		ops = &hyperv_root_ir_domain_ops;
 	} else {
@@ -151,7 +151,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 		return -ENOMEM;
 	}
 
-	if (hv_root_partition)
+	if (hv_root_partition())
 		return 0; /* The rest is only relevant to guests */
 
 	/*
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 3f115e2bcdaa..d2b1a8fc074c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -28,6 +28,11 @@
 
 #define VTPM_BASE_ADDRESS 0xfed40000
 
+enum hv_partition_type {
+	HV_PARTITION_TYPE_GUEST,
+	HV_PARTITION_TYPE_ROOT,
+};
+
 struct ms_hyperv_info {
 	u32 features;
 	u32 priv_high;
@@ -59,6 +64,7 @@ struct ms_hyperv_info {
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;
 extern u64 hv_current_partition_id;
+extern enum hv_partition_type hv_current_partition_type;
 
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
@@ -190,8 +196,6 @@ void hv_remove_crash_handler(void);
 extern int vmbus_interrupt;
 extern int vmbus_irq;
 
-extern bool hv_root_partition;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
@@ -213,6 +217,7 @@ void __init hv_common_free(void);
 void __init ms_hyperv_late_init(void);
 int hv_common_cpu_init(unsigned int cpu);
 int hv_common_cpu_die(unsigned int cpu);
+void hv_identify_partition_type(void);
 
 void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
@@ -310,6 +315,7 @@ void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
 #else /* CONFIG_HYPERV */
+static inline void hv_identify_partition_type(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
@@ -321,4 +327,9 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
 }
 #endif /* CONFIG_HYPERV */
 
+static inline bool hv_root_partition(void)
+{
+	return hv_current_partition_type == HV_PARTITION_TYPE_ROOT;
+}
+
 #endif
-- 
2.34.1


