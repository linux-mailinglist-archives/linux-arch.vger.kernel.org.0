Return-Path: <linux-arch+bounces-15879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE38D3BF99
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DB24384FC2
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BD393DFD;
	Tue, 20 Jan 2026 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OyE5IrEX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76760366552;
	Tue, 20 Jan 2026 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891426; cv=none; b=AXRLWIwTEP+yC8T5KkbYQR9/H70ZC7GKUhy+rnF17rv0WrlrzYddUSUgCDaHccD4/6ZzYwcT32H/8IAFVfO4Ss1H+roLw8KPmZXbgmOpc/OzgQAiYQlCK3e5Y9UOt0rf91Vy+y9Q/FcXYdB24VNgI6ZDe55O+ffYWOztLSoi4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891426; c=relaxed/simple;
	bh=GqMdKi5YZBvXDKmd2dv+DNeAkosf/TJZ+8e9nFDVzXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTMLC4/csLH7rfaDrRCIZ1kVSd9YS6Ues22AOE/IyqmX7ptcddjehRBhMskw3+Bwyping2eCXF09HMvoRCK5V3ZL5S0mNZPIbgKZgy6OOzklsUs5wCCwn5hxXe9pQTjgr7gn2tSluN6EcIYxfYi0/mKMqBLQkmMZPMEP2t9Kcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OyE5IrEX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AF6020B716C;
	Mon, 19 Jan 2026 22:43:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AF6020B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891410;
	bh=GY/3BAplObLOWLiMmMhdzuiyonlo2hPySFg8J0DmMRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyE5IrEXEydCDRpaah6ewzB23X17QX/RjBGB29tQkSo3l2hB8CFiO6YmqRj0708qp
	 EfkZmdhRxrU1OIR3rZ4960CcronEfP/kE700rK8djoXhNeQhKHhgnxNT6HJRWUZ94I
	 Oo0gffN1n2BT7OZCtpE2b2IsuJYEKTvJMyFBk6po=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joro@8bytes.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	nunodasneves@linux.microsoft.com,
	mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: [PATCH v0 03/15] x86/hyperv: add insufficient memory support in irqdomain.c
Date: Mon, 19 Jan 2026 22:42:18 -0800
Message-ID: <20260120064230.3602565-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Rathor <mrathor@linux.microsoft.com>

Passthru exposes insufficient memory hypercall failure in the current map
device interrupt hypercall. In case of such a failure, we must deposit
more memory and redo the hypercall. Add support for that. Deposit memory
needs partition id, make that a parameter to the map interrupt function.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c | 38 +++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index f6b61483b3b8..ccbe5848a28f 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -13,8 +13,9 @@
 #include <linux/irqchip/irq-msi-lib.h>
 #include <asm/mshyperv.h>
 
-static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
-		int cpu, int vector, struct hv_interrupt_entry *ret_entry)
+static u64 hv_map_interrupt_hcall(u64 ptid, union hv_device_id hv_devid,
+				  bool level, int cpu, int vector,
+				  struct hv_interrupt_entry *ret_entry)
 {
 	struct hv_input_map_device_interrupt *input;
 	struct hv_output_map_device_interrupt *output;
@@ -30,8 +31,10 @@ static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
 
 	intr_desc = &input->interrupt_descriptor;
 	memset(input, 0, sizeof(*input));
-	input->partition_id = hv_current_partition_id;
+
+	input->partition_id = ptid;
 	input->device_id = hv_devid.as_uint64;
+
 	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
 	intr_desc->vector_count = 1;
 	intr_desc->target.vector = vector;
@@ -64,6 +67,28 @@ static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
 
 	local_irq_restore(flags);
 
+	return status;
+}
+
+static int hv_map_interrupt(u64 ptid, union hv_device_id device_id, bool level,
+			    int cpu, int vector,
+			    struct hv_interrupt_entry *ret_entry)
+{
+	u64 status;
+	int rc, deposit_pgs = 16;		/* don't loop forever */
+
+	while (deposit_pgs--) {
+		status = hv_map_interrupt_hcall(ptid, device_id, level, cpu,
+						vector, ret_entry);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
+			break;
+
+		rc = hv_call_deposit_pages(NUMA_NO_NODE, ptid, 1);
+		if (rc)
+			break;
+	};
+
 	if (!hv_result_success(status))
 		hv_status_err(status, "\n");
 
@@ -199,8 +224,8 @@ int hv_map_msi_interrupt(struct irq_data *data,
 	hv_devid = hv_build_devid_type_pci(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
-	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
-				out_entry ? out_entry : &dummy);
+	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
+				cfg->vector, out_entry ? out_entry : &dummy);
 }
 EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
 
@@ -422,6 +447,7 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int cpu, int vector,
 	hv_devid.device_type = HV_DEVICE_TYPE_IOAPIC;
 	hv_devid.ioapic.ioapic_id = (u8)ioapic_id;
 
-	return hv_map_interrupt(hv_devid, level, cpu, vector, entry);
+	return hv_map_interrupt(hv_current_partition_id, hv_devid, level, cpu,
+				vector, entry);
 }
 EXPORT_SYMBOL_GPL(hv_map_ioapic_interrupt);
-- 
2.51.2.vfs.0.1


