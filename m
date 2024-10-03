Return-Path: <linux-arch+bounces-7673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298498F75B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D98B1C21792
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9531CC154;
	Thu,  3 Oct 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UZU7Ua9T"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908691B85CD;
	Thu,  3 Oct 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985080; cv=none; b=C6zs3eLS3VgEDEvg/Wamo/6/5qEK/gm1+TKc2oF90wuPmdqhKrxZzdAo3YgFs3H0mbJlisfk+u6KuMD4CQEm0ej4ryacX755XB4kdQmK8F5x4PtybAQ8U1Asd7IADogc7l0ILYCJncE1kCJi1IbG5JtHViXI5RMtFC565km3PHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985080; c=relaxed/simple;
	bh=btQTL1CwXScnqG+8hxAGtefwCo8AjovT9vkvxIWnQUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GqzpglQ9BfP4hYI/ckU+lGAgDnsJcBYUVVspYmLl3G6zgc7oIGZNk6W6D/UsFjSCi9PKQk+qXIXdHWT/5j5UWxDPCftNxlCAo4YErV9nIhyWBKL3IES0wjVWv7I1CnuvEFAP0CsinBjz4EYtE0GfCs+eWAKSSROWTlwhjaeZTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UZU7Ua9T; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7480C20DB362;
	Thu,  3 Oct 2024 12:51:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7480C20DB362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727985070;
	bh=kjAmLLXPZLA9nM0ptEZ4YBcAzeekWKCJ1ye+7nS9LiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZU7Ua9ToVi/LsN5CRm/YoIJ1UG3CRa0YVkRMgcLpILwOn8E0WZH/5bV74INCcyJ5
	 Nm84mVqfMIhILD6ezLKgADSyNpQIUTlzahiOpKdfkE3YR+fBFhLyAW7zxBJIUXn8/B
	 2MHCHWW/gWuohGMmcKVrVGPlHmTB0GBbv7mwnt+M=
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
	mukeshrathor@microsoft.com
Subject: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code
Date: Thu,  3 Oct 2024 12:51:04 -0700
Message-Id: <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

To move toward importing headers from Hyper-V directly, switch to
using hvhdk.h in all Hyper-V code. KVM code that uses Hyper-V
definitions from hyperv-tlfs.h remains untouched.

Add HYPERV_NONTLFS_HEADERS everywhere mshyperv.h, asm/svm.h,
clocksource/hyperv_timer.h is included in Hyper-V code.

Replace hyperv-tlfs.h with hvhdk.h directly in linux/hyperv.h, and
define HYPERV_NONTLFS_HEADERS there, since it is only used in
Hyper-V device code.

Update a couple of definitions to updated names found in the new
headers: HV_EXT_MEM_HEAT_HINT, HV_SUBNODE_TYPE_ANY.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c              | 1 +
 arch/arm64/hyperv/mshyperv.c             | 1 +
 arch/x86/entry/vdso/vma.c                | 1 +
 arch/x86/hyperv/hv_apic.c                | 1 +
 arch/x86/hyperv/hv_init.c                | 1 +
 arch/x86/hyperv/hv_proc.c                | 3 ++-
 arch/x86/hyperv/hv_spinlock.c            | 1 +
 arch/x86/hyperv/hv_vtl.c                 | 1 +
 arch/x86/hyperv/irqdomain.c              | 1 +
 arch/x86/hyperv/ivm.c                    | 1 +
 arch/x86/hyperv/mmu.c                    | 1 +
 arch/x86/hyperv/nested.c                 | 1 +
 arch/x86/include/asm/vdso/gettimeofday.h | 1 +
 arch/x86/kernel/cpu/mshyperv.c           | 1 +
 arch/x86/kernel/cpu/mtrr/generic.c       | 1 +
 drivers/clocksource/hyperv_timer.c       | 1 +
 drivers/hv/channel.c                     | 1 +
 drivers/hv/channel_mgmt.c                | 1 +
 drivers/hv/connection.c                  | 1 +
 drivers/hv/hv.c                          | 1 +
 drivers/hv/hv_balloon.c                  | 3 ++-
 drivers/hv/hv_common.c                   | 1 +
 drivers/hv/hv_util.c                     | 1 +
 drivers/hv/ring_buffer.c                 | 1 +
 drivers/hv/vmbus_drv.c                   | 1 +
 drivers/iommu/hyperv-iommu.c             | 1 +
 drivers/net/hyperv/netvsc.c              | 1 +
 drivers/pci/controller/pci-hyperv.c      | 1 +
 include/linux/hyperv.h                   | 3 ++-
 29 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 9d1969b875e9..bb7f28f74bf4 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -14,6 +14,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/module.h>
 #include <asm-generic/bug.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 /*
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index b1a4de4eee29..62b2a270ae65 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/version.h>
 #include <linux/cpuhotplug.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 static bool hyperv_initialized;
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 6d83ceb7f1ba..5f4053c49658 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -25,6 +25,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <clocksource/hyperv_timer.h>
 
 #undef _ASM_X86_VVAR_H
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f022d5f64fb6..4fe3b3b13256 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
 #include <asm/hypervisor.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
 
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index fc3c3d76c181..680c4abc456e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -19,6 +19,7 @@
 #include <asm/sev.h>
 #include <asm/ibt.h>
 #include <asm/hypervisor.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
 #include <asm/set_memory.h>
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index b74c06c04ff1..428542134b84 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -7,6 +7,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/minmax.h>
 #include <asm/hypervisor.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
 
