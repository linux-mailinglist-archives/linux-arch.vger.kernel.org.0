Return-Path: <linux-arch+bounces-13374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E3B42F6E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 04:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC15E7B7D23
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53621ABDB;
	Thu,  4 Sep 2025 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oAbIqkcw"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19641F869E;
	Thu,  4 Sep 2025 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951834; cv=none; b=tktK3rEi5XAWRUpdzV4iyzU420Mvi52mNd0Usk1xP8HmdNpDtrKwC5/a27rMnoqShytA7LTidrStGBKoxua9ja2ICN+gcaiCpyDJBp+n30OL6a+RA5NE3i0jvj5S6Q1OJO8hEDbonACyIp9B+OrXvljWo1YjoGGCIHCBwLEK5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951834; c=relaxed/simple;
	bh=IjlZPYXTBtYlYrypJ72vUJfsaObcMKI3XybtAbZMtgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWNG6lplbtOCT89NpDWmYqo4mJAQIi/qJEM5CIRcGM/AyIoz5233dUmvHBZzOjBMVvnu0oZG++hqNSIYpH5brj6tQXc3NOMXPt8uE9cbxPvI9qov17JovXGKsYTb40JruaI9jRcIyENU6uvC7TtAGjWK3MKMWOycYHAM6jlVsys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oAbIqkcw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B21F02119CBB;
	Wed,  3 Sep 2025 19:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B21F02119CBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756951832;
	bh=No7MDoBUN5vu1bWJS9xH97RmItizDW8HhObvH3FVga0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAbIqkcwLmjaSkRTT4H1arFfJHvEoavjSs4m8vAjn1tfJgMcp6Rr384IRtaucw13V
	 jAUfhJC6/l3EE3S4BALUWd3H1kesaC5MAoTKUgWy5OSFRydN6Bq/I4eyXEL4M3pYMN
	 74HPlzlrNLjZFkOvwck3koG+ZeqrlJG6+SxWhL1k=
From: Mukesh Rathor <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Subject: [PATCH v0 6/6] Hyper-V: Enable build of hypervisor crash collection files
Date: Wed,  3 Sep 2025 19:10:17 -0700
Message-Id: <20250904021017.1628993-7-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This final commit enables build of the new files introduced in the
earlier commits and adds call to do the setup during boot.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/Makefile       | 6 ++++++
 arch/x86/hyperv/hv_init.c      | 2 ++
 include/asm-generic/mshyperv.h | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index d55f494f471d..6f5d97cddd80 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -5,4 +5,10 @@ obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
 
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
+
+ ifdef CONFIG_MSHV_ROOT
+  CFLAGS_REMOVE_hv_trampoline.o += -pg
+  CFLAGS_hv_trampoline.o        += -fno-stack-protector
+  obj-$(CONFIG_CRASH_DUMP)      += hv_crash.o hv_trampoline.o
+ endif
 endif
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6919f1af2e51..e3a4650b9ec7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -513,6 +513,8 @@ void __init hyperv_init(void)
 
 		/* mark ram reserved for hypervisor as owned by hypervisor */
 		hv_mark_resources();
+
+		hv_root_crash_init();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 1d2ad1304ad4..57cc3e0cac90 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -369,6 +369,15 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
+#if CONFIG_CRASH_DUMP
+void hv_root_crash_init(void);
+void hv_crash_asm32(void);
+void hv_crash_asm64_lbl(void);
+void hv_crash_asm32_end(void);
+#else   /* CONFIG_CRASH_DUMP */
+static inline void hv_root_crash_init(void) {}
+#endif  /* CONFIG_CRASH_DUMP */
+
 #else /* CONFIG_MSHV_ROOT */
 static inline bool hv_root_partition(void) { return false; }
 static inline bool hv_l1vh_partition(void) { return false; }
-- 
2.36.1.vfs.0.0


