Return-Path: <linux-arch+bounces-1338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5510B82A9DC
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA0928754A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094F14F79;
	Thu, 11 Jan 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI73P0Vl"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033914A8B
	for <linux-arch@vger.kernel.org>; Thu, 11 Jan 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704963379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsD8TrNEh5EPEwGi8hN82wHacd6cUmsWwLo/YZNp5vo=;
	b=hI73P0VlplmD4GBln7Hu6Y74G5ZSwYnZIsG6+bwxcqbprNjffOPdKPlgbSCXJmex3eYQ9v
	w7Jlw0xRBO05y6JRJFx5/4Mxaczs1DbD7gpBtL6s7g0+rfBvHkhddqs1CNijgvPnUxfhqn
	+yXw+o7Xe/7PXpN5Y/8eRUQktEVdv/c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ATz6UaPIMKSNOeRPj04ZKw-1; Thu, 11 Jan 2024 03:56:18 -0500
X-MC-Unique: ATz6UaPIMKSNOeRPj04ZKw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-680dea11820so12279166d6.1
        for <linux-arch@vger.kernel.org>; Thu, 11 Jan 2024 00:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963377; x=1705568177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsD8TrNEh5EPEwGi8hN82wHacd6cUmsWwLo/YZNp5vo=;
        b=kj3wH4wNwqp16bT55SavU1oNajIJLPAYpmB42LcfwsUglD5JC5+EakTUZElTQakfzk
         QdYf9Qd9baTDK0CICZA+Rbb9APFerjaQuomqOHp6vYTefsnzhfG84lIEumXNgGu4cvFZ
         z2cw0vocNTis++7yI0neFBp4ZPE8frlISLh4WCD7EaVkru0NX45g/x6t/oRCUDFTsa3U
         BCyB9DMN+uO/WVhqzNJSpDPiuR7s1A32Bc/LhcvmXAsea4g2sSOq5Sv3EGH4Bp68VWOb
         Mt7tcjCto+hkJ2DZ90DaUccEVlYg3L7o2lLYUT/8WNcsP2ce0bYv0aMZq4KqCz6V4mmw
         G9WA==
X-Gm-Message-State: AOJu0YzN+5CiSO/RjbVjLPkf1Fmag+TetudimmMbmpoukxQLGVlFmbPs
	GkVEocyih8EKmGmISn4rhhfKbHPwxR/rfpontfni0JXOiRHy2m3/5F2gLdzaXO6ADZmSx/GCpTS
	YqB60o7wBVCqs9cak5M4dZIDWzMxEKQ==
X-Received: by 2002:a05:6214:1c06:b0:681:3016:2ca6 with SMTP id u6-20020a0562141c0600b0068130162ca6mr1440227qvc.6.1704963377241;
        Thu, 11 Jan 2024 00:56:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUNnM/nMTdvuVeP4AOd20EmbNeeqRne2jDeAmnvDzmuIQ0a1h+BKICqxVr5B4wLqBKklwC2A==
X-Received: by 2002:a05:6214:1c06:b0:681:3016:2ca6 with SMTP id u6-20020a0562141c0600b0068130162ca6mr1440196qvc.6.1704963376871;
        Thu, 11 Jan 2024 00:56:16 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id e16-20020a0cd650000000b0067f7d131256sm168341qvj.17.2024.01.11.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:56:16 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 RESEND 4/5] pci: move devres code from pci.c to devres.c
Date: Thu, 11 Jan 2024 09:55:39 +0100
Message-ID: <20240111085540.7740-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111085540.7740-1-pstanner@redhat.com>
References: <20240111085540.7740-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file pci.c is very large and contains a number of devres-functions.
These functions should now reside in devres.c

There are a few callers left in pci.c that do devres operations. These
should be ported in the future. Corresponding TODOs are added by this
commit.

The reason they are not moved right now in this commit is that pci's
devres currently implements a sort of "hybrid-mode":
pci_request_region(), for instance, does not have a corresponding pcim_
equivalent, yet. Instead, the function can be made managed by previously
calling pcim_enable_device() (instead of pci_enable_device()). This
makes it unreasonable to move pci_request_region() to devres.c
Moving the functions would require changes to pci's API and is,
therefore, left for future work.

