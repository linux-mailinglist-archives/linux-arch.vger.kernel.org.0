Return-Path: <linux-arch+bounces-12759-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646EDB04A2E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 00:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EA41AA0C74
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 22:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67E72797A3;
	Mon, 14 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MQMLQOas"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073D2417F2;
	Mon, 14 Jul 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531350; cv=none; b=gGmcumruUSVYT0hDca1rrbM6+q/DPW/QhcXF0do7B/CPk1hcM7aRnJoesyIklN5iVRrdXeX2QUVMpMIUX0GK/HF35DKZIJv9Hh9VmfIqQZLaA37GlWs0nKE/CyYNeMc7yJbnGAQ5mLaX+UBmScE4zx4/6Us9Y/qiYYPkE9OzfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531350; c=relaxed/simple;
	bh=iaLzwCzp0IBa5pLtIbdZA0HxXWmyfYsrxH1UgdPLj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBnAleYi+Lrzk1vmXPH2AGU/kwKkMYlBu1Cfw5lEtGqdl6FGxTdmbOKltV/jPGILdEMRCIZUFHw7XBmFGHoweGqxZ2pnxjDyUgME6uhV+/iSXbZAMmpyBS6tIAuXq+cb4glDMaYJj1gpwJ34z2CdK4rAX6nmMam/6vzOsTAyOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MQMLQOas; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD5FA201657D;
	Mon, 14 Jul 2025 15:15:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD5FA201657D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752531347;
	bh=GZ9q8PABxSs18Zr3hF+BwFDwqPPPErZZn+AsTkCq4VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQMLQOasilfc5p+57UYvb/o65rCe8PyftaAglpZ5vEVxW+RpLBF/MrhzxvaN7DiAf
	 9pkEnIAdc1NgSLEKTHzGtN29K4tW8WeaDgd0EAPUfRPZDQFzY7rWjZqfP5jcKwmEUn
	 NkWf1qo9U1UPIajpUyW1IScdabpMJM8YEdsPSFwA=
From: Roman Kisel <romank@linux.microsoft.com>
To: alok.a.tiwari@oracle.com,
	arnd@arndb.de,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mhklinux@outlook.com,
	mingo@redhat.com,
	rdunlap@infradead.org,
	tglx@linutronix.de,
	Tianyu.Lan@microsoft.com,
	wei.liu@kernel.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 03/16] arch: hyperv: Get/set SynIC synth.registers via paravisor
Date: Mon, 14 Jul 2025 15:15:32 -0700
Message-ID: <20250714221545.5615-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714221545.5615-1-romank@linux.microsoft.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
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

But in some Confidential VMBus cases, the guest wants to talk only
with the paravisor. To accomplish this, provide new functions for
accessing SynICs that always do direct accesses (i.e., not via
TDX or SNP GHCB), which will go to the paravisor. The mirroring
of the existing "set" function is also not needed. These functions
should be used only in the specific Confidential VMBus cases that
require them.

Provide functions that allow manipulating the SynIC registers
through the paravisor.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 39 ++++++++++++++++++
 drivers/hv/hv_common.c         | 13 ++++++
 include/asm-generic/mshyperv.h | 75 ++++++++++++++++++----------------
 3 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..07c60231d0d8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -90,6 +90,45 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value)
 }
 EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
 
+/*
+ * Attempt to get the SynIC register value from the paravisor.
+ *
+ * Not all paravisors support reading SynIC registers, so this function
+ * may fail. The register for the SynIC of the running CPU is accessed.
+ *
+ * Writes the SynIC register value into the memory pointed by val,
+ * and ~0ULL is on failure.
+ *
+ * Returns -ENODEV if the MSR is not a SynIC register, or another error
+ * code if getting the MSR fails (meaning the paravisor doesn't support
+ * relaying VMBus communucations).
+ */
+int hv_para_get_synic_register(unsigned int reg, u64 *val)
+{
+	if (!hv_is_synic_msr(reg))
+		return -ENODEV;
+	return native_read_msr_safe(reg, val);
+}
+
+/*
+ * Attempt to set the SynIC register value with the paravisor.
+ *
+ * Not all paravisors support setting SynIC registers, so this function
+ * may fail. The register for the SynIC of the running CPU is accessed.
+ *
+ * Sets the register to the value supplied.
+ *
+ * Returns: -ENODEV if the MSR is not a SynIC register, or another error
+ * code if writing to the MSR fails (meaning the paravisor doesn't support
+ * relaying VMBus communucations).
+ */
+int hv_para_set_synic_register(unsigned int reg, u64 val)
+{
+	if (!hv_is_synic_msr(reg))
+		return -ENODEV;
+	return native_write_msr_safe(reg, val);
+}
+
 u64 hv_get_msr(unsigned int reg)
 {
 	if (hv_nested)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10faff..a179ea482cb1 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -716,6 +716,19 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 
+int __weak hv_para_get_synic_register(unsigned int reg, u64 *val)
+{
+	*val = ~0ULL;
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(hv_para_get_synic_register);
+
+int __weak hv_para_set_synic_register(unsigned int reg, u64 val)
+{
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(hv_para_set_synic_register);
+
 void hv_identify_partition_type(void)
 {
 	/* Assume guest role */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9722934a8332..9447558f425b 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -162,41 +162,6 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
 	return guest_id;
 }
 
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
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
 
 void hv_setup_vmbus_handler(void (*handler)(void));
@@ -333,6 +298,8 @@ bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+int hv_para_get_synic_register(unsigned int reg, u64 *val);
+int hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
@@ -375,6 +342,44 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
 #endif /* CONFIG_MSHV_ROOT */
 bool vmbus_is_confidential(void);
 
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
 #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
 u8 __init get_vtl(void);
 #else
-- 
2.43.0


