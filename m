Return-Path: <linux-arch+bounces-10583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B025FA57481
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D98D3B2502
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4BF25BAC2;
	Fri,  7 Mar 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OS0h5GSd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC0259C92;
	Fri,  7 Mar 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384991; cv=none; b=jEsxm8twdW9rUshJRl+I4qpYIZ98vuiumN4cKWIw9Jpys1OyVuuuTvZ6z9TnmWQZifg3RrKvisLsOy6GzvU6dqxmH9GXvT2ChoG/a+SZaBEevE+BBRW5JNo8eynQdulvN6AYLT8v/BXPeyWKXc46impmwb0j6KCg/4T3UUvCIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384991; c=relaxed/simple;
	bh=mXjcVxS6yhJ7Be6C5xFnfTQiQKB5EKMcoKN9jqGsmlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeLtifIi8OzH+pvLJ0ezLkfHU6HL4XsyyBO7/cJUUwBzivNsUxMLzfhgd/Vg1VWy3h56sWLCS86MNvoGeMziPx9Xbo0pb+3J4IdYWmAFwljswT/fqxSiS+a2j0CFqAEm5xb1P1S3NXqp622V6+dDC8/gKAVT8TJh2qHoz4lnxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OS0h5GSd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 869FD2038F48;
	Fri,  7 Mar 2025 14:03:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 869FD2038F48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741384988;
	bh=aR5FsxsIycmRcn42PG+oTQzQG5IybM8JAOJ2uJYYZWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OS0h5GSdSB83+eNsI9lehhfII7iCqqXhVnSvJ/hbLXpRQzaqZfooB0Vzd+4V8oTk6
	 i26BmsHR2wCE6ElhQM5dcmfdZVOjl4nsRhp6ZKiSYY8qb4iAGpBMXT4fZHiUUwFHGM
	 lHsypdTC78wxPh3kC8K/061cp7wmt0we2hrq4iZY=
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
	joey.gouly@arm.com,
	krzk+dt@kernel.org,
	kw@linux.com,
	kys@microsoft.com,
	lenb@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@redhat.com,
	oliver.upton@linux.dev,
	rafael@kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	sudeep.holla@arm.com,
	suzuki.poulose@arm.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	will@kernel.org,
	yuzenghui@huawei.com,
	devicetree@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v5 08/11] Drivers: hv: vmbus: Get the IRQ number from DeviceTree
Date: Fri,  7 Mar 2025 14:03:00 -0800
Message-ID: <20250307220304.247725-9-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307220304.247725-1-romank@linux.microsoft.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
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
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 75eb1390b45c..c8474b48dcd2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2345,6 +2345,36 @@ static int vmbus_acpi_add(struct platform_device *pdev)
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
@@ -2359,6 +2389,12 @@ static int vmbus_device_add(struct platform_device *pdev)
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