@@ -176,7 +177,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 		input->partition_id = partition_id;
 		input->vp_index = vp_index;
 		input->flags = flags;
-		input->subnode_type = HvSubnodeAny;
+		input->subnode_type = HV_SUBNODE_ANY;
 		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
 		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
 		local_irq_restore(irq_flags);
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 151e851bef09..7e8e2c03f669 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -12,6 +12,7 @@
 
 #include <linux/spinlock.h>
 
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c..a8bb6ad7efb6 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -10,6 +10,7 @@
 #include <asm/boot.h>
 #include <asm/desc.h>
 #include <asm/i8259.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/realmode.h>
 #include <../kernel/smpboot.h>
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 3215a4a07408..977f90d08471 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -10,6 +10,7 @@
 
 #include <linux/pci.h>
 #include <linux/irq.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 static int hv_map_interrupt(union hv_device_id device_id, bool level,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b56d70612734..557a308e8e0a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/svm.h>
 #include <asm/sev.h>
 #include <asm/io.h>
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cc8c3bd0e7c2..6bf9915611b8 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 #include <asm/fpu/api.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/msr.h>
 #include <asm/tlbflush.h>
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index ee06d0315c24..03775d72b7f9 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -11,6 +11,7 @@
 
 
 #include <linux/types.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index b2d2df026f6e..528ac66e366b 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -18,6 +18,7 @@
 #include <asm/unistd.h>
 #include <asm/msr.h>
 #include <asm/pvclock.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <clocksource/hyperv_timer.h>
 
 #define __vdso_data (VVAR(_vdso_data))
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 8e8fd23b1439..59bb8ab93dc2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -20,6 +20,7 @@
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/desc.h>
 #include <asm/idtentry.h>
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 7b29ebda024f..22228f2f550d 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -13,6 +13,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
 #include <asm/hypervisor.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
 #include <asm/mtrr.h>
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 1b7de45a7185..ec37476c4e15 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/acpi.h>
 #include <linux/hyperv.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fb8cd8469328..76d3c27e961e 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/set_memory.h>
 #include <asm/page.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3c6011a48dab..e6d56c73175a 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/hyperv.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 #include <linux/sched/isolation.h>
 
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f001ae880e1d..88546b0c2242 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -21,6 +21,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/set_memory.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index e0d676c74f14..42f3790656e2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -18,6 +18,7 @@
 #include <linux/clockchips.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include <linux/set_memory.h>
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index a120e9b80ded..6b270ee75747 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -28,6 +28,7 @@
 #include <linux/sizes.h>
 
 #include <linux/hyperv.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 #define CREATE_TRACE_POINTS
@@ -1583,7 +1584,7 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
 		return -ENOSPC;
 	}
 
-	hint->type = HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
+	hint->heat_type = HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
 	hint->reserved = 0;
 	for_each_sg(sgl, sg, nents, i) {
 		union hv_gpa_page_range *range;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a5217f837237..2723711868bc 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <linux/set_memory.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 /*
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index c4f525325790..a17f6e6024a4 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -17,6 +17,7 @@
 #include <linux/hyperv.h>
 #include <linux/clockchips.h>
 #include <linux/ptp_clock_kernel.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 3c9b02471760..6bfd064b4e65 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <linux/io.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7242c4920427..71745d62e064 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -36,6 +36,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8a5c17b97310..ade14cc9c071 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -20,6 +20,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/hypervisor.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 #include "irq_remapping.h"
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 2b6ec979a62f..55095c02cc78 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -23,6 +23,7 @@
 #include <linux/filter.h>
 
 #include <asm/sync_bitops.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 #include "hyperv_net.h"
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cdd5be16021d..261ff8b80caa 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -50,6 +50,7 @@
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
 #include <linux/sizes.h>
+#define HYPERV_NONTLFS_HEADERS
 #include <asm/mshyperv.h>
 
 /*
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d0893ec488ae..64fd385723fc 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -24,7 +24,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/reciprocal_div.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hvhdk.h>
+#define HYPERV_NONTLFS_HEADERS
 
 #define MAX_PAGE_BUFFER_COUNT				32
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
-- 
2.34.1


