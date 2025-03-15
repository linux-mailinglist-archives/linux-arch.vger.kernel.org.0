Return-Path: <linux-arch+bounces-10879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA99A622FC
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 01:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A6219C4B6C
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 00:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE1166F29;
	Sat, 15 Mar 2025 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D3YWiohi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A307E136341;
	Sat, 15 Mar 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997979; cv=none; b=IFCIHblR2T7o3nzxJ55Hvt9vvA0xji8xnmI+uehdNMXT0UdpBx860DSxGGwP1J2LzgVYYSE63fLBTSeTGULk3qxX0rCmsppY9dd802HCiicKvoKwRuvcXqPEe8suPekK4XOXBfhiDwtyKwvnTAbTwacujV+5Y1h/vywqB5S6+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997979; c=relaxed/simple;
	bh=uGmSpAEGDZeyXxYeVIIj2GHYy1p3noKlsHm92PaIOyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo2ZbPJvO0sLtZ3uSpCgtGrluj6naI1WaWrRJdzvfVWaXoCwjbZDgvJ2+mKxp1ekKXnoGpNQHjjN1Epx0MwtvhTUw9vQDo2Ava8m6Tqk4BSYJJlpm5RCNlx01QeIACHFLXCDUfWc5ky+VGliXznrnLrAPeX/iIhP77HMpnbL5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D3YWiohi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D77D203345A;
	Fri, 14 Mar 2025 17:19:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D77D203345A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741997977;
	bh=qoiV8JEcZx816GDjfYuKFeROgwdDGoW/daTWcBtz3rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3YWiohiBFjX3mZopbBO+f7LIiod0cqcd08GA0nHnb92b2qf1cVESeIgVzRnJtICE
	 TWJRaKv+tXXKU2ELcaDoYzJPOLN4ldq74OV/UhrH7XHink0C1I04iurLsaZtuaS48p
	 dcto7CfDsuIy5AW4P/A10jkAPEzHzzdbum3hIyXk=
From: Roman Kisel <romank@linux.microsoft.com>
To: arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	dan.carpenter@linaro.org,
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
Subject: [PATCH hyperv-next v6 11/11] PCI: hv: Get vPCI MSI IRQ domain from DeviceTree
Date: Fri, 14 Mar 2025 17:19:31 -0700
Message-ID: <20250315001931.631210-12-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315001931.631210-1-romank@linux.microsoft.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
arm64. It won't be able to do that in the VTL mode where only DeviceTree
can be used.

Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
case, too.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 73 ++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6084b38bdda1..cbff19e8a07c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -50,6 +50,7 @@
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
 #include <linux/sizes.h>
+#include <linux/of_irq.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -817,9 +818,17 @@ static int hv_pci_vec_irq_gic_domain_alloc(struct irq_domain *domain,
 	int ret;
 
 	fwspec.fwnode = domain->parent->fwnode;
-	fwspec.param_count = 2;
-	fwspec.param[0] = hwirq;
-	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+	if (is_of_node(fwspec.fwnode)) {
+		/* SPI lines for OF translations start at offset 32 */
+		fwspec.param_count = 3;
+		fwspec.param[0] = 0;
+		fwspec.param[1] = hwirq - 32;
+		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+	} else {
+		fwspec.param_count = 2;
+		fwspec.param[0] = hwirq;
+		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+	}
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 	if (ret)
@@ -887,10 +896,47 @@ static const struct irq_domain_ops hv_pci_domain_ops = {
 	.activate = hv_pci_vec_irq_domain_activate,
 };
 
+#ifdef CONFIG_OF
+
+static struct irq_domain *hv_pci_of_irq_domain_parent(void)
+{
+	struct device_node *parent;
+	struct irq_domain *domain;
+
+	parent = of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
+	if (!parent)
+		return NULL;
+	domain = irq_find_host(parent);
+	of_node_put(parent);
+
+	return domain;
+}
+
+#endif
+
+#ifdef CONFIG_ACPI
+
+static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
+{
+	struct irq_domain *domain;
+	acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
+
+	if (acpi_irq_model != ACPI_IRQ_MODEL_GIC)
+		return NULL;
+	gsi_domain_disp_fn = acpi_get_gsi_dispatcher();
+	if (!gsi_domain_disp_fn)
+		return NULL;
+	return irq_find_matching_fwnode(gsi_domain_disp_fn(0),
+				     DOMAIN_BUS_ANY);
+}
+
+#endif
+
 static int hv_pci_irqchip_init(void)
 {
 	static struct hv_pci_chip_data *chip_data;
 	struct fwnode_handle *fn = NULL;
+	struct irq_domain *irq_domain_parent = NULL;
 	int ret = -ENOMEM;
 
 	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
@@ -907,9 +953,24 @@ static int hv_pci_irqchip_init(void)
 	 * way to ensure that all the corresponding devices are also gone and
 	 * no interrupts will be generated.
 	 */
-	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
-							  fn, &hv_pci_domain_ops,
-							  chip_data);
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		irq_domain_parent = hv_pci_acpi_irq_domain_parent();
+#endif
+#if defined(CONFIG_OF)
+	if (!irq_domain_parent)
+		irq_domain_parent = hv_pci_of_irq_domain_parent();
+#endif
+	if (!irq_domain_parent) {
+		WARN_ONCE(1, "Invalid firmware configuration for VMBus interrupts\n");
+		ret = -EINVAL;
+		goto free_chip;
+	}
+
+	hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
+		irq_domain_parent, 0, HV_PCI_MSI_SPI_NR,
+		fn, &hv_pci_domain_ops,
+		chip_data);
 
 	if (!hv_msi_gic_irq_domain) {
 		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
-- 
2.43.0


