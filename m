Return-Path: <linux-arch+bounces-8912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC579C11C1
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 23:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA5284797
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 22:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BE21A4B2;
	Thu,  7 Nov 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q2fZw2+p"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A0421949F;
	Thu,  7 Nov 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018759; cv=none; b=auhUXnoe/11A1njOvxM/e4zbFV60+HBznQM7K8AbNLAAymKG59iHgMmn5H6TS1gg1yJY8mCRiOV61XN3ecEM3WC1jTv0eqj01RubFWnfV6HXpkQViFcH0ukzuQ9aCFKpBpb9EVQIkDJG4zV2qRlXV9YeP+WrP4I71A/bf9EdXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018759; c=relaxed/simple;
	bh=tR8iXEBwpD0LLZrxVx5lj9uYsF9RR9qjPp+THKUJDCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mctsSRi0iyxQANyA9mm22dGvLDEE9oC6Gpt7pBSkH/WH3FyVeb5EyBzhxrzWVHAq6vpGyGwbDCVmDY4CuOOtVbChLGrDB/cuxJH8yYKI4OQEMkq7RcW8CL1NZdHcI/haI8c2BtpNcKbLVHkyMp/SOQAb/2Un4Vc7UbFx3oBAWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q2fZw2+p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33511212D51C;
	Thu,  7 Nov 2024 14:32:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33511212D51C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731018751;
	bh=Vq/vY32w9rdlY2b2Ixvmg38QFVQo19hztVIF2ZppY04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2fZw2+p4MhkKXpeMpBulSAJuqQjsv3OM3ZlhDaf8mki62T1uBMZTZFltc09Mt6+u
	 UnVQu9d9eeshje+J0+Tw+8stPdcGuYGXQXq66vOxRNEI08/x05ryp01bHy4L8N5dCM
	 PBrswxheYJzMbGyVyQRBLlodSJc3NM40TYGSvleU=
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
	apais@linux.microsoft.com
Subject: [PATCH v2 4/4] hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h
Date: Thu,  7 Nov 2024 14:32:26 -0800
Message-Id: <1731018746-25914-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Switch to using hvhdk.h everywhere in the kernel. This header includes
all the new Hyper-V headers in include/hyperv, which form a superset of
the definitions found in hyperv-tlfs.h.

This makes it easier to add new Hyper-V interfaces without being
restricted to those in the TLFS doc (reflected in hyperv-tlfs.h).

To be more consistent with the original Hyper-V code, the names of some
definitions are changed slightly. Update those where needed.

hyperv-tlfs.h is no longer included anywhere - hvhdk.h can serve
the same role, but with an easier path for adding new definitions.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c        |  2 +-
 arch/arm64/hyperv/mshyperv.c       |  4 ++--
 arch/arm64/include/asm/mshyperv.h  |  2 +-
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
 include/asm-generic/mshyperv.h     |  2 +-
 include/clocksource/hyperv_timer.h |  2 +-
 include/linux/hyperv.h             |  2 +-
 net/vmw_vsock/hyperv_transport.c   |  2 +-
 22 files changed, 33 insertions(+), 33 deletions(-)

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
index a975e1a689dd..7595fb35fae6 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -20,7 +20,7 @@
 
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 1a6354b3e582..3f9aef157c88 100644
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
@@ -416,24 +416,24 @@ static void __init hv_get_partition_id(void)
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
+	input->names[0] = HV_X64_REGISTER_VSM_VP_STATUS;
 
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
index 3627eab994a3..38cd609f37c7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -34,7 +34,7 @@
 #include <asm/asm.h>
 #include <asm/kvm_page_track.h>
 #include <asm/kvm_vcpu_regs.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 47ca48062547..f0564e599b7f 100644
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
index f0dea3750ca9..913af68ad660 100644
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
index e0fd57a8ba84..be0d1f4491d9 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -20,7 +20,7 @@
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
index eb48153bfd73..2b94ff301712 100644
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
index b2a080647e41..c1cc96a168c7 100644
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
index 9c452bfbd571..9ea05cbbf50d 100644
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
index 76ac5185a01a..2bea654858e3 100644
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
index 8fe7aaab2599..138e416a0f9c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -25,7 +25,7 @@
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
index e2157e387217..152b6ed8877d 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -13,7 +13,7 @@
 #include <linux/hyperv.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
 
 /* Older (VMBUS version 'VERSION_WIN10' or before) Windows hosts have some
  * stricter requirements on the hv_sock ring buffer size of six 4K pages.
-- 
2.34.1


