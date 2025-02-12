Return-Path: <linux-arch+bounces-10125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E58A31B63
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 02:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EC91672B6
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 01:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3E1D5AA7;
	Wed, 12 Feb 2025 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ShwoORgj"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311679FD;
	Wed, 12 Feb 2025 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324608; cv=none; b=hv/EPwU1DWpTlxkp2XF0GdYuQfAc/+dKB9Prtkt2WwVdl//wIAiMXVv4jRz5Vm3270sU+DfKwDfQEoFDwXtSB9zq55ePpy7G4EpfMyN/KredOtPgjx+yhNAA+iu/JSw32cyXzMk9bpHZxG4JWLN4WhXBolVLZsYAgC6/6ip+T9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324608; c=relaxed/simple;
	bh=cgPL+Vfw7gGPl+BFJl9l5TLMq6djMzz6QyQGMjjJtI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axKVkD9v8AqlVnhrG8vgzRQeyODke8Fhfu7AO6cOKezHl9ZVDFawWhGDd9ZE7ieqqazwenrx3UdBl9aU/puDaBOhlurB57gKth4fXHp41pYgx0hqzDqPHpSUa8Qse8vzFs1c/GKIxWSYN6LSoODu+1cSBl5OuML2n3eNMpT2Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ShwoORgj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 20D092107ABC;
	Tue, 11 Feb 2025 17:43:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20D092107ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739324606;
	bh=fxnUth80ZpwN+R8QXh2rnXW3rersdPCTTnOAkFWYgDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShwoORgjejjON2N7A2RFHlzYeBAbDLfGWZ4lEe29wGSWjBl/n8jLBpsASsJolKAbc
	 Sfic0A88GQiTr0d2oJKBHmrDh42UeiTOvV3t7FHjrVPoqlWGi79DfAjxa9mR2wlFW+
	 AHR+5D1yr49w35P0Z85bP6dJhHEFrUqJGSpnGwfE=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mingo@redhat.com,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v4 5/6] Drivers: hv: vmbus: Get the IRQ number from DeviceTree
Date: Tue, 11 Feb 2025 17:43:20 -0800
Message-ID: <20250212014321.1108840-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212014321.1108840-1-romank@linux.microsoft.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMBus driver uses ACPI for interrupt assignment on
arm64 hence it won't function in the VTL mode where only
DeviceTree can be used.

Update the VMBus driver to discover interrupt configuration
from DT.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0f6cd44fff29..9d0c2dbd2a69 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2335,6 +2335,36 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 }
 #endif
 
+static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
+{
+	struct irq_data *data;
+	int irq;
+	irq_hw_number_t hwirq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq == 0) {
+		pr_err("VMBus interrupt mapping failure\n");
+		return -EINVAL;
+	}
+	if (irq < 0) {
+		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n", irq);
+		return irq;
+	}
+
+	data = irq_get_irq_data(irq);
+	if (!data) {
+		pr_err("No interrupt data for VMBus virq %d\n", irq);
+		return -ENODEV;
+	}
+	hwirq = irqd_to_hwirq(data);
+
+	vmbus_irq = irq;
+	vmbus_interrupt = hwirq;
+	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);
+
+	return 0;
+}
+
 static int vmbus_device_add(struct platform_device *pdev)
 {
 	struct resource **cur_res = &hyperv_mmio;
@@ -2349,6 +2379,12 @@ static int vmbus_device_add(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+	ret = vmbus_set_irq(pdev);
+	if (ret)
+		return ret;
+#endif
+
 	for_each_of_range(&parser, &range) {
 		struct resource *res;
 
-- 
2.43.0


