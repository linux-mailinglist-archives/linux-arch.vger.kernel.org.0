Return-Path: <linux-arch+bounces-10237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCDA3CDDC
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 00:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37631892F31
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 23:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844E25E476;
	Wed, 19 Feb 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ktnrQxzh"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6D722ACD3;
	Wed, 19 Feb 2025 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009122; cv=none; b=C3TLqr81a49OB+xXnHo1dSHl/yE/vuhTpslg6jrYRQRRPvoIH8YltvtdHD82Jo5F/O6EYz6gzk7bNmzv07jvFVBT35AnwLiPCHLzUFCIdV8lDJnI19mxy+GOVY8MwzaMvJZTmgudyyOD/XKpacXbhN3M2RmjjDwKHFigfM5k9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009122; c=relaxed/simple;
	bh=RO7JdfFXhPm7FJVjjl/SPm5ADn0aCyjyX4nGYswilCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dz+Pe5wZgg4yaaKk0fHWeiMSfegp48lgHpQQik7CspR6KdKw9TT06DsYG5+3okypVW2D8KQ2FAyv/XkaJd4YhvNBKsPPYgUnByZijS+aR4Yr3TpJDnPWqnrV7w4GOv++7yRUrSEivjqKrWljP3fKnJZRdGSB7ygCTcu9jRslcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ktnrQxzh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 01FA32043DEB;
	Wed, 19 Feb 2025 15:51:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01FA32043DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740009120;
	bh=AxsI5hx1U00SsNRDv901DQtcJhDoy9q2VCbcg6I8Ypc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ktnrQxzhg8EhdAYLRHWi59CTjsWdX+RZHt9AeHw4gX2wcmvSMV36JUDiq5apyQzps
	 6sT7qtZaFzbfDnZh04pSaKBIoNSKDClg0OLz32kbUmBdY/90wSeu82XjEpHj7XUYtG
	 SvfhXDK92ktiXTtrhL56mLp6jAldejO118ML+HFU=
Message-ID: <5cd71475-b107-4269-829f-2c492f625aae@linux.microsoft.com>
Date: Wed, 19 Feb 2025 15:51:59 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4 6/6] PCI: hv: Get vPCI MSI IRQ domain from
 DeviceTree
To: Bjorn Helgaas <helgaas@kernel.org>, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, mingo@redhat.com, robh@kernel.org,
 ssengar@linux.microsoft.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250212174203.GA81135@bhelgaas>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250212174203.GA81135@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/12/2025 9:42 AM, Bjorn Helgaas wrote:
> On Tue, Feb 11, 2025 at 05:43:21PM -0800, Roman Kisel wrote:

[...]

>>   	 */
>> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> -							  fn, &hv_pci_domain_ops,
>> -							  chip_data);
>> +#ifdef CONFIG_ACPI
>> +	if (!acpi_disabled)
>> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
>> +#endif
>> +#if defined(CONFIG_OF)
>> +	if (!hv_msi_gic_irq_domain)
>> +		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
>> +			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
>> +#endif
> 
> I don't know if acpi_irq_create_hierarchy() is helping or hurting
> here.  It obscures the fact that the only difference is the first
> argument to irq_domain_create_hierarchy().  If we could open-code or
> have a helper to figure out that irq_domain "parent" argument for the
> ACPI case, then we'd only have one call of
> irq_domain_create_hierarchy() here and it seems like it might be
> simpler.
> 

Hey Bjorn, folks,

I've added few ACPI maintainers and the ACPI list as we're discussing
making a small change to the ACPI subsystem to make one static variable
available to make the code above less messy.

Change [1] makes the GSI dispatcher function available to
the outside world. Would you suggest going in that direction or there
is a better approach to converge the code above that deals with IRQ
domains both in the ACPI and DT cases?

[1]

 From c6fb8bda21d6c00a308b1febc201a3a7e704c5a9 Mon Sep 17 00:00:00 2001
From: Roman Kisel <romank@linux.microsoft.com>
Date: Wed, 19 Feb 2025 15:04:06 -0800
Subject: [PATCH] Refactor the ACPI GIC case

