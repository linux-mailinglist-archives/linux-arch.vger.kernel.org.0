Return-Path: <linux-arch+bounces-13306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8980DB39092
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF26364F3C
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C91E5B62;
	Thu, 28 Aug 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UFFO0790"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF01DC9B5;
	Thu, 28 Aug 2025 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343164; cv=none; b=H+/ocYCdicCESJg7NQxbrkCl4gA+sqE6gO9f/5HBSGuEm+poYfLfnVWmZSdwlPJ3gTEvpwLDagrSx1K2g+j3lIcidHIXeZprCGuWjGx1BtoBv5xluSXBM/0kQGu8X/RkQnEMOpJeFi0XXpxxG1+VxyX1CvWP+cAMAfzhMz8g0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343164; c=relaxed/simple;
	bh=eg16xducMnTkMsNcUL0gWv1T6HLAcS/aWyR21X0jh6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPs2zCAHf0vSimwHyn1PsqxSnGxWuhvJdjXH7dA6GZVc4ZO/9+g2G811ppybvFbYT0t/jYqGSlUyWDSqYNU6FNdC96H9D+skxts2ygsJet+NT/u5vw/rjRyDwp8FeinSTkoJnEL6V4SJeXNzcvZ5ugQ18+SUOvlZXlbjHlG5spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UFFO0790; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D3BE2110806;
	Wed, 27 Aug 2025 18:06:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D3BE2110806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343162;
	bh=qqpYxwhFCn+XrPF2PizHqM0q8iXP6VzgDIT3pVCrSP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFFO0790toVEGlO60zVuUSl4RERvZtnOjFEXOHRPL9qcte0IHFIeWOrCIFGD4LRaI
	 1VHXXvp484dEhsU4aUnJYrpzHxb7uP8yPSX56LJcGdaraRVdK3Tu8Xtw/MgZK9/UkD
	 jTYnym9Frr9hzZ3sPK81Z45cFXTU0jv4R8fT/LN0=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com,
	romank@linux.microsoft.com
Subject: [PATCH hyperv-next v5 04/16] arch/x86: mshyperv: Trap on access for some synthetic MSRs
Date: Wed, 27 Aug 2025 18:05:45 -0700
Message-ID: <20250828010557.123869-5-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828010557.123869-1-romank@linux.microsoft.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hv_set_non_nested_msr() has special handling for SINT MSRs
when a paravisor is present. In addition to updating the MSR on the
host, the mirror MSR in the paravisor is updated, including with the
proxy bit. But with Confidential VMBus, the proxy bit must not be
used, so add a special case to skip it.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h |  2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 28 +++++++++++++++++++++++++---
 drivers/hv/hv_common.c          |  5 +++++
 include/asm-generic/mshyperv.h  |  1 +
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index abc4659f5809..4905343c246e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -42,6 +42,8 @@ static inline unsigned char hv_get_nmi_reason(void)
 #if IS_ENABLED(CONFIG_HYPERV)
 extern bool hyperv_paravisor_present;
 
+extern u64 hyperv_sint_proxy_mask;
+
 extern void *hv_hypercall_pg;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index a619b661275b..5e2c6fd637d2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -28,6 +28,7 @@
 #include <asm/apic.h>
 #include <asm/timer.h>
 #include <asm/reboot.h>
+#include <asm/msr.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/msr.h>
@@ -38,6 +39,16 @@
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
+#define HYPERV_SINT_PROXY_ENABLE	BIT(20)
+#define HYPERV_SINT_PROXY_DISABLE	0
+
+/*
+ * When running with the paravisor, proxy the synthetic interrupts from the host
+ * by default
+ */
+u64 hv_para_sint_proxy = HYPERV_SINT_PROXY_ENABLE;
+EXPORT_SYMBOL_GPL(hv_para_sint_proxy);
+
 /* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyperv.h */
 bool hyperv_paravisor_present __ro_after_init;
 EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
@@ -79,13 +90,14 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
 void hv_set_non_nested_msr(unsigned int reg, u64 value)
 {
 	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
+		/* The hypervisor will get the intercept. */
 		hv_ivm_msr_write(reg, value);
 
-		/* Write proxy bit via wrmsl instruction */
+		/* Using wrmsrq so the following goes to the paravisor. */
 		if (hv_is_sint_msr(reg))
-			wrmsrq(reg, value | 1 << 20);
+			native_wrmsrq(reg, value | hv_para_sint_proxy);
 	} else {
-		wrmsrq(reg, value);
+		native_wrmsrq(reg, value);
 	}
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
@@ -109,6 +121,16 @@ bool hv_confidential_vmbus_available(void)
 	return eax & HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE;
 }
 
+/*
+ * Enable or disable proxying synthetic interrupts
+ * to the paravisor.
+ */
+void hv_para_set_sint_proxy(bool enable)
+{
+	hv_para_sint_proxy =
+		enable ? HYPERV_SINT_PROXY_ENABLE : HYPERV_SINT_PROXY_DISABLE;
+}
+
 /*
  * Attempt to get the SynIC register value from the paravisor.
  *
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 8285ba005a71..eabd582240a3 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -722,6 +722,11 @@ bool __weak hv_confidential_vmbus_available(void)
 }
 EXPORT_SYMBOL_GPL(hv_confidential_vmbus_available);
 
+void __weak hv_para_set_sint_proxy(bool enable)
+{
+}
+EXPORT_SYMBOL_GPL(hv_para_set_sint_proxy);
+
 int __weak hv_para_get_synic_register(unsigned int reg, u64 *val)
 {
 	*val = ~0ULL;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 4b0b05faef70..bc4e3862a3f9 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -300,6 +300,7 @@ bool hv_isolation_type_snp(void);
 bool hv_confidential_vmbus_available(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+void hv_para_set_sint_proxy(bool enable);
 int hv_para_get_synic_register(unsigned int reg, u64 *val);
 int hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
-- 
2.43.0


