Return-Path: <linux-arch+bounces-1268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBAE823E38
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCAE286F97
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933720B0C;
	Thu,  4 Jan 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3tSR3WT"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED0E20332
	for <linux-arch@vger.kernel.org>; Thu,  4 Jan 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704359247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EfRzkqO1aZ81ioSW+ft5HOgZe0RLE7oV5/ARH+xGkg=;
	b=d3tSR3WTltreHNUQspJBNO3tZYMxokUekhzq6Bmj6+taRauC7c+tVM7NtDWxVbAaX+BUZH
	AhlZ2J3ulIHQpvOTcHizXbqNZ7s7iiOV1EGqNjrvz36HytWJYFHotg/rSunGA0CiuCRfzX
	A5S3rXMeKQpuvFON7V0xv80cEMvJsWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-nM4-jNP6P46vf6TJkSaQYA-1; Thu, 04 Jan 2024 04:07:26 -0500
X-MC-Unique: nM4-jNP6P46vf6TJkSaQYA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d5428caaeso466915e9.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Jan 2024 01:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359245; x=1704964045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EfRzkqO1aZ81ioSW+ft5HOgZe0RLE7oV5/ARH+xGkg=;
        b=XB6Ht9qEo1kMX5w2BPbBPlCraa5fBf3h+rm73H14jrulh4uLgEEkKX3RAb2LvPdQF3
         DXdiWpJ0UdCxeqrN30OophvghGTPQWYVjC4bOF2gW0P8pPGn22jQydCwFKgXNR0cPJVl
         4hUZEXUsa9CEwgfpdMKutK0U2G7lAkb0BZ76eKZvl3LR0ZSd6DwuzfNewlqAsfd702V/
         TDyjVUELzOfUzpfk6HbyDFxo34HvrRY90VhaszWbUBbBKymmPik8L4f7BW6sR5aMAhfi
         1ICrcaGlQrAoBQVz74My9aL485euMvz5nq5c2Fi16TqzMh3HGNcExhGWkxVGN1SAwbeF
         YAnA==
X-Gm-Message-State: AOJu0YzQl3YAaoMqVVmROpF6J+t7K5mwP8n10XRpPhNEUld5nqgo7eE5
	grIMe5QlUj8wDv4tzCpsorv7tCGdeMiJRXCXMUKKeuXMlNBEOjXTC8D/DNrphtyitqSjh07mTND
	wMJWADqVUX1XgVtwkEaIOw3gk7l6A8g==
X-Received: by 2002:a05:600c:1d09:b0:40d:3dfb:1cbe with SMTP id l9-20020a05600c1d0900b0040d3dfb1cbemr370629wms.2.1704359245500;
        Thu, 04 Jan 2024 01:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA6xgSVLIBTQS9gC2T6B/Q+3dkhcKEPdbBFf0OcXlDivGfbmznR3fq6iJUNRb0vUYXVAvXHg==
X-Received: by 2002:a05:600c:1d09:b0:40d:3dfb:1cbe with SMTP id l9-20020a05600c1d0900b0040d3dfb1cbemr370593wms.2.1704359245162;
        Thu, 04 Jan 2024 01:07:25 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d430f000000b0033740e109adsm8720864wrq.75.2024.01.04.01.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:07:24 -0800 (PST)
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
Subject: [PATCH v5 3/5] lib: move pci-specific devres code to drivers/pci/
Date: Thu,  4 Jan 2024 10:07:07 +0100
Message-ID: <20240104090708.10571-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104090708.10571-2-pstanner@redhat.com>
References: <20240104090708.10571-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcim_*() functions in lib/devres.c are guarded by an #ifdef
CONFIG_PCI and, thus, don't belong to this file. They are only ever used
for pci and are not generic infrastructure.

Move all pcim_*() functions in lib/devres.c to drivers/pci/devres.c.
Adjust the Makefile.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/Makefile |   2 +-
 drivers/pci/devres.c | 207 ++++++++++++++++++++++++++++++++++++++++++
 lib/devres.c         | 208 +------------------------------------------
 3 files changed, 209 insertions(+), 208 deletions(-)
 create mode 100644 drivers/pci/devres.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 64dcedccfc87..ed65299b42b5 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
 				   pci-sysfs.o rom.o setup-res.o irq.o vpd.o \
