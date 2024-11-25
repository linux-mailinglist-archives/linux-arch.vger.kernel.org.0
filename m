Return-Path: <linux-arch+bounces-9158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E29D8F0D
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 00:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D45CB23F8B
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2024 23:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B041CEEA4;
	Mon, 25 Nov 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k/BTg3sD"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141FD194C8B;
	Mon, 25 Nov 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577091; cv=none; b=codPqICD8MpyXIR5XmSO/IfyTClQTXwhjSwrDdzMORmlk12KUn6Im2BbDXMuKUM/KEZPWiHrGzcnkII1L8nYTKAMl4r0tmVZh44wSVKF4vZ1ag/vXYmAG29f/HerbT7KTTMUCpoLhboZL9N19UfiYstkyLKakvx0Z56Oz10DyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577091; c=relaxed/simple;
	bh=RUe7LYKTRQEazCAW4kdsUvfb831dV1tyPwmwQGhHIHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UGIfeRkXypTkNoDDaSAnJNwPo6057U5R2gf7B9c8TG38P190czW+hq60p7CI85YPRCjb6M3AN3R+vKE1mfuo9QM6GOMLt42FjdM5+7ELFMhXGqqoItN+jAzMcOIr3pekJouM1F+u3EmEUbC/M8G8ayZiz+ZgqM4JtPwkh1hSYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k/BTg3sD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4EF0B20545A2;
	Mon, 25 Nov 2024 15:24:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EF0B20545A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732577088;
	bh=+ZUBgfn/rgPsUR5HZKGJtyuIovuDjkngqu0F5dQSNOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/BTg3sDGbiE5t96dO8rwKRCR+lyGmOaRzUCW8l0W78/XGdLev+2d4chhhI3VjVOh
	 gmq4+9XJUVCiWjVlFDThVL8CatxbMRaByRl+HaXXUydPNigj+X/HJGWXTJl7bO+Tku
	 f7Vb5WOWUOU+Nz6sI1OyYE/++hc3B1WPyx69BCnk=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	sgarzare@redhat.com,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com,
	vkuznets@redhat.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	eahariha@linux.microsoft.com,
	horms@kernel.org
Subject: [PATCH v3 4/5] hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h
Date: Mon, 25 Nov 2024 15:24:43 -0800
Message-Id: <1732577084-2122-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Switch to using hvhdk.h everywhere in the kernel. This header
includes all the new Hyper-V headers in include/hyperv, which form a
superset of the definitions found in hyperv-tlfs.h.

This makes it easier to add new Hyper-V interfaces without being
restricted to those in the TLFS doc (reflected in hyperv-tlfs.h).

To be more consistent with the original Hyper-V code, the names of
some definitions are changed slightly. Update those where needed.

Update comments in mshyperv.h files to point to include/hyperv for
adding new definitions.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c        |  2 +-
 arch/arm64/hyperv/mshyperv.c       |  4 ++--
 arch/arm64/include/asm/mshyperv.h  |  7 +++----
 arch/x86/hyperv/hv_init.c          | 20 ++++++++++----------
 arch/x86/hyperv/hv_proc.c          |  2 +-
 arch/x86/hyperv/nested.c           |  2 +-
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/include/asm/mshyperv.h    |  2 +-
 arch/x86/include/asm/svm.h         |  2 +-
 arch/x86/kernel/cpu/mshyperv.c     |  2 +-
 arch/x86/kvm/vmx/hyperv_evmcs.h    |  2 +-
 arch/x86/kvm/vmx/vmx_onhyperv.h    |  2 +-
 drivers/clocksource/hyperv_timer.c |  2 +-
 drivers/hv/hv_balloon.c            |  4 ++--
 drivers/hv/hv_common.c             |  2 +-
 drivers/hv/hv_kvp.c                |  2 +-
 drivers/hv/hv_snapshot.c           |  2 +-
 drivers/hv/hyperv_vmbus.h          |  2 +-
 include/asm-generic/mshyperv.h     |  7 +++----
 include/clocksource/hyperv_timer.h |  2 +-
 include/linux/hyperv.h             |  2 +-
 net/vmw_vsock/hyperv_transport.c   |  6 +++---
 22 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 7a746a5a6b42..69004f619c57 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -14,7 +14,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/module.h>
 #include <asm-generic/bug.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 
 /*
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index b1a4de4eee29..fc49949b7df6 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -49,12 +49,12 @@ static int __init hyperv_init(void)
 	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
 
 	/* Get the features and hints from Hyper-V */
