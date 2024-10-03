Return-Path: <linux-arch+bounces-7672-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E96698F74E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A826A1C216A5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09011B85FB;
	Thu,  3 Oct 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UBmb2ViD"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A121AC8B8;
	Thu,  3 Oct 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985078; cv=none; b=tq5+WGk0rRupNr9X7FRkM0DKC5EH2LxtxtarHfQJLNJ6oSz3tYIh5r7RdEy6nSAhQvfoFe6JY6+aPkYfXYb5grGOtxA1p7l3FZpS+yQsimjWxyvXt37bk9Cy2sElhmovYd7MHQhAI5Uo1OBcjPXzAoHFn+YPeXQuoc5+gDwilms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985078; c=relaxed/simple;
	bh=U7me6UQP32DZ89TfW8KlGoBwldI0BO3HfVlM/MCGfsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n7BEtxmIHnQWUYNxomfHSzBY1ns3OG7qAvEeIIQW1HJYaqm2FfhMG+OXByiwTSt/i5NErf0TFZwiBan2M4YtgIgt6dzt/InpjlSJTLDMYsZ5TSplxzD7YwYKsG+f2fhIe69pO2nAenBQLoMdyUyEhi4pFIaClG+jSZw84uxzIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UBmb2ViD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1BAAC20DB35F;
	Thu,  3 Oct 2024 12:51:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BAAC20DB35F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727985070;
	bh=DzqhvXENyz/JXWJzTtxulJeNFgWuBlFIzM6prQTZUNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBmb2ViDVK/MGBj0kw/XDYInbj3I2TZ0IC/8v0t1h4OcMQ//wS5gQq0GuzMdb5wPe
	 3/BZGla/DSFAHUDcjIbInOhN7ZCqFqWADPvX//fee3niT6qx6h4yX7bi9r+uHMWeoL
	 5QHkfxWpz6LSmy6I8ZWb6+u6O0yf8uz5WHfIALsA=
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
Subject: [PATCH 2/5] hyperv: Remove unnecessary #includes
Date: Thu,  3 Oct 2024 12:51:01 -0700
Message-Id: <1727985064-18362-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

asm/hyperv-tlfs.h is already included implicitly wherever mshyperv.h
or linux/hyperv.h is included. Remove those redundancies.