-				   setup-bus.o vc.o mmap.o setup-irq.o
+				   setup-bus.o vc.o mmap.o setup-irq.o devres.o
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
new file mode 100644
index 000000000000..a3fd0d65cef1
--- /dev/null
+++ b/drivers/pci/devres.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pci.h>
+#include "pci.h"
+
+/*
+ * PCI iomap devres
+ */
+#define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
+
+struct pcim_iomap_devres {
+	void __iomem *table[PCIM_IOMAP_MAX];
+};
+
+static void pcim_iomap_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+	struct pcim_iomap_devres *this = res;
+	int i;
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (this->table[i])
+			pci_iounmap(dev, this->table[i]);
+}
+
+/**
+ * pcim_iomap_table - access iomap allocation table
+ * @pdev: PCI device to access iomap table for
+ *
+ * Access iomap allocation table for @dev.  If iomap table doesn't
+ * exist and @pdev is managed, it will be allocated.  All iomaps
+ * recorded in the iomap table are automatically unmapped on driver
+ * detach.
+ *
+ * This function might sleep when the table is first allocated but can
+ * be safely called without context and guaranteed to succeed once
+ * allocated.
+ */
+void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
+{
+	struct pcim_iomap_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
+	if (dr)
+		return dr->table;
+
+	new_dr = devres_alloc_node(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL,
+				   dev_to_node(&pdev->dev));
+	if (!new_dr)
+		return NULL;
+	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
+	return dr->table;
+}
+EXPORT_SYMBOL(pcim_iomap_table);
+
+/**
+ * pcim_iomap - Managed pcim_iomap()
+ * @pdev: PCI device to iomap for
+ * @bar: BAR to iomap
+ * @maxlen: Maximum length of iomap
+ *
+ * Managed pci_iomap().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
+{
+	void __iomem **tbl;
+
+	BUG_ON(bar >= PCIM_IOMAP_MAX);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+		return NULL;
+
+	tbl[bar] = pci_iomap(pdev, bar, maxlen);
+	return tbl[bar];
+}
+EXPORT_SYMBOL(pcim_iomap);
+
+/**
+ * pcim_iounmap - Managed pci_iounmap()
+ * @pdev: PCI device to iounmap for
+ * @addr: Address to unmap
+ *
+ * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
+ */
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
+{
+	void __iomem **tbl;
+	int i;
+
+	pci_iounmap(pdev, addr);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	BUG_ON(!tbl);
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (tbl[i] == addr) {
+			tbl[i] = NULL;
+			return;
+		}
+	WARN_ON(1);
+}
+EXPORT_SYMBOL(pcim_iounmap);
+
+/**
+ * pcim_iomap_regions - Request and iomap PCI BARs
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to request and iomap
+ * @name: Name used when requesting regions
+ *
+ * Request and iomap regions specified by @mask.
+ */
+int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
+{
+	void __iomem * const *iomap;
+	int i, rc;
+
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap)
+		return -ENOMEM;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		unsigned long len;
+
+		if (!(mask & (1 << i)))
+			continue;
+
+		rc = -EINVAL;
+		len = pci_resource_len(pdev, i);
+		if (!len)
+			goto err_inval;
+
+		rc = pci_request_region(pdev, i, name);
+		if (rc)
+			goto err_inval;
+
+		rc = -ENOMEM;
+		if (!pcim_iomap(pdev, i, 0))
+			goto err_region;
+	}
+
+	return 0;
+
+ err_region:
+	pci_release_region(pdev, i);
+ err_inval:
+	while (--i >= 0) {
+		if (!(mask & (1 << i)))
+			continue;
+		pcim_iounmap(pdev, iomap[i]);
+		pci_release_region(pdev, i);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(pcim_iomap_regions);
+
+/**
+ * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to iomap
+ * @name: Name used when requesting regions
+ *
+ * Request all PCI BARs and iomap regions specified by @mask.
+ */
+int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
+				   const char *name)
+{
+	int request_mask = ((1 << 6) - 1) & ~mask;
+	int rc;
+
+	rc = pci_request_selected_regions(pdev, request_mask, name);
+	if (rc)
+		return rc;
+
+	rc = pcim_iomap_regions(pdev, mask, name);
+	if (rc)
+		pci_release_selected_regions(pdev, request_mask);
+	return rc;
+}
+EXPORT_SYMBOL(pcim_iomap_regions_request_all);
+
+/**
+ * pcim_iounmap_regions - Unmap and release PCI BARs
+ * @pdev: PCI device to map IO resources for
+ * @mask: Mask of BARs to unmap and release
+ *
+ * Unmap and release regions specified by @mask.
+ */
+void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
+{
+	void __iomem * const *iomap;
+	int i;
+
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap)
+		return;
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
+		if (!(mask & (1 << i)))
+			continue;
+
+		pcim_iounmap(pdev, iomap[i]);
+		pci_release_region(pdev, i);
+	}
+}
+EXPORT_SYMBOL(pcim_iounmap_regions);
diff --git a/lib/devres.c b/lib/devres.c
index c44f104b58d5..fe0c63caeb68 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
 #include <linux/err.h>
