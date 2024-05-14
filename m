Return-Path: <linux-arch+bounces-4406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9288C5DC4
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 00:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A22282A07
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 22:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6EC1836DB;
	Tue, 14 May 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rHUMfKWH"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F421182C8F;
	Tue, 14 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726729; cv=none; b=pW3lhX5bJdFZm67wRtG/Wc6NdLzRoWtu1xNxxq700LzGLkpfEFoqwhpzZnHz8VaYDXiLTkp0mCpmsV23TOpOpuvktMTfKJVqwiRQAaCL5Y7zvaopVrXrwlVGdWDTWa9VPKq593x2aOzF3ozzxvAEwZcAsV75zQk3Rpwftr/XHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726729; c=relaxed/simple;
	bh=tvR97zZr6ZpbcFlWZfk14uab1KuXwUvFLoCdkyuH8rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EktDpIJKc/rZWajZPbNFxt3L3kHVzmzoo0OG37uWFLUv9rBNTQBf4ln/XnxGm3JNwdkXikz+zfhSKen98e9bBdpkWAHToNhX4ttTcnf7hBD2+6wBBjk0UAKEa4ev0ZPiaUcYRDfeQXuDwFvclSFC2ZHYJJdrLD8O545xycErveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rHUMfKWH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F1B92095D0F;
	Tue, 14 May 2024 15:45:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F1B92095D0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715726722;
	bh=WAvNrAUPvRAs95ycwbUis/ZRyivQ+QBcctDpVBVOD60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHUMfKWHs+d7tiJ3YyQ5OkPlGTa5/+H9H1p/7QEryXhFD85oSOk2uETsgSV9nmzhw
	 ftp8xQhziw6Ba9H8GNpI2OBe6IsCv6LZkmNxQHu3Zi/ANeiyY5CChzUetgkL8LKDhB
	 9qFCek/0QptJF7l+FYMiMSDHstH0isF+hOWUtb/0=
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
	mhklinux@outlook.com,
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
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from DeviceTree
Date: Tue, 14 May 2024 15:43:52 -0700
Message-ID: <20240514224508.212318-6-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514224508.212318-1-romank@linux.microsoft.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmbus driver uses ACPI for interrupt assignment on
arm64 hence it won't function in the VTL mode where only
DeviceTree can be used.

Update the vmbus driver to discover interrupt configuration
via DeviceTree.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e25223cee3ab..52f01bd1c947 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -36,6 +36,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
+#include <linux/of_irq.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -2316,6 +2317,34 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 }
 #endif
 
+static int __maybe_unused vmbus_of_set_irq(struct device_node *np)
+{
+	struct irq_desc *desc;
+	int irq;
+
+	irq = of_irq_get(np, 0);
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
+		pr_err("VMBus interrupt description can't be found for virq %d\n", irq);
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
@@ -2324,12 +2353,20 @@ static int vmbus_device_add(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
+	pr_debug("VMBus is present in DeviceTree\n");
+
 	hv_dev = &pdev->dev;
 
 	ret = of_range_parser_init(&parser, np);
 	if (ret)
 		return ret;
 
+#ifndef HYPERVISOR_CALLBACK_VECTOR
+	ret = vmbus_of_set_irq(np);
+	if (ret)
+		return ret;
+#endif
+
 	for_each_of_range(&parser, &range) {
 		struct resource *res;
 
-- 
2.45.0