-	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
+	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES_INFO, &result);
 	ms_hyperv.features = result.as32.a;
 	ms_hyperv.priv_high = result.as32.b;
 	ms_hyperv.misc_features = result.as32.c;
 
-	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
+	hv_get_vpreg_128(HV_REGISTER_FEATURES_INFO, &result);
 	ms_hyperv.hints = result.as32.a;
 
 	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index a975e1a689dd..2e2f83bafcfb 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -6,9 +6,8 @@
  * the ARM64 architecture.  See include/asm-generic/mshyperv.h for
  * definitions are that architecture independent.
  *
- * Definitions that are specified in the Hyper-V Top Level Functional
- * Spec (TLFS) should not go in this file, but should instead go in
- * hyperv-tlfs.h.
+ * Definitions that are derived from Hyper-V code or headers should not go in
+ * this file, but should instead go in the relevant files in include/hyperv.
  *
  * Copyright (C) 2021, Microsoft, Inc.
  *
@@ -20,7 +19,7 @@
 
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3562826915f9..3cf2a227d666 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -19,7 +19,7 @@
 #include <asm/sev.h>
 #include <asm/ibt.h>
 #include <asm/hypervisor.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
 #include <asm/set_memory.h>
@@ -415,24 +415,24 @@ static void __init hv_get_partition_id(void)
 static u8 __init get_vtl(void)
 {
 	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
-	struct hv_get_vp_registers_input *input;
-	struct hv_get_vp_registers_output *output;
+	struct hv_input_get_vp_registers *input;
+	struct hv_register_assoc *output;
 	unsigned long flags;
 	u64 ret;
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_get_vp_registers_output *)input;
+	output = (struct hv_register_assoc *)input;
 
