Return-Path: <linux-arch+bounces-13904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E84BB8473
	for <lists+linux-arch@lfdr.de>; Sat, 04 Oct 2025 00:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8854C2732
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6927B352;
	Fri,  3 Oct 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nXtL3cUm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EB52727FA;
	Fri,  3 Oct 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530443; cv=none; b=UzSyQGHuCRtx4MtqDoN1DmiXPNMif3hE4bWX5+Ntxm8MQAceGSHZIXCte0Vzpi/jntC1bemDYYAKtJE5nvzPACrQ1rWOy6NIZOqHMVP0QW79lnN8pWCkAB2wo21LHtgeZqa3FiiZyZgI5DaeEkH8jd2lsMT3ueOOldi7876YFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530443; c=relaxed/simple;
	bh=JKOTrjlVUJKUHFdIEfBYdS4J3LoK5/GyGoQx3ebwVUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLjRsCHJkw84WqOOiGrCJjyHaNqb7H7W2PtXIZ2rAjhyobwcJRljMi8sXhtOt4ro5S10Swg9npmSlwrmTaKznl/17MS9qdz/vauIp4wyzO8/TblpzTraQuompyhfoRmBxCzquvDnkeD2JYiTqICRmmSSgd0HZGwFY2dIcBzl0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nXtL3cUm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71EAF211C270;
	Fri,  3 Oct 2025 15:27:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71EAF211C270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759530436;
	bh=pJK0kJZ3LPfApoiqeuoQOMOzMEFQVROkUSaqumH4kCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXtL3cUmo5KIPYNgJ5yYQSpCkyK0thyUtC1ae8z8dF5t14lPAoI+QRR9PZg4h3B/A
	 LsWmUy+m11fzGTgVnuwdbfuD9LI5gvMHNjH99KIWXO8bDB2B0nkZox6TmlN/XSgXt+
	 c2vTCbn5rHWRwjPCGga8zJ4FoMZoAAvXYj6IDhNQ=
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
Subject: [PATCH hyperv-next v6 05/17] arch/x86: mshyperv: Trap on access for some synthetic MSRs
Date: Fri,  3 Oct 2025 15:26:58 -0700
Message-ID: <20251003222710.6257-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003222710.6257-1-romank@linux.microsoft.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
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
 arch/x86/kernel/cpu/mshyperv.c | 29 +++++++++++++++++++++++++----
 drivers/hv/hv_common.c         |  5 +++++
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index af5a3bbbca9f..b410b930938a 100644
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
@@ -38,6 +39,12 @@
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
+/*
+ * When running with the paravisor, controls proxying the synthetic interrupts
+ * from the host
+ */
+static bool hv_para_sint_proxy;
+
 /* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyperv.h */
 bool hyperv_paravisor_present __ro_after_init;
 EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
@@ -79,17 +86,31 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
 void hv_set_non_nested_msr(unsigned int reg, u64 value)
 {
 	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
+		/* The hypervisor will get the intercept. */
 		hv_ivm_msr_write(reg, value);
 
-		/* Write proxy bit via wrmsl instruction */
-		if (hv_is_sint_msr(reg))
-			wrmsrq(reg, value | 1 << 20);
+		/* Using wrmsrq so the following goes to the paravisor. */
+		if (hv_is_sint_msr(reg)) {
+			union hv_synic_sint sint = { .as_uint64 = value };
+
+			sint.proxy = hv_para_sint_proxy;
+			native_wrmsrq(reg, sint.as_uint64);
+		}
 	} else {
-		wrmsrq(reg, value);
+		native_wrmsrq(reg, value);
 	}
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
 
+/*
+ * Enable or disable proxying synthetic interrupts
+ * to the paravisor.
+ */
+void hv_para_set_sint_proxy(bool enable)
+{
+	hv_para_sint_proxy = enable;
+}
+
 /*
  * Get the SynIC register value from the paravisor.
  */
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 8756ca834546..1a5c7a358971 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+void __weak hv_para_set_sint_proxy(bool enable)
+{
+}
+EXPORT_SYMBOL_GPL(hv_para_set_sint_proxy);
+
 u64 __weak hv_para_get_synic_register(unsigned int reg)
 {
 	return ~0ULL;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c010059f1518..3955ba6d60b8 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -298,6 +298,7 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+void hv_para_set_sint_proxy(bool enable);
 u64 hv_para_get_synic_register(unsigned int reg);
 void hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
-- 
2.43.0