---
  drivers/acpi/irq.c                  | 14 ++++++-
  drivers/pci/controller/pci-hyperv.c | 62 +++++++++++++++++------------
  include/linux/acpi.h                |  5 ++-
  3 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 1687483ff319..6243db610137 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -12,7 +12,7 @@

  enum acpi_irq_model_id acpi_irq_model;

-static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
+static acpi_gsi_domain_disp_fn acpi_get_gsi_domain_id;
  static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);

  /**
@@ -307,12 +307,22 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
   *	for a given GSI
   */
  void __init acpi_set_irq_model(enum acpi_irq_model_id model,
-			       struct fwnode_handle *(*fn)(u32))
+	acpi_gsi_domain_disp_fn fn)
  {
  	acpi_irq_model = model;
  	acpi_get_gsi_domain_id = fn;
  }

+/**
+ * acpi_get_gsi_dispatcher - Returns dispatcher function that
+ *                           computes the domain fwnode for a
+ *                           given GSI.
+ */
+acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void)
+{
+	return acpi_get_gsi_domain_id;
+}
+
  /**
   * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
   * callback to fallback to arch specified implementation.
diff --git a/drivers/pci/controller/pci-hyperv.c 
b/drivers/pci/controller/pci-hyperv.c
index 24725bea9ef1..59e670e1cb6e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -910,16 +910,29 @@ static struct irq_domain 
*hv_pci_of_irq_domain_parent(void)
  		of_node_put(parent);
  	}

-	/*
-	 * `domain == NULL` shouldn't happen.
-	 *
-	 * If somehow the code does end up in that state, treat this as a 
configuration
-	 * issue rather than a hard error, emit a warning, and let the code 
proceed.
-	 * The NULL parent domain is an acceptable option for the 
`irq_domain_create_hierarchy`
-	 * function called later.
-	 */
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
+	domain = irq_find_matching_fwnode(gsi_domain_disp_fn(0),
+				     DOMAIN_BUS_ANY);
+
  	if (!domain)
-		WARN_ONCE(1, "No interrupt-parent found, check the DeviceTree data.\n");
+		return NULL;
+
  	return domain;
  }

@@ -929,6 +942,7 @@ static int hv_pci_irqchip_init(void)
  {
  	static struct hv_pci_chip_data *chip_data;
  	struct fwnode_handle *fn = NULL;
+	struct irq_domain *irq_domain_parent = NULL;
  	int ret = -ENOMEM;

  	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
@@ -944,29 +958,25 @@ static int hv_pci_irqchip_init(void)
  	 * IRQ domain once enabled, should not be removed since there is no
  	 * way to ensure that all the corresponding devices are also gone and
  	 * no interrupts will be generated.
-	 *
-	 * In the ACPI case, the parent IRQ domain is supplied by the ACPI
-	 * subsystem, and it is the default GSI domain pointing to the GIC.
-	 * Neither is available outside of the ACPI subsystem, cannot avoid
-	 * the messy ifdef below.
-	 * There is apparently no such default in the OF subsystem, and
-	 * `hv_pci_of_irq_domain_parent` finds the parent IRQ domain that
-	 * points to the GIC as well.
-	 * None of these two cases reaches for the MSI parent domain.
  	 */
  #ifdef CONFIG_ACPI
  	if (!acpi_disabled)
-		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
-			fn, &hv_pci_domain_ops,
-			chip_data);
+		irq_domain_parent = hv_pci_acpi_irq_domain_parent();
  #endif
  #if defined(CONFIG_OF)
-	if (!hv_msi_gic_irq_domain)
-		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
-			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
-			fn, &hv_pci_domain_ops,
-			chip_data);
+	if (!irq_domain_parent)
+		irq_domain_parent = hv_pci_of_irq_domain_parent();
  #endif
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6adcd1b92b20..cd70a72c7073 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -336,8 +336,11 @@ int acpi_register_gsi (struct device *dev, u32 gsi, 
int triggering, int polarity
  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
  int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);

+typedef struct fwnode_handle *(*acpi_gsi_domain_disp_fn)(u32);
+
  void acpi_set_irq_model(enum acpi_irq_model_id model,
-			struct fwnode_handle *(*)(u32));
+	acpi_gsi_domain_disp_fn fn);
+acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void);
  void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));

  struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
-- 
2.43.0



-- 
Thank you,
Roman