In summary, this commit serves as a preparation step for a following
patch-series that will cleanly separate the PCI's managed and unmanaged
API.

Move as much devres-specific code from pci.c to devres.c as possible.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 243 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c    | 249 -------------------------------------------
 drivers/pci/pci.h    |  24 +++++
 3 files changed, 267 insertions(+), 249 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index a3fd0d65cef1..4bd1e125bca1 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
 #include <linux/pci.h>
 #include "pci.h"
 
@@ -11,6 +12,248 @@ struct pcim_iomap_devres {
 	void __iomem *table[PCIM_IOMAP_MAX];
 };
 
+
+static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
+{
+	struct resource **res = ptr;
+
+	pci_unmap_iospace(*res);
+}
+
+/**
+ * devm_pci_remap_iospace - Managed pci_remap_iospace()
+ * @dev: Generic device to remap IO address for
+ * @res: Resource describing the I/O space
+ * @phys_addr: physical address of range to be mapped
+ *
+ * Managed pci_remap_iospace().  Map is automatically unmapped on driver
+ * detach.
+ */
+int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
+			   phys_addr_t phys_addr)
+{
+	const struct resource **ptr;
+	int error;
+
+	ptr = devres_alloc(devm_pci_unmap_iospace, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	error = pci_remap_iospace(res, phys_addr);
+	if (error) {
+		devres_free(ptr);
+	} else	{
+		*ptr = res;
+		devres_add(dev, ptr);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(devm_pci_remap_iospace);
+
+/**
+ * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed pci_remap_cfgspace().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_pci_remap_cfgspace(struct device *dev,
+				      resource_size_t offset,
+				      resource_size_t size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = pci_remap_cfgspace(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfgspace);
+
+/**
+ * devm_pci_remap_cfg_resource - check, request region and ioremap cfg resource
+ * @dev: generic device to handle the resource for
+ * @res: configuration space resource to be handled
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps with pci_remap_cfgspace() API that ensures the
+ * proper PCI configuration space memory attributes are guaranteed.
+ *
+ * All operations are managed and will be undone on driver detach.
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure. Usage example::
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
+					  struct resource *res)
+{
+	resource_size_t size;
+	const char *name;
+	void __iomem *dest_ptr;
+
+	BUG_ON(!dev);
+
+	if (!res || resource_type(res) != IORESOURCE_MEM) {
+		dev_err(dev, "invalid resource\n");
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	size = resource_size(res);
+
+	if (res->name)
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s %s", dev_name(dev),
+				      res->name);
+	else
+		name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
+	if (!name)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	if (!devm_request_mem_region(dev, res->start, size, name)) {
+		dev_err(dev, "can't request region for resource %pR\n", res);
+		return IOMEM_ERR_PTR(-EBUSY);
+	}
+
+	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
+	if (!dest_ptr) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		devm_release_mem_region(dev, res->start, size);
+		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return dest_ptr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
+
+/**
+ * pcim_set_mwi - a device-managed pci_set_mwi()
+ * @dev: the PCI device for which MWI is enabled
+ *
+ * Managed pci_set_mwi().
+ *
+ * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
+ */
+int pcim_set_mwi(struct pci_dev *dev)
+{
+	struct pci_devres *dr;
+
+	dr = find_pci_dr(dev);
+	if (!dr)
+		return -ENOMEM;
+
+	dr->mwi = 1;
+	return pci_set_mwi(dev);
+}
+EXPORT_SYMBOL(pcim_set_mwi);
+
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+	struct pci_devres *this = res;
+	int i;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+		if (this->region_mask & (1 << i))
+			pci_release_region(dev, i);
+
+	if (this->mwi)
+		pci_clear_mwi(dev);
+
+	if (this->restore_intx)
+		pci_intx(dev, this->orig_intx);
+
+	if (this->enabled && !this->pinned)
+		pci_disable_device(dev);
+}
+
+/*
+ * TODO:
+ * Once the last four callers in pci.c are ported, this function here needs to
+ * be made static again.
+ */
+struct pci_devres *find_pci_dr(struct pci_dev *pdev)
+{
+	if (pci_is_managed(pdev))
+		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	return NULL;
+}
+EXPORT_SYMBOL(find_pci_dr);
+
+static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
+{
+	struct pci_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	if (dr)
+		return dr;
+
+	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
+	if (!new_dr)
+		return NULL;
+	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+}
+
+/**
+ * pcim_enable_device - Managed pci_enable_device()
+ * @pdev: PCI device to be initialized
+ *
+ * Managed pci_enable_device().
+ */
+int pcim_enable_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+	int rc;
+
+	dr = get_pci_dr(pdev);
+	if (unlikely(!dr))
+		return -ENOMEM;
+	if (dr->enabled)
+		return 0;
+
+	rc = pci_enable_device(pdev);
+	if (!rc) {
+		pdev->is_managed = 1;
+		dr->enabled = 1;
+	}
+	return rc;
+}
+EXPORT_SYMBOL(pcim_enable_device);
+
+/**
+ * pcim_pin_device - Pin managed PCI device
+ * @pdev: PCI device to pin
+ *
+ * Pin managed PCI device @pdev.  Pinned device won't be disabled on
+ * driver detach.  @pdev must have been enabled with
+ * pcim_enable_device().
+ */
+void pcim_pin_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+
+	dr = find_pci_dr(pdev);
+	WARN_ON(!dr || !dr->enabled);
+	if (dr)
+		dr->pinned = 1;
+}
+EXPORT_SYMBOL(pcim_pin_device);
+
 static void pcim_iomap_release(struct device *gendev, void *res)
 {
 	struct pci_dev *dev = to_pci_dev(gendev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..742b0a6545b6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2088,107 +2088,6 @@ int pci_enable_device(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_enable_device);
 
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- */
-struct pci_devres {
-	unsigned int enabled:1;
-	unsigned int pinned:1;
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
-	unsigned int mwi:1;
-	u32 region_mask;
-};
-
-static void pcim_release(struct device *gendev, void *res)
-{
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pci_devres *this = res;
-	int i;
-
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
-		if (this->region_mask & (1 << i))
-			pci_release_region(dev, i);
-
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
-
-	if (this->enabled && !this->pinned)
-		pci_disable_device(dev);
-}
-
-static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
-{
-	struct pci_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	if (dr)
-		return dr;
-
-	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
-	if (!new_dr)
-		return NULL;
-	return devres_get(&pdev->dev, new_dr, NULL, NULL);
-}
-
-static struct pci_devres *find_pci_dr(struct pci_dev *pdev)
-{
-	if (pci_is_managed(pdev))
-		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	return NULL;
-}
-
-/**
- * pcim_enable_device - Managed pci_enable_device()
- * @pdev: PCI device to be initialized
- *
- * Managed pci_enable_device().
- */
-int pcim_enable_device(struct pci_dev *pdev)
-{
-	struct pci_devres *dr;
-	int rc;
-
-	dr = get_pci_dr(pdev);
-	if (unlikely(!dr))
-		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
-
-	rc = pci_enable_device(pdev);
-	if (!rc) {
-		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
-	return rc;
-}
-EXPORT_SYMBOL(pcim_enable_device);
-
-/**
- * pcim_pin_device - Pin managed PCI device
- * @pdev: PCI device to pin
- *
- * Pin managed PCI device @pdev.  Pinned device won't be disabled on
- * driver detach.  @pdev must have been enabled with
- * pcim_enable_device().
- */
-void pcim_pin_device(struct pci_dev *pdev)
-{
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
-	if (dr)
-		dr->pinned = 1;
-}
-EXPORT_SYMBOL(pcim_pin_device);
-
 /*
  * pcibios_device_add - provide arch specific hooks when adding device dev
  * @dev: the PCI device being added
@@ -4281,133 +4180,6 @@ void pci_unmap_iospace(struct resource *res)
 }
 EXPORT_SYMBOL(pci_unmap_iospace);
 
-static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
-{
-	struct resource **res = ptr;
-
-	pci_unmap_iospace(*res);
-}
-
-/**
- * devm_pci_remap_iospace - Managed pci_remap_iospace()
- * @dev: Generic device to remap IO address for
- * @res: Resource describing the I/O space
- * @phys_addr: physical address of range to be mapped
- *
- * Managed pci_remap_iospace().  Map is automatically unmapped on driver
- * detach.
- */
-int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
-			   phys_addr_t phys_addr)
-{
-	const struct resource **ptr;
-	int error;
-
-	ptr = devres_alloc(devm_pci_unmap_iospace, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	error = pci_remap_iospace(res, phys_addr);
-	if (error) {
-		devres_free(ptr);
-	} else	{
-		*ptr = res;
-		devres_add(dev, ptr);
-	}
-
-	return error;
-}
-EXPORT_SYMBOL(devm_pci_remap_iospace);
-
-/**
- * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
- * @dev: Generic device to remap IO address for
- * @offset: Resource address to map
- * @size: Size of map
- *
- * Managed pci_remap_cfgspace().  Map is automatically unmapped on driver
- * detach.
- */
-void __iomem *devm_pci_remap_cfgspace(struct device *dev,
-				      resource_size_t offset,
-				      resource_size_t size)
-{
-	void __iomem **ptr, *addr;
-
-	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	addr = pci_remap_cfgspace(offset, size);
-	if (addr) {
-		*ptr = addr;
-		devres_add(dev, ptr);
-	} else
-		devres_free(ptr);
-
-	return addr;
-}
-EXPORT_SYMBOL(devm_pci_remap_cfgspace);
-
-/**
- * devm_pci_remap_cfg_resource - check, request region and ioremap cfg resource
- * @dev: generic device to handle the resource for
- * @res: configuration space resource to be handled
- *
- * Checks that a resource is a valid memory region, requests the memory
- * region and ioremaps with pci_remap_cfgspace() API that ensures the
- * proper PCI configuration space memory attributes are guaranteed.
- *
- * All operations are managed and will be undone on driver detach.
- *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example::
- *
- *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
- *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
- *	if (IS_ERR(base))
- *		return PTR_ERR(base);
- */
-void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
-					  struct resource *res)
-{
-	resource_size_t size;
-	const char *name;
-	void __iomem *dest_ptr;
-
-	BUG_ON(!dev);
-
-	if (!res || resource_type(res) != IORESOURCE_MEM) {
-		dev_err(dev, "invalid resource\n");
-		return IOMEM_ERR_PTR(-EINVAL);
-	}
-
-	size = resource_size(res);
-
-	if (res->name)
-		name = devm_kasprintf(dev, GFP_KERNEL, "%s %s", dev_name(dev),
-				      res->name);
-	else
-		name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
-	if (!name)
-		return IOMEM_ERR_PTR(-ENOMEM);
-
-	if (!devm_request_mem_region(dev, res->start, size, name)) {
-		dev_err(dev, "can't request region for resource %pR\n", res);
-		return IOMEM_ERR_PTR(-EBUSY);
-	}
-
-	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
-	if (!dest_ptr) {
-		dev_err(dev, "ioremap failed for resource %pR\n", res);
-		devm_release_mem_region(dev, res->start, size);
-		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
-	}
-
-	return dest_ptr;
-}
-EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
-
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
@@ -4557,27 +4329,6 @@ int pci_set_mwi(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_set_mwi);
 
-/**
- * pcim_set_mwi - a device-managed pci_set_mwi()
- * @dev: the PCI device for which MWI is enabled
- *
- * Managed pci_set_mwi().
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int pcim_set_mwi(struct pci_dev *dev)
-{
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
-
-	dr->mwi = 1;
-	return pci_set_mwi(dev);
-}
-EXPORT_SYMBOL(pcim_set_mwi);
-
 /**
  * pci_try_set_mwi - enables memory-write-invalidate PCI transaction
  * @dev: the PCI device for which MWI is enabled
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..69052059dbd2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -793,6 +793,30 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
+/*
+ * TODO:
+ * The following two components wouldn't need to be here if they weren't used at
+ * four last places in pci.c
+ * Port or move these functions to devres.c and then remove the
+ * pci_devres-components from this header file here.
+ */
+/*
+ * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
+ * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
+ * there's no need to track it separately.  pci_devres is initialized
+ * when a device is enabled using managed PCI device enable interface.
+ */
+struct pci_devres {
+	unsigned int enabled:1;
+	unsigned int pinned:1;
+	unsigned int orig_intx:1;
+	unsigned int restore_intx:1;
+	unsigned int mwi:1;
+	u32 region_mask;
+};
+
+struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+
 /*
  * Config Address for PCI Configuration Mechanism #1
  *
-- 
2.43.0


