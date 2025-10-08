Return-Path: <linux-arch+bounces-13968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC6DBC6E2E
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8513B3B4B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522542D193B;
	Wed,  8 Oct 2025 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FveomI1Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC732D062F;
	Wed,  8 Oct 2025 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966469; cv=none; b=SClw3rv65rbE3a9xThLgEXJTSiMRfudob7ARh7Im3O5t2B6flaPXQAW4+ZkLNlOAtGM3gN6E1jKjLITjZl9lfXZP3HwIdMdHAmQgoxSDc8HhHkvJM1m4SnhGG4anlyuqPYy4QQaNdrK/xQd7No0BjZ3kUfryrm/3lIZ+331DBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966469; c=relaxed/simple;
	bh=eG7zc//LpFoEO3eRrr92k38X0fvy9hYXLg93S/pYppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJtVveqNIqKeSILrkCu516xjdPiEHVMMp6kBHIQHz6kT+JDkt9ssIVvyyPV2TvYfau+kGsnO0jR8HN8zmbmGOmgzb9U2CFg6fa4u2YgmGKhf1LrN1fRNZZcRCi9h1GqXSq3bmrlfjTLqE/bZgKZrevC9D3wDgt+QKw3ZOgCNtN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FveomI1Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B4B282116267;
	Wed,  8 Oct 2025 16:34:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4B282116267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966465;
	bh=21TxUcvrQ87lu8KrWeAmRDEi5bS6RSoLFSqMIZfttVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FveomI1QC1gJDGGAVhhPITSfvGvtrki+lZariJ7UJWKGEwomrZpob4g5irpKlxxtZ
	 P9+MqYOhBaYcUMzAHY1AA/OLNYAkIQmP5WorE9Ogfg+U+n4nZJKpx06H/PZg2S2Tgi
	 4YfvA94jiHj9FRm1FnsTGCUimSmYAKa/jlC5TMLo=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bp@alien8.de,
	bagasdotme@gmail.com,
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
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v7 05/17] arch/x86: mshyperv: Trap on access for some synthetic MSRs
Date: Wed,  8 Oct 2025 16:34:07 -0700
Message-ID: <20251008233419.20372-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008233419.20372-1-romank@linux.microsoft.com>
References: <20251008233419.20372-1-romank@linux.microsoft.com>
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
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 29 +++++++++++++++++++++++++----
 drivers/hv/hv_common.c         |  5 +++++
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index af5a3bbbca9f..a42e72c415b5 100644
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
@@ -43,6 +44,12 @@ bool hyperv_paravisor_present __ro_after_init;
 EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
 
 #if IS_ENABLED(CONFIG_HYPERV)
+/*
+ * When running with the paravisor, controls proxying the synthetic interrupts
+ * from the host
+ */
+static bool hv_para_sint_proxy;
+
 static inline unsigned int hv_get_nested_msr(unsigned int reg)
 {
 	if (hv_is_sint_msr(reg))
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


