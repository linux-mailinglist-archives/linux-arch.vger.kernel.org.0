Return-Path: <linux-arch+bounces-8911-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207A99C11BC
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 23:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF55284831
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 22:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56734219CAE;
	Thu,  7 Nov 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GL5L+XWB"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498B21949D;
	Thu,  7 Nov 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018759; cv=none; b=uRv4YYk9J3pqPxOf9qpNk/z5PimFKcvH72JFLEjtbA1fH0k9Z1+mJ0rsAaAsCglyUDpA2R7pQ0IqbV6gptkPSezJ+CrILfT+mIbvpz85feoexSHj67A2lpNNfNbqPwfbsQp0rpLsqI/m8PG9kwWlUnq2Vye64D4e0pnAQYc0XkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018759; c=relaxed/simple;
	bh=r3108wtGeWB3urxqS2Mk2Aj6a5OFx8DrBZR9aUYNRgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ARAnErsH6edd1y9/yd3nxzx77XGtCWM8XZelRooj966xXC/eo3FvEV9hPSUplE6zniexOjX0PmgndzYoLbkqUxf2+q9dTCG73yoPFeXujtlx4jbOH9pQKZthxI/Fevyv66512kGb/FMnv6fTEWsTzQnbRVvGOwkqftSEtdSzeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GL5L+XWB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E7B68212D516;
	Thu,  7 Nov 2024 14:32:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7B68212D516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731018751;
	bh=oHc+xQlGELt4En+c+7A/3z04pCZMqJzqUOIthFcFkJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GL5L+XWBdQN0CU0yQzh/oq0vV6hbhcS/bNEnSQdxzEaESNw65fptL+NJKgM1Gen28
	 c3bykADGMex7+FRS3+DS62C4YYb9jk/FI0g7R/Hr86yKUJuqwQbcSXbVexHGykm8JI
	 t0alQ+hR1JEoU5hMKNS3j4wBN4/qb9DzOk3FwcMo=
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
Subject: [PATCH v2 2/4] hyperv: Clean up unnecessary #includes
Date: Thu,  7 Nov 2024 14:32:24 -0800
Message-Id: <1731018746-25914-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Remove includes of linux/hyperv.h, mshyperv.h, and hyperv-tlfs.h where
they are not used.

Acked-by: Wei Liu <wei.liu@kernel.org>
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
index 17a71e92a343..1a6354b3e582 100644
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
 
-- 
2.34.1