-#include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
@@ -311,212 +311,6 @@ void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 EXPORT_SYMBOL(devm_ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
-#ifdef CONFIG_PCI
-/*
- * PCI iomap devres
- */
-#define PCIM_IOMAP_MAX	PCI_STD_NUM_BARS
-
-struct pcim_iomap_devres {
-	void __iomem *table[PCIM_IOMAP_MAX];
-};
-
-static void pcim_iomap_release(struct device *gendev, void *res)
-{
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pcim_iomap_devres *this = res;
-	int i;
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (this->table[i])
-			pci_iounmap(dev, this->table[i]);
-}
-
-/**
- * pcim_iomap_table - access iomap allocation table
- * @pdev: PCI device to access iomap table for
- *
- * Access iomap allocation table for @dev.  If iomap table doesn't
- * exist and @pdev is managed, it will be allocated.  All iomaps
- * recorded in the iomap table are automatically unmapped on driver
- * detach.
- *
- * This function might sleep when the table is first allocated but can
- * be safely called without context and guaranteed to succeed once
- * allocated.
- */
-void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
-{
-	struct pcim_iomap_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
-	if (dr)
-		return dr->table;
-
-	new_dr = devres_alloc_node(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL,
-				   dev_to_node(&pdev->dev));
-	if (!new_dr)
-		return NULL;
-	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
-	return dr->table;
-}
-EXPORT_SYMBOL(pcim_iomap_table);
-
-/**
- * pcim_iomap - Managed pcim_iomap()
- * @pdev: PCI device to iomap for
- * @bar: BAR to iomap
- * @maxlen: Maximum length of iomap
- *
- * Managed pci_iomap().  Map is automatically unmapped on driver
- * detach.
- */
-void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
-{
-	void __iomem **tbl;
-
-	BUG_ON(bar >= PCIM_IOMAP_MAX);
-
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
-		return NULL;
-
-	tbl[bar] = pci_iomap(pdev, bar, maxlen);
-	return tbl[bar];
-}
-EXPORT_SYMBOL(pcim_iomap);
-
-/**
- * pcim_iounmap - Managed pci_iounmap()
- * @pdev: PCI device to iounmap for
- * @addr: Address to unmap
- *
- * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
- */
-void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
-{
-	void __iomem **tbl;
-	int i;
-
-	pci_iounmap(pdev, addr);
-
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	BUG_ON(!tbl);
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (tbl[i] == addr) {
-			tbl[i] = NULL;
-			return;
-		}
-	WARN_ON(1);
-}
-EXPORT_SYMBOL(pcim_iounmap);
-
-/**
- * pcim_iomap_regions - Request and iomap PCI BARs
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to request and iomap
- * @name: Name used when requesting regions
- *
- * Request and iomap regions specified by @mask.
- */
-int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
-{
-	void __iomem * const *iomap;
-	int i, rc;
-
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return -ENOMEM;
-
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		unsigned long len;
-
-		if (!(mask & (1 << i)))
-			continue;
-
-		rc = -EINVAL;
-		len = pci_resource_len(pdev, i);
-		if (!len)
-			goto err_inval;
-
-		rc = pci_request_region(pdev, i, name);
-		if (rc)
-			goto err_inval;
-
-		rc = -ENOMEM;
-		if (!pcim_iomap(pdev, i, 0))
-			goto err_region;
-	}
-
-	return 0;
-
- err_region:
-	pci_release_region(pdev, i);
- err_inval:
-	while (--i >= 0) {
-		if (!(mask & (1 << i)))
-			continue;
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
-	}
-
-	return rc;
-}
-EXPORT_SYMBOL(pcim_iomap_regions);
-
-/**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to iomap
- * @name: Name used when requesting regions
- *
- * Request all PCI BARs and iomap regions specified by @mask.
- */
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name)
-{
-	int request_mask = ((1 << 6) - 1) & ~mask;
-	int rc;
-
-	rc = pci_request_selected_regions(pdev, request_mask, name);
-	if (rc)
-		return rc;
-
-	rc = pcim_iomap_regions(pdev, mask, name);
-	if (rc)
-		pci_release_selected_regions(pdev, request_mask);
-	return rc;
-}
-EXPORT_SYMBOL(pcim_iomap_regions_request_all);
-
-/**
- * pcim_iounmap_regions - Unmap and release PCI BARs
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to unmap and release
- *
- * Unmap and release regions specified by @mask.
- */
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
-{
-	void __iomem * const *iomap;
-	int i;
-
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
-		return;
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++) {
-		if (!(mask & (1 << i)))
-			continue;
-
-		pcim_iounmap(pdev, iomap[i]);
-		pci_release_region(pdev, i);
-	}
-}
-EXPORT_SYMBOL(pcim_iounmap_regions);
-#endif /* CONFIG_PCI */
-
 static void devm_arch_phys_ac_add_release(struct device *dev, void *res)
 {
 	arch_phys_wc_del(*((int *)res));
-- 
2.43.0