-	memset(input, 0, struct_size(input, element, 1));
-	input->header.partitionid = HV_PARTITION_ID_SELF;
-	input->header.vpindex = HV_VP_INDEX_SELF;
-	input->header.inputvtl = 0;
-	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
+	memset(input, 0, struct_size(input, names, 1));
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->vp_index = HV_VP_INDEX_SELF;
+	input->input_vtl.as_uint8 = 0;
+	input->names[0] = HV_REGISTER_VSM_VP_STATUS;
 
 	ret = hv_do_hypercall(control, input, output);
 	if (hv_result_success(ret)) {
-		ret = output->as64.low & HV_X64_VTL_MASK;
+		ret = output->value.reg8 & HV_X64_VTL_MASK;
 	} else {
 		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
 		BUG();
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index b74c06c04ff1..ac4c834d4435 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -176,7 +176,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
 		input->flags = flags;
-		input->subnode_type = HvSubnodeAny;
+		input->subnode_type = HV_SUBNODE_ANY;
 		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
 		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
 		local_irq_restore(irq_flags);
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 9dc259fa322e..1083dc8646f9 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -11,7 +11,7 @@
 
 
 #include <linux/types.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 46f354b12488..e8aeb4b4f868 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -35,8 +35,8 @@
 #include <asm/asm.h>
 #include <asm/kvm_page_track.h>
 #include <asm/kvm_vcpu_regs.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/reboot.h>
+#include <hyperv/hvhdk.h>
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6f866fb9ffee..f91ab1e75f9f 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -6,9 +6,9 @@
 #include <linux/nmi.h>
 #include <linux/msi.h>
 #include <linux/io.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
+#include <hyperv/hvhdk.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 2b59b9951c90..77704eddba54 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -5,7 +5,7 @@
 #include <uapi/asm/svm.h>
 #include <uapi/asm/kvm.h>
 
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 /*
  * 32-bit intercept words in the VMCB Control Area, starting
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d18078834ded..fc13bdebf360 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -19,7 +19,7 @@
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 #include <asm/desc.h>
 #include <asm/idtentry.h>
diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
index a543fccfc574..6536290f4274 100644
--- a/arch/x86/kvm/vmx/hyperv_evmcs.h
+++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
@@ -6,7 +6,7 @@
 #ifndef __KVM_X86_VMX_HYPERV_EVMCS_H
 #define __KVM_X86_VMX_HYPERV_EVMCS_H
 
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #include "capabilities.h"
 #include "vmcs12.h"
diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
index bba24ed99ee6..cdf8cbb69209 100644
--- a/arch/x86/kvm/vmx/vmx_onhyperv.h
+++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
@@ -3,7 +3,7 @@
 #ifndef __ARCH_X86_KVM_VMX_ONHYPERV_H__
 #define __ARCH_X86_KVM_VMX_ONHYPERV_H__
 
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 
 #include <linux/jump_label.h>
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 99177835cade..b5f78abd447e 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -23,7 +23,7 @@
 #include <linux/acpi.h>
 #include <linux/hyperv.h>
 #include <clocksource/hyperv_timer.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index c38dcdfcb914..d792df113962 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -28,7 +28,7 @@
 #include <linux/sizes.h>
 
 #include <linux/hyperv.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #include <asm/mshyperv.h>
 
@@ -1585,7 +1585,7 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 		return -ENOSPC;
 	}
 
-	hint->type = HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
+	hint->heat_type = HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
 	hint->reserved = 0;
 	for_each_sg(sgl, sg, nents, i) {
 		union hv_gpa_page_range *range;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 7a35c82976e0..c4fd07d9bf1a 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -28,7 +28,7 @@
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <linux/set_memory.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 
 /*
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c06114..bfb7a518b4ed 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -27,7 +27,7 @@
 #include <linux/connector.h>
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #include "hyperv_vmbus.h"
 #include "hv_utils_transport.h"
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be1691..097ebd58f14e 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -12,7 +12,7 @@
 #include <linux/connector.h>
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #include "hyperv_vmbus.h"
 #include "hv_utils_transport.h"
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index d2856023d53c..6e2b87456300 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -15,10 +15,10 @@
 #include <linux/list.h>
 #include <linux/bitops.h>
 #include <asm/sync_bitops.h>
-#include <asm/hyperv-tlfs.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
+#include <hyperv/hvhdk.h>
 
 #include "hv_trace.h"
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8fe7aaab2599..a7bbe504e4f3 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -6,9 +6,8 @@
  * independent. See arch/<arch>/include/asm/mshyperv.h for definitions
  * that are specific to architecture <arch>.
  *
- * Definitions that are specified in the Hyper-V Top Level Functional
- * Spec (TLFS) should not go in this file, but should instead go in
- * hyperv-tlfs.h.
+ * Definitions that are derived from Hyper-V code or headers should not go in
+ * this file, but should instead go in the relevant files in include/hyperv.
  *
  * Copyright (C) 2019, Microsoft, Inc.
  *
@@ -25,7 +24,7 @@
 #include <linux/cpumask.h>
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #define VTPM_BASE_ADDRESS 0xfed40000
 
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 6cdc873ac907..a4c81a60f53d 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -15,7 +15,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d0893ec488ae..ed65b20defea 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -24,7 +24,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/reciprocal_div.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #define MAX_PAGE_BUFFER_COUNT				32
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 56c232cf5b0f..31342ab502b4 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -13,12 +13,12 @@
 #include <linux/hyperv.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 /* Older (VMBUS version 'VERSION_WIN10' or before) Windows hosts have some
  * stricter requirements on the hv_sock ring buffer size of six 4K pages.
- * hyperv-tlfs defines HV_HYP_PAGE_SIZE as 4K. Newer hosts don't have this
- * limitation; but, keep the defaults the same for compat.
+ * HV_HYP_PAGE_SIZE is defined as 4K. Newer hosts don't have this limitation;
+ * but, keep the defaults the same for compat.
  */
 #define RINGBUFFER_HVS_RCV_SIZE (HV_HYP_PAGE_SIZE * 6)
 #define RINGBUFFER_HVS_SND_SIZE (HV_HYP_PAGE_SIZE * 6)
-- 
2.34.1


