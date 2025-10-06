Return-Path: <linux-arch+bounces-13942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FBBBFB7F
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 00:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D22D4F2AFF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 22:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51CD260565;
	Mon,  6 Oct 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rrIConmy"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4041D25743E;
	Mon,  6 Oct 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790542; cv=none; b=NRoHG8GyAI+fL1Dd+0dig3do+joZgWNP/e5XN/KQV6xjJPpE5O91P3UShDXYwk7m79pgouNgEioXh7VuDskB4dS2KQVjDpO5nCgw/9ihvYFYwfTIk/oKH/j7Eo7MExk0nBBHTHH0/uvmtnsAHvtbYxSdObamYd3CzfUA96v4R1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790542; c=relaxed/simple;
	bh=c0talsjJ+Z2WNoUByEezA9K8avqHThlX+xsZdpzpl04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1tbOhXp4jo8C2zK9ioRFMWEYKqxFTqad6X7D96NjJ9IfvEi61bgdAOKKcOciFryZJs/0/DgYkxx8hu92pIv61o2yUY1i2yCASOMV8oKfl5NZC1JGS/3rPbvL7pY4InR7U6VqiHV72u108I3hnfJnEd7bLDFnuXjUhuLJyJeLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rrIConmy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 50AC5211CDFB;
	Mon,  6 Oct 2025 15:42:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50AC5211CDFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759790540;
	bh=AqiQrPrnDYRH34965IVGlS/fEWTJe0jV5/CD4sbHfgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrIConmy5ZUn7H0CU6g5EaZI5nBoH7ITjXYZAL+6SI8Z7njBBQDpFAh66K6fr1+95
	 UxQoXA4jq7C8Q1qPxqfb1KrKJ/RrrCDlsshUC/1vwcIaLDeSkNCHMvmf9vYKRe1wYa
	 qMQMnusHRDjYGMXV/vh8K8mAubaCfV29sCebrq48=
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
Subject: [PATCH v3 6/6] x86/hyperv: Enable build of hypervisor crashdump collection files
Date: Mon,  6 Oct 2025 15:42:08 -0700
Message-Id: <20251006224208.1060990-7-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable build of the new files introduced in the earlier commits and add
call to do the setup during boot.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/Makefile        |  6 ++++++
 arch/x86/hyperv/hv_init.c       |  1 +
 arch/x86/include/asm/mshyperv.h | 13 +++++++++++++
 3 files changed, 20 insertions(+)

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
index afdbda2dd7b7..577bbd143527 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -510,6 +510,7 @@ void __init hyperv_init(void)
 		memunmap(src);
 
 		hv_remap_tsc_clocksource();
+		hv_root_crash_init();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index abc4659f5809..207d953d7b90 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -292,6 +292,19 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 }
 int hv_apicid_to_vp_index(u32 apic_id);
 
+#if IS_ENABLED(CONFIG_MSHV_ROOT)
+
+#ifdef CONFIG_CRASH_DUMP
+void hv_root_crash_init(void);
+void hv_crash_asm32(void);
+void hv_crash_asm64(void);
+void hv_crash_asm_end(void);
+#else   /* CONFIG_CRASH_DUMP */
+static inline void hv_root_crash_init(void) {}
+#endif  /* CONFIG_CRASH_DUMP */
+
+#endif  /* CONFIG_MSHV_ROOT */
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
-- 
2.36.1.vfs.0.0


