Return-Path: <linux-arch+bounces-5652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3093DB00
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 01:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC11C21D36
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144A1553B7;
	Fri, 26 Jul 2024 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ifls2ATr"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5311514F6;
	Fri, 26 Jul 2024 22:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722034772; cv=none; b=JThb0che4ULCJ7kU/RG/q6WR7W97biysEQtfx51t4crFVsJ1m17/tUu53xJJX1Qf5kHQnt/DrXn1cZkhGfumhQe3l6t0YAxORmmh9A6XtAwzO3e3Occ8pK/WDGcblnDFN/wOgRriFoOYxF5UApXP/fxONQYoUFl72ErGqYX62PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722034772; c=relaxed/simple;
	bh=LmyxU2JFWdzIhr/7UyPWyDMHFIJ8AwEqBU+ndr0kTXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUx68xAfbmgVOWX2zOP2/857Np7JsfIkrw/xJmXKkc4go7Z2NvM0KOXokEAP6qXFx6tlDHqXXkio6dqg/aptrsNE7JzdTIk8CbDPq52uRn7X4boaisyt3WfOjjMSE9KEZc94GmoEsr2EMUqXUi6UXgtOBpKNJUuTc6nqJ/7CkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ifls2ATr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id CBF7D20B7131;
	Fri, 26 Jul 2024 15:59:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBF7D20B7131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722034770;
	bh=4vaIu2cEtSVp+bjNc+RfZaBe8pNFl4ohmrBuqhrOtgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ifls2ATr8KECM4bvDJ5IAeXj1JMZS5t3yp814sYi/dAkxL35MPfq6JG2HfH7Q/XkJ
	 uX0zS1bBgTDoeA3MrkbFjwyhF5BvqDZY24fonP8+uxqueoEHNx/dd9O85VfP7K9jzA
	 /9lBCoUC18fqOQrPZctyv6Q5OlKj/Uuqfd90xvkE=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	mingo@redhat.com,
	rafael@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
Date: Fri, 26 Jul 2024 15:59:09 -0700
Message-Id: <20240726225910.1912537-7-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726225910.1912537-1-romank@linux.microsoft.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
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
via DeviceTree and indicate DMA cache coherency.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a707ab73f8..7eee7caff5f6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2306,6 +2306,34 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 }
 #endif
 
+static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
+{
+	struct irq_desc *desc;
+	int irq;
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
+	desc = irq_to_desc(irq);
+	if (!desc) {
+		pr_err("No interrupt descriptor for VMBus virq %d\n", irq);
+		return -ENODEV;
+	}
+
+	vmbus_irq = irq;
+	vmbus_interrupt = desc->irq_data.hwirq;
+	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);
+
+	return 0;
+}
+
 static int vmbus_device_add(struct platform_device *pdev)
 {
 	struct resource **cur_res = &hyperv_mmio;
@@ -2320,6 +2348,12 @@ static int vmbus_device_add(struct platform_device *pdev)
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
 
@@ -2338,6 +2372,21 @@ static int vmbus_device_add(struct platform_device *pdev)
 		cur_res = &res->sibling;
 	}
 
+	/*
+	 * Hyper-V always assumes DMA cache coherency, and the DMA subsystem
+	 * might default to 'not coherent' on some architectures.
+	 * Avoid high-cost cache coherency maintenance done by the CPU.
+	 */
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+
+	if (!of_property_read_bool(np, "dma-coherent"))
+		pr_warn("Assuming cache coherent DMA transactions, no 'dma-coherent' node supplied\n");
+	pdev->dev.dma_coherent = true;
+
+#endif
+
 	return ret;
 }
 
-- 
2.34.1


