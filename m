Return-Path: <linux-arch+bounces-7671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3F98F747
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9741F22580
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 19:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34991B85DB;
	Thu,  3 Oct 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fuaXyXJo"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658191ACDEB;
	Thu,  3 Oct 2024 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985078; cv=none; b=OrMhMxxsvMwUv/gOxkV0uXtz+pkUYbQEjaIbr4MjsOUR1BpprlxsS1TPm3GGx/0jQpjYKlvAEtm1r/lswn2vJlcNzeaaqiOUJrObaXiGSWvgLQ41aeOzEUGwJGJO6VjpDFuww8EaEUhjCMTOVgCfqpM8HCTtGhzi2NIu39EqneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985078; c=relaxed/simple;
	bh=LhtLB4YGKMiaOHhRRTtehW9OXTqO7Xqtjbxn2VoZyVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=T1iUB2sI/vXcgfUq8o141CVxV463FVfC2zDJYLoEgjPKyPG7By05fPe56NOgsvFwAQcvDO3OW4tX5Rrwbzq9Id8XSwPZ2dPQErW/mh6mf9Z2lnfGwSC1rUl9cswJ71jLuqkyD+ybN1RNmag0yaon59y2HOYFDCD2gzg2sNSeJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fuaXyXJo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56EE220DB361;
	Thu,  3 Oct 2024 12:51:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56EE220DB361
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727985070;
	bh=JiDb5otwBlZ2fSTUj+3NhEfBnILv57r/Yi/wQf7ZOB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuaXyXJoJB29GRcwocoVii/RsZUekk3IOmJWWzJE0tudoe3goRw4VnswdQI/zl3qP
	 1IIKQQZPEQvpjKzVZ4jMCSlOMaz4s0qNs1eUme/pNK7lCdhymqr3sa1hgaq3EWwMF5
	 FcZkxopIwM2dQFq1esrekalvhUR4/XEDSc4K5wO8=
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
Subject: [PATCH 4/5] hyperv: Add hv_defs.h to conditionally include hyperv-tlfs.h or hvhdk.h
Date: Thu,  3 Oct 2024 12:51:03 -0700
Message-Id: <1727985064-18362-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Include one or the other depending on whether HYPERV_NONTLFS_HEADERS is
defined.

This will allow Hyper-V code to use the new headers while other code can
continue using hyperv-tlfs.h which is only for Hyper-V guests.

Replace hyperv-tlfs.h in shared headers with hv_defs.h These headers are
shared between Hyper-V code and non-Hyper-V code (KVM for example). This
will allow switching to the new headers in Hyper-V code only.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h  |  2 +-
 arch/x86/include/asm/mshyperv.h    |  2 +-
 arch/x86/include/asm/svm.h         |  2 +-
 include/asm-generic/mshyperv.h     |  2 +-
 include/clocksource/hyperv_timer.h |  2 +-
 include/hyperv/hv_defs.h           | 29 +++++++++++++++++++++++++++++
 6 files changed, 34 insertions(+), 5 deletions(-)
 create mode 100644 include/hyperv/hv_defs.h

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index a975e1a689dd..13b2b2218d85 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -20,7 +20,7 @@
 
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hv_defs.h>
 
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 47ca48062547..dc8587f02850 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -6,9 +6,9 @@
 #include <linux/nmi.h>
 #include <linux/msi.h>
 #include <linux/io.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
+#include <hyperv/hv_defs.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f0dea3750ca9..c682fc080310 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -5,7 +5,7 @@
 #include <uapi/asm/svm.h>
 #include <uapi/asm/kvm.h>
 
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hv_defs.h>
 
 /*
  * 32-bit intercept words in the VMCB Control Area, starting
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8fe7aaab2599..8bd308ae1056 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -25,7 +25,7 @@
 #include <linux/cpumask.h>
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hv_defs.h>
 
 #define VTPM_BASE_ADDRESS 0xfed40000
 
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 6cdc873ac907..068ca1934c23 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -15,7 +15,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/math64.h>
-#include <asm/hyperv-tlfs.h>
+#include <hyperv/hv_defs.h>
 
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
diff --git a/include/hyperv/hv_defs.h b/include/hyperv/hv_defs.h
new file mode 100644
index 000000000000..eed500288499
--- /dev/null
+++ b/include/hyperv/hv_defs.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file includes Microsoft Hypervisor definitions from hyperv-tlfs.h, or
+ * hvhdk.h when HYPERV_NONTLFS_HEADERS is defined.
+ */
+/*
+ * NOTE:
+ * The typical #ifdef guard to prevent redefinition errors is intentionally
+ * omitted. This makes compiler error (either via #error or redefinition) in
+ * the case where hyperv-tlfs.h is accidentally included, followed by
+ * definition of HYPERV_NON_TLFS_HEADERS and inclusion of this file.
+ * If this file could only be included once, the compiler would ignore the
+ * attempt to use HYPERV_NONTLFS_HEADERS to include hvhdk.h.
+ */
+
+#ifdef HYPERV_NONTLFS_HEADERS
+
+#ifdef HYPERV_TLFS_HEADERS_INCLUDED
+#error "hyperv-tlfs.h was already included before HYPERV_NONTLFS_HEADERS was defined"
+#else
+#include <hyperv/hvhdk.h>
+#endif
+
+#else /* HYPERV_NONTLFS_HEADERS */
+
+#include <asm/hyperv-tlfs.h>
+#define HYPERV_TLFS_HEADERS_INCLUDED
+
+#endif /* !HYPERV_NONTLFS_HEADERS */
-- 
2.34.1


