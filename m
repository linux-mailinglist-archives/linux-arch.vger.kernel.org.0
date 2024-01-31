Return-Path: <linux-arch+bounces-1894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F6843A3E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19611F2B94E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A775378B71;
	Wed, 31 Jan 2024 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMbusUZf"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4778679
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691657; cv=none; b=Rl/XmOPa7ST7tC1DIYE77yC3XZi5qbko6rt5WdfcQrGhmvQCqk0ndq+qobY/mkHVVeExgMfemsQX8G0HxfG0KOaLFT4mmM03CSrCUwApD9NgI/9d/vN++7SYl5g1bZHd8Kelx0iiYYGh9dQb6M9td5E9T7vdH8pk+sqbH6h6/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691657; c=relaxed/simple;
	bh=JDQ73jWtCeJTkfIEdhQKb+Lq+FcboMZkVNYoOlUA+lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVEu/xFePA3u3dFfBjKs/UzdHk7r3fS8PLRlC3B/2t34jFd6ZTi57WAQSdvTxzh7K9Wk8sM+b5wt3HaHmPjGnMiphaLLeZDqrX6na88FUkYOf9V0hqKlE41vaQuUJeBfmEO56ZGFMa0vEmlZGmSxxctPjsr9Nf36mOKUXLaw78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMbusUZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706691654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eGIcHUEAf2NAHDRZzwxsmV03Hjf21pqGwYOdZ+86L4=;
	b=aMbusUZfAYzOg6UWMV+9AsVkUXWuTAs2zfykSqYZThIGACCkzggmX/uiCqk/FGK3i7iRvZ
	lCI2Cpx+pr+4C4htVQyZFZlBPdGmx/7g9ecHagni/MI5CnzPpar8AkCPcC36acY5Qbhn6E
	GEA3w2AiRcX3GkNoJ31LfB5y3UoWhpY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-gbnw7-2_OFOmNpmnsaLNOg-1; Wed, 31 Jan 2024 04:00:52 -0500
X-MC-Unique: gbnw7-2_OFOmNpmnsaLNOg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ae2dd7d4aso119479f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 01:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691651; x=1707296451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eGIcHUEAf2NAHDRZzwxsmV03Hjf21pqGwYOdZ+86L4=;
        b=vhgtZ4lBVAaX1hhjI4QIJ4Bt0GvP5cePnmFgbBUBAZN6MGlsRwN8NGIYiorHkFH9uk
         jpFzJ8girvsfO4jqFPXzSpPmKOr4dq4GzWLV/eCS+56qPFZkEyPDSpcB+EMlOW7RsX1i
         GDZZJpy7udJk+MAqqg/sIOOrIT+QwkRUIhuVSZ8dK0bfFmGpA2LFZL9D4Cbg/GW900ki
         JF09SO4oPV7VXYEs9jjUqZ1JEw4qcvmpBhwMNo99DGssDulkxwve5zxslR50XA5Qrva7
         9C7h97oP3EXFWORP51lEj4kmJ1DLyzEoCcLiAuC3KEa1v8jpf5eQCJmuuU5xyXga7kiG
         FMpg==
X-Forwarded-Encrypted: i=0; AJvYcCU2HLI+WEfiuzkBV2Ew5lt8c254LScNfyCR2fRVW/8j4GpKlIxkpQpWkS2XzFJJ/+QvDjZl2kJtshGaCKu0ZpYjGxqUE30tyUo08A==
X-Gm-Message-State: AOJu0YwXIDR7YMqxkLrp0MC4ylNVRDRPLBwLj+Cw87cc2W7f9FI+5wPq
	DqQg9u/gFdrsAhH3T3PHZcE1gBSeKHNteSLCixZ3199Qgmfbmw7weJfrpEsqmYjcomMEfu7di0F
	qlb34OrJ0RbLBPGkGOwGMDLBmA4ZR9Leqi8sPsWuEsBeukjByvkkKCXFgKUk=
X-Received: by 2002:a05:600c:1d8a:b0:40f:b404:23f5 with SMTP id p10-20020a05600c1d8a00b0040fb40423f5mr747059wms.4.1706691650775;
        Wed, 31 Jan 2024 01:00:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl7ns5XdPLQ4SPWTlQksx6ZhH8l0gmodHjbusn1o0Q1RcXEdAYoOiQtnpHS4pVQ3Tzd6yFKg==
X-Received: by 2002:a05:600c:1d8a:b0:40f:b404:23f5 with SMTP id p10-20020a05600c1d8a00b0040fb40423f5mr747035wms.4.1706691650442;
        Wed, 31 Jan 2024 01:00:50 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040ee51f1025sm940261wmq.43.2024.01.31.01.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:00:49 -0800 (PST)
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
Subject: [PATCH v6 4/4] PCI: Move devres code from pci.c to devres.c
Date: Wed, 31 Jan 2024 10:00:23 +0100
Message-ID: <20240131090023.12331-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131090023.12331-1-pstanner@redhat.com>
References: <20240131090023.12331-1-pstanner@redhat.com>
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
index d8f11a078924..19f18c3856e8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2157,107 +2157,6 @@ int pci_enable_device(struct pci_dev *dev)
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
@@ -4352,133 +4251,6 @@ void pci_unmap_iospace(struct resource *res)
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
@@ -4628,27 +4400,6 @@ int pci_set_mwi(struct pci_dev *dev)
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
index 2336a8d1edab..2215858b2584 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -797,6 +797,30 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
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


