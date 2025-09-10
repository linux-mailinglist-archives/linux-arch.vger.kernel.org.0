Return-Path: <linux-arch+bounces-13465-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E854B509A5
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 02:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0B175F94
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32B17A2EC;
	Wed, 10 Sep 2025 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HDz4T4KV"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59F1519AC;
	Wed, 10 Sep 2025 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463037; cv=none; b=mREGylZprMJbMFXSLm+S92r/qrUx/pt/SWK1WVvOQOGyG4fxWKiEJE0GpCUbY3aDfUbLitFFwYvUhfhvpkHmOl0WTZNMud2f06maAGnIRNtvVBDmtjN5tAILO2zuMwuh7JzmCybp3KCYhEP7VNIL3wEeXK4nAzeJVWBn8HVJ/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463037; c=relaxed/simple;
	bh=q/ziq/sUT7Of0/H7JokzIW0lhhgE97n2M8dhiEw2UDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0tmgB961YyBdVbcagZqbgyoWf9f3XXuIh0lMxoiwE8uOzwTqgiyXDvXKUjADBXLR7mTyNP8bbhfQdLaso60Ch9QhYVnkYWHBYPELEuOXKR+RVbhs9X7I6UFNYRTHVuRdzmO98dku8fCcz+JsqbAkp6NhR4PZrC/TOlAxHH7+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HDz4T4KV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 341D62018E57;
	Tue,  9 Sep 2025 17:10:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 341D62018E57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757463035;
	bh=nI3PflUd3wNj5pOM2O9InP9JfvCuyftn+sp1Rq9+iXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDz4T4KVd8o7wBOmDi4hrYWzQsTff0ZEvOLs7UBXGXCBgoQgiPrKqHo159t1laeH1
	 JgRxFOVs42SnciTJPQr8AEeT/IDiuqqbDBPVj3fDgNpqFFv0DxO0LuI8I0CX8V8RfP
	 qg/RgJFKkIwJ0JtoSUgoQp3zoCQqxehV6s8gX848=
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
Subject: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump collection files
Date: Tue,  9 Sep 2025 17:10:09 -0700
Message-Id: <20250910001009.2651481-7-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
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
 arch/x86/hyperv/Makefile       | 6 ++++++
 arch/x86/hyperv/hv_init.c      | 1 +
 include/asm-generic/mshyperv.h | 9 +++++++++
 3 files changed, 16 insertions(+)

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
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dbd4c2f3aee3..952c221765f5 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -367,6 +367,15 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
+#if CONFIG_CRASH_DUMP
+void hv_root_crash_init(void);
+void hv_crash_asm32(void);
+void hv_crash_asm64_lbl(void);
+void hv_crash_asm_end(void);
+#else   /* CONFIG_CRASH_DUMP */
+static inline void hv_root_crash_init(void) {}
+#endif  /* CONFIG_CRASH_DUMP */
+
 #else /* CONFIG_MSHV_ROOT */
 static inline bool hv_root_partition(void) { return false; }
 static inline bool hv_l1vh_partition(void) { return false; }
-- 
2.36.1.vfs.0.0


