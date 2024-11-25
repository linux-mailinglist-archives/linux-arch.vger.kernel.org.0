Return-Path: <linux-arch+bounces-9156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074F9D8EFE
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 00:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1526016ABFF
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2024 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E041CB528;
	Mon, 25 Nov 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s2arBio/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05A1946C3;
	Mon, 25 Nov 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577090; cv=none; b=mQ8lyKWfk1rS91dRuwVfGpKWh5QFCyD8FHPZGJDDt+C15Ifb8+7P1r7l6tezz6IqWtLGjOBwCXNvWwU7xd0vMUHEBjWmt7JAYJAHMXPkfWYl+1wmVfUljbDyFPZMPlWZLVvfkFma/RA2UwTo96oNFF5A6Bda+Hlvo9iZ/7jDjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577090; c=relaxed/simple;
	bh=UVWJMNMJnOI1SS0qcTDTj8boSwJyZB4CTpRaJODuI4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QeYZ5s1yZl2F1YkrCpiI3dO9Hkf1DAeMJmSSC7R0IppYmd4bMEQcRhKGZG3I5QZS+oAvGfTEbZqGtTsQpBeIxWMg5jO0Obe/Eaqq6UTk7DV1LKCwKuyrix9Jr99trdmJ5KiskLRFgrDKBzZqJJLPHRO7jaJq6YfpH7MMWf6PIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s2arBio/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CC61205459E;
	Mon, 25 Nov 2024 15:24:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CC61205459E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732577088;
	bh=OHKKLJ+dashHMTJsp9vYfQeMGkpF69ZLXCLtBTMnDzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2arBio/1XcnR749uDCDchArPfFvUxhCSHHEkyoBSIL+JQ8zHFCsQen1n17O64fcA
	 NhmiZDm03zTPnKFT7d2uP07+kK8JLm3sNmmrvbjSfpSWtxbSJJ+8taobUCEuaqfp3G
	 eO+EX/Et4oTU+9o4kDY3NLxunUGOGcm6X5L5bwNw=
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
Subject: [PATCH v3 2/5] hyperv: Clean up unnecessary #includes
Date: Mon, 25 Nov 2024 15:24:41 -0800
Message-Id: <1732577084-2122-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Remove includes of linux/hyperv.h, mshyperv.h, and hyperv-tlfs.h where
they are not used.

Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/hyperv/hv_core.c     | 1 -
 arch/x86/hyperv/hv_apic.c       | 1 -
 arch/x86/hyperv/hv_init.c       | 1 -
 arch/x86/hyperv/hv_proc.c       | 1 -
 arch/x86/hyperv/ivm.c           | 1 -
 arch/x86/hyperv/mmu.c           | 1 -
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/include/asm/mshyperv.h | 1 -
 arch/x86/mm/pat/set_memory.c    | 2 --
 9 files changed, 10 deletions(-)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index f1ebc025e1df..7a746a5a6b42 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/hyperv.h>
 #include <linux/arm-smccc.h>
 #include <linux/module.h>
 #include <asm-generic/bug.h>
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
index 95eada2994e1..3562826915f9 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -27,7 +27,6 @@
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
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e159e44a6a1b..46f354b12488 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -24,7 +24,6 @@
 #include <linux/pvclock_gtod.h>
 #include <linux/clocksource.h>
 #include <linux/irqbypass.h>
-#include <linux/hyperv.h>
 #include <linux/kfifo.h>
 #include <linux/sched/vhost_task.h>
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5f0bc6a6d025..6f866fb9ffee 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -9,7 +9,6 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
-#include <asm/mshyperv.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 069e421c2247..128e3448ae4f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -32,8 +32,6 @@
 #include <asm/pgalloc.h>
 #include <asm/proto.h>
 #include <asm/memtype.h>
-#include <asm/hyperv-tlfs.h>
-#include <asm/mshyperv.h>
 
 #include "../mm_internal.h"
 
-- 
2.34.1