Remove includes of linux/hyperv.h and mshyperv.h where they are not
needed.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c        | 2 --
 arch/x86/hyperv/hv_apic.c          | 1 -
 arch/x86/hyperv/hv_init.c          | 2 --
 arch/x86/hyperv/hv_proc.c          | 1 -
 arch/x86/hyperv/ivm.c              | 1 -
 arch/x86/hyperv/mmu.c              | 1 -
 arch/x86/hyperv/nested.c           | 1 -
 arch/x86/include/asm/kvm_host.h    | 1 -
 arch/x86/include/asm/mshyperv.h    | 1 -
 arch/x86/kernel/cpu/mshyperv.c     | 1 -
 arch/x86/kvm/vmx/vmx_onhyperv.h    | 1 -
 arch/x86/mm/pat/set_memory.c       | 2 --
 drivers/clocksource/hyperv_timer.c | 1 -
 drivers/hv/hv_balloon.c            | 2 --
 drivers/hv/hv_common.c             | 1 -
 drivers/hv/hv_kvp.c                | 1 -
 drivers/hv/hv_snapshot.c           | 1 -
 drivers/hv/hyperv_vmbus.h          | 1 -
 net/vmw_vsock/hyperv_transport.c   | 1 -
 19 files changed, 23 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index f1ebc025e1df..9d1969b875e9 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -11,11 +11,9 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/hyperv.h>
 #include <linux/arm-smccc.h>
 #include <linux/module.h>
 #include <asm-generic/bug.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
 /*
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 0569f579338b..f022d5f64fb6 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -23,7 +23,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/clockchips.h>
-#include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
 #include <asm/hypervisor.h>
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 17a71e92a343..fc3c3d76c181 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -19,7 +19,6 @@
 #include <asm/sev.h>
 #include <asm/ibt.h>
 #include <asm/hypervisor.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
 #include <asm/set_memory.h>
@@ -27,7 +26,6 @@
 #include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
-#include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/cpuhotplug.h>
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 3fa1f2ee7b0d..b74c06c04ff1 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -3,7 +3,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/clockchips.h>
-#include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
 #include <linux/minmax.h>
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 60fc3ed72830..b56d70612734 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/hyperv.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <asm/svm.h>
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 1cc113200ff5..cc8c3bd0e7c2 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -1,6 +1,5 @@
 #define pr_fmt(fmt)  "Hyper-V: " fmt
 
-#include <linux/hyperv.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index 9dc259fa322e..ee06d0315c24 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -11,7 +11,6 @@
 
 
 #include <linux/types.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4a68cb3eba78..3627eab994a3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -24,7 +24,6 @@
 #include <linux/pvclock_gtod.h>
 #include <linux/clocksource.h>
 #include <linux/irqbypass.h>
-#include <linux/hyperv.h>
 #include <linux/kfifo.h>
 
 #include <asm/apic.h>
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 390c4d13956d..47ca48062547 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -9,7 +9,6 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
-#include <asm/mshyperv.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..8e8fd23b1439 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -20,7 +20,6 @@
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/desc.h>
 #include <asm/idtentry.h>
diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
index eb48153bfd73..f4b081eb6521 100644
--- a/arch/x86/kvm/vmx/vmx_onhyperv.h
+++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
@@ -3,7 +3,6 @@
 #ifndef __ARCH_X86_KVM_VMX_ONHYPERV_H__
 #define __ARCH_X86_KVM_VMX_ONHYPERV_H__
 
-#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
 #include <linux/jump_label.h>
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 44f7b2ea6a07..85fa0d4509f0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -32,8 +32,6 @@
 #include <asm/pgalloc.h>
 #include <asm/proto.h>
 #include <asm/memtype.h>
-#include <asm/hyperv-tlfs.h>
-#include <asm/mshyperv.h>
 
 #include "../mm_internal.h"
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b2a080647e41..1b7de45a7185 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -23,7 +23,6 @@
 #include <linux/acpi.h>
 #include <linux/hyperv.h>
 #include <clocksource/hyperv_timer.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index c38dcdfcb914..a120e9b80ded 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -28,8 +28,6 @@
 #include <linux/sizes.h>
 
 #include <linux/hyperv.h>
-#include <asm/hyperv-tlfs.h>
-
 #include <asm/mshyperv.h>
 
 #define CREATE_TRACE_POINTS
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9c452bfbd571..a5217f837237 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <linux/set_memory.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
 /*
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c06114..68e73ec7ab28 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -27,7 +27,6 @@
 #include <linux/connector.h>
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
-#include <asm/hyperv-tlfs.h>
 
 #include "hyperv_vmbus.h"
 #include "hv_utils_transport.h"
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be1691..90fc935e89bd 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -12,7 +12,6 @@
 #include <linux/connector.h>
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
-#include <asm/hyperv-tlfs.h>
 
 #include "hyperv_vmbus.h"
 #include "hv_utils_transport.h"
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 76ac5185a01a..321770d7ce25 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -15,7 +15,6 @@
 #include <linux/list.h>
 #include <linux/bitops.h>
 #include <asm/sync_bitops.h>
-#include <asm/hyperv-tlfs.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index e2157e387217..f77f0ea1ddad 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -13,7 +13,6 @@
 #include <linux/hyperv.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
-#include <asm/hyperv-tlfs.h>
 
 /* Older (VMBUS version 'VERSION_WIN10' or before) Windows hosts have some
  * stricter requirements on the hv_sock ring buffer size of six 4K pages.
-- 
2.34.1


