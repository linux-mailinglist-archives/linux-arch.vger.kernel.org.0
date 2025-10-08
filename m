Return-Path: <linux-arch+bounces-13967-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE088BC6E1F
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778D23AF016
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385D2D0639;
	Wed,  8 Oct 2025 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ORF9qz7C"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD2A2C3260;
	Wed,  8 Oct 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966467; cv=none; b=Y26Eh5LG6MLMETJs2h5C4ml6bj7PBc+SaGsOizpfTFb5FP+o86I8IuQfCLFCXzDkfuIwJC6gDZNbf1qbQuRj7C3DjV8GXoGxR28yfCQnygaM8gRW3MWv2Utkd4qq2AkQ2mTmGiloTP1zbSZw0P3CTt17xHRQSLpihZfn6toB6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966467; c=relaxed/simple;
	bh=cyDr5I7iXMv1WYt5xncj5fSI+68lwvx6K0dyTWcHBg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCh1Z5pV+nrLCDxMPX0dtW67+IXQ5zNTjq+3ffT7Qda86ZHjmynPJFYnm7U1KQV03G/iy3XwYd6hq7zmDKE+/+dsfhrJ7219IPGz+tQHOo+/8kkGBoGInbkERcrDIVMdjUaLNSTZ0V7EuIWWOIiZ7TOcm2P5zpGybUyXD+/XtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ORF9qz7C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E33B52116265;
	Wed,  8 Oct 2025 16:34:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E33B52116265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759966465;
	bh=8W+5HDLzBlLq6Vdch6raMO3k9vQvcmFeqa68xKouQCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORF9qz7CRoSa/rZM0pOhzWXHinff5YMwIXLfWW19152n4nsPqebv9FG/Q3uhyzuOh
	 26Sx/pTsF5zpuEsKhGmtVNELkCbTaLOLDWwyCQLsjXfUDMpPSJAKUGRTnuTXRJzwFH
	 QtSxknDQF6mc8LQdar1QktHwYAQxm3wMARIyg6fo=
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
Subject: [PATCH hyperv-next v7 04/17] arch: hyperv: Get/set SynIC synth.registers via paravisor
Date: Wed,  8 Oct 2025 16:34:06 -0700
Message-ID: <20251008233419.20372-5-romank@linux.microsoft.com>
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

The existing Hyper-V wrappers for getting and setting MSRs are
hv_get/set_msr(). Via hv_get/set_non_nested_msr(), they detect
when running in a CoCo VM with a paravisor, and use the TDX or
SNP guest-host communication protocol to bypass the paravisor
and go directly to the host hypervisor for SynIC MSRs. The "set"
function also implements the required special handling for the
SINT MSRs.

Provide functions that allow manipulating the SynIC registers
through the paravisor. Move vmbus_signal_eom() to a more
appropriate location (which also avoids breaking KVM).

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 20 ++++++++++++++++
 drivers/hv/hv_common.c         | 11 +++++++++
 drivers/hv/hyperv_vmbus.h      | 44 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h | 42 ++------------------------------
 4 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 57163c7a000f..af5a3bbbca9f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -90,6 +90,26 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
 
+/*
+ * Get the SynIC register value from the paravisor.
+ */
+u64 hv_para_get_synic_register(unsigned int reg)
+{
+	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
+		return ~0ULL;
+	return native_read_msr(reg);
+}
+
+/*
+ * Set the SynIC register value with the paravisor.
+ */
+void hv_para_set_synic_register(unsigned int reg, u64 val)
+{
+	if (WARN_ON(!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg)))
+		return;
+	native_write_msr(reg, val);
+}
+
 u64 hv_get_msr(unsigned int reg)
 {
 	if (hv_nested)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e109a620c83f..8756ca834546 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,17 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+u64 __weak hv_para_get_synic_register(unsigned int reg)
+{
+	return ~0ULL;
+}
+EXPORT_SYMBOL_GPL(hv_para_get_synic_register);
+
+void __weak hv_para_set_synic_register(unsigned int reg, u64 val)
+{
+}
+EXPORT_SYMBOL_GPL(hv_para_set_synic_register);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 4a01797d4851..9ac6f5520287 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/bitops.h>
 #include <asm/sync_bitops.h>
+#include <asm/mshyperv.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
@@ -335,6 +336,49 @@ extern const struct vmbus_channel_message_table_entry
 
 bool vmbus_is_confidential(void);
 
+#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
+/* Free the message slot and signal end-of-message if required */
+static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
+{
+	/*
+	 * On crash we're reading some other CPU's message page and we need
+	 * to be careful: this other CPU may already had cleared the header
+	 * and the host may already had delivered some other message there.
+	 * In case we blindly write msg->header.message_type we're going
+	 * to lose it. We can still lose a message of the same type but
+	 * we count on the fact that there can only be one
+	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
+	 * on crash.
+	 */
+	if (cmpxchg(&msg->header.message_type, old_msg_type,
+		    HVMSG_NONE) != old_msg_type)
+		return;
+
+	/*
+	 * The cmxchg() above does an implicit memory barrier to
+	 * ensure the write to MessageType (ie set to
+	 * HVMSG_NONE) happens before we read the
+	 * MessagePending and EOMing. Otherwise, the EOMing
+	 * will not deliver any more messages since there is
+	 * no empty slot
+	 */
+	if (msg->header.message_flags.msg_pending) {
+		/*
+		 * This will cause message queue rescan to
+		 * possibly deliver another msg from the
+		 * hypervisor
+		 */
+		if (vmbus_is_confidential())
+			hv_para_set_synic_register(HV_MSR_EOM, 0);
+		else
+			hv_set_msr(HV_MSR_EOM, 0);
+	}
+}
+
+extern int vmbus_interrupt;
+extern int vmbus_irq;
+#endif /* CONFIG_HYPERV_VMBUS */
+
 struct hv_device *vmbus_device_create(const guid_t *type,
 				      const guid_t *instance,
 				      struct vmbus_channel *channel);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9049a9617324..c010059f1518 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -165,46 +165,6 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
 	return guest_id;
 }
 
-#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
-/* Free the message slot and signal end-of-message if required */
-static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
-{
-	/*
-	 * On crash we're reading some other CPU's message page and we need
-	 * to be careful: this other CPU may already had cleared the header
-	 * and the host may already had delivered some other message there.
-	 * In case we blindly write msg->header.message_type we're going
-	 * to lose it. We can still lose a message of the same type but
-	 * we count on the fact that there can only be one
-	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
-	 * on crash.
-	 */
-	if (cmpxchg(&msg->header.message_type, old_msg_type,
-		    HVMSG_NONE) != old_msg_type)
-		return;
-
-	/*
-	 * The cmxchg() above does an implicit memory barrier to
-	 * ensure the write to MessageType (ie set to
-	 * HVMSG_NONE) happens before we read the
-	 * MessagePending and EOMing. Otherwise, the EOMing
-	 * will not deliver any more messages since there is
-	 * no empty slot
-	 */
-	if (msg->header.message_flags.msg_pending) {
-		/*
-		 * This will cause message queue rescan to
-		 * possibly deliver another msg from the
-		 * hypervisor
-		 */
-		hv_set_msr(HV_MSR_EOM, 0);
-	}
-}
-
-extern int vmbus_interrupt;
-extern int vmbus_irq;
-#endif /* CONFIG_HYPERV_VMBUS */
-
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
 
 void hv_setup_vmbus_handler(void (*handler)(void));
@@ -338,6 +298,8 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+u64 hv_para_get_synic_register(unsigned int reg);
+void hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.43.0


