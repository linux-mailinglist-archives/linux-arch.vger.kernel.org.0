Return-Path: <linux-arch+bounces-13307-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBEFB39093
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 03:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0F37AD76A
	for <lists+linux-arch@lfdr.de>; Thu, 28 Aug 2025 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF831F1932;
	Thu, 28 Aug 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JizDnIUS"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FF1CD215;
	Thu, 28 Aug 2025 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343165; cv=none; b=N+i2HbZgG/zW1jW0giELAiJoaTbZd/32mVs2ydpUooSAExPlDy+TGiOduDtQ7qseIsNsRHMxwK8dNU3tcrFqkhvwQzOgZhwL8XM6xn2iqja1nH4TSn329y9isI8ZGtJqHmsfpg4VqkA4F1yMTgQAYn2qrJ1mWOnEK1yofLmXFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343165; c=relaxed/simple;
	bh=sBTrrnsK3cB24taeTKh+HOc56O+KH/o0Skw0O7PMocA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0iOB5RDkHwyNiz02iqhEQTmlcjiLyFbnhMSg6HUd5AC8RFs+bh5TD4Q42YENhtMoGAW0ocaqhbxyp6VOYB8xbBMchHmNLi1HoXY2cnrhbC3/Jx6/4iAh3OCyuhhIx0bCHki2sKOd0TVH1+J3z0x682MavcepD9RK6t5Vos/0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JizDnIUS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.174.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3CFA52110804;
	Wed, 27 Aug 2025 18:06:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CFA52110804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756343161;
	bh=a2sPt4CE70trAJaFiImGC1GVE1fFDO+tj5bnxPxxuIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JizDnIUSbaxOJPNrUUGdxJfyiWfZxMg/FoE/osIc/oKjEpcGi1ZgdBVMRYra+ScKX
	 BWPkQ/mezxCo1+QLnpEhZfF2Yg+nwT05YfIXndyh1w0Dh2POW/JY2MtyZbIzSIs5zs
	 zyfhUr7vGWk+oPQ9yU1KVQ32umysI3OaX6F9uBN8=
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
Subject: [PATCH hyperv-next v5 03/16] arch: hyperv: Get/set SynIC synth.registers via paravisor
Date: Wed, 27 Aug 2025 18:05:44 -0700
Message-ID: <20250828010557.123869-4-romank@linux.microsoft.com>
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
---
 arch/x86/kernel/cpu/mshyperv.c | 39 ++++++++++++++++++++++++++++++++++
 drivers/hv/hv_common.c         | 13 ++++++++++++
 drivers/hv/hyperv_vmbus.h      | 39 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h | 37 ++------------------------------
 4 files changed, 93 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 95cd78004b11..a619b661275b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -109,6 +109,45 @@ bool hv_confidential_vmbus_available(void)
 	return eax & HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE;
 }
 
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
+	if (!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg))
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
+	if (!ms_hyperv.paravisor_present || !hv_is_synic_msr(reg))
+		return -ENODEV;
+	return native_write_msr_safe(reg, val);
+}
+
 u64 hv_get_msr(unsigned int reg)
 {
 	if (hv_nested)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index fae63c54e531..8285ba005a71 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -722,6 +722,19 @@ bool __weak hv_confidential_vmbus_available(void)
 }
 EXPORT_SYMBOL_GPL(hv_confidential_vmbus_available);
 
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
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 6e4c3acc1169..e8b87fbb88cb 100644
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
@@ -336,6 +337,44 @@ extern const struct vmbus_channel_message_table_entry
 
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
 struct hv_device *vmbus_device_create(const guid_t *type,
 				      const guid_t *instance,
 				      struct vmbus_channel *channel);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index acb017f6c423..4b0b05faef70 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -163,41 +163,6 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
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
@@ -335,6 +300,8 @@ bool hv_isolation_type_snp(void);
 bool hv_confidential_vmbus_available(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+int hv_para_get_synic_register(unsigned int reg, u64 *val);
+int hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.43.0


