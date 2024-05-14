Return-Path: <linux-arch+bounces-4408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8A88C5DD2
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 00:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E4BB2102D
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0499183C2D;
	Tue, 14 May 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XaX/+GHn"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB61182C8C;
	Tue, 14 May 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726730; cv=none; b=B8M8INrcazBfZFFmt3DwYcmOVX53TnEOLiccvR+5FuNQuF6MlruB0vlUQ1SJPeyfEBELMtddR1XlqZU5A5imzW4YWok3gLYqGSNbWi33pHCFTx8bVetbeFnUMgijnikq4LLjWs8QsZrE9CsPYMcy5CY1q5qG/fPY/Gr8MV8WuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726730; c=relaxed/simple;
	bh=Zv26x/T8ogrdxgGzOuPHS9PDINbVhcAXhtoB3XLW4Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfOn84RrnywBp2UtsxOwS9gGMWQrqrO8nljpXVtW6+JnZIBcAwghhOV4j2xH8WZkkkjwIBOtW5odcoTr6CR+zIDLRomBeQl7/R47hPldG7OWZgTwqxQJCfZYCxuW/QxHyV8W0u3yo6+N23TJPt6JoSA6S9VLyrzL1xqPMOJAu7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XaX/+GHn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 594892095D11;
	Tue, 14 May 2024 15:45:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 594892095D11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715726722;
	bh=nn4KQV68n4WSbSFFxJJQzluv/kgRud1rPVzivgVs9S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaX/+GHnNrg4XA0FawTJAnlgsIOEcHB9P133ahRuzmaWgZZ6922vOaNOwsOEObWM7
	 AKTg8l8OU+3i7fIREg8gSUe0LulylVa3E4yiL/5WxMUHcppdm87ciWmuuZ4a9P2COu
	 hpuzTKW1wNC60oQ1+gokVeFkzm41EemxwR99IiVY=
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
Subject: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from DT
Date: Tue, 14 May 2024 15:43:53 -0700
Message-ID: <20240514224508.212318-7-romank@linux.microsoft.com>
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

The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
on arm64 thereby it won't be able to do that in the VTL mode where
only DeviceTree can be used.

Update the hyperv-pci driver to discover interrupt configuration
via DeviceTree.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
 include/linux/acpi.h                |  9 +++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 1eaffff40b8d..ccc2b54206f4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -906,9 +906,16 @@ static int hv_pci_irqchip_init(void)
 	 * way to ensure that all the corresponding devices are also gone and
 	 * no interrupts will be generated.
 	 */
-	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
-							  fn, &hv_pci_domain_ops,
-							  chip_data);
+	if (acpi_disabled)
+		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
+			irq_find_matching_fwnode(fn, DOMAIN_BUS_ANY),
+			0, HV_PCI_MSI_SPI_NR,
+			fn, &hv_pci_domain_ops,
+			chip_data);
+	else
+		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
+			fn, &hv_pci_domain_ops,
+			chip_data);
 
 	if (!hv_msi_gic_irq_domain) {
 		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..498cbb2c40a1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1077,6 +1077,15 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
 	return false;
 }
 
+static inline struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
+					     unsigned int size,
+					     struct fwnode_handle *fwnode,
+					     const struct irq_domain_ops *ops,
+					     void *host_data)
+{
+	return NULL;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 extern void arch_post_acpi_subsys_init(void);
-- 
2.45.0


