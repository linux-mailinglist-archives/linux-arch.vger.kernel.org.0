Return-Path: <linux-arch+bounces-593-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B310800AA8
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC4D1C20A40
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50324B3B;
	Fri,  1 Dec 2023 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iU1rdfmm"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026ADD48
	for <linux-arch@vger.kernel.org>; Fri,  1 Dec 2023 04:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701433020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EfRzkqO1aZ81ioSW+ft5HOgZe0RLE7oV5/ARH+xGkg=;
	b=iU1rdfmmPlOl762DRp75hfCvPjr8OkpeFE8WuAf1yBvJaWGlToMv3rgeE33YhgNv3hmiWE
	9mMtvOxfP1PlANjlmk7T8k40U+UVKDCtIMResivGLmeIAdvwy6SXF3lhwSne58mmtsthYU
	5iTrVOTih3R/YgwTb5Vyo1wuZaws10Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ppfaUipXNTyXz0ApX6FwHA-1; Fri, 01 Dec 2023 07:16:57 -0500
X-MC-Unique: ppfaUipXNTyXz0ApX6FwHA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4239f7f5304so5630991cf.0
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2023 04:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701433016; x=1702037816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EfRzkqO1aZ81ioSW+ft5HOgZe0RLE7oV5/ARH+xGkg=;
        b=aoUS2HdB5LjBs7jTq3doe21ku4tTkT8X8bBs2q6RowwiiLFouMdkXzRePTA0Xx4y7L
         iT3T4AzFSEvYkMIYPhKAuJRpJMmgiB76BtQe8UbibUUNusD77TkZBfF6X7NaOpvYs3Ex
         tM//8UQzN/ZesGIHw0vaTOTXEGm7kIwf6jRQMZ6B914p3NtBfJeKMgK1bwTisob9DZ7s
         SvhVLmY6QuXTAriMfCdnBz+Xl105c97vUt1HUSQGc4hMmCPF70lqMmifk0qJqM4tMs3Z
         V1yA3B6eMhOyjsXM+5Dx+CA/MpmxIhyDo4rguhCOfWUUiLzdElItYJWVSpMau3Ha6i/I
         GeUA==
X-Gm-Message-State: AOJu0YyZ9uL/FzYrWFflPSuFBugkUQvcIswh7BS2Y4L+Sy24u03INExp
	CMcWSUbnJoGWPvu1GBAyk0zB0EULPWUavEJT8tGyFzypRQIetZebZmXCaftkJQZY43GZVFsEUL6
	AGpsnirgctQRIodjYqlkShQ==
X-Received: by 2002:ac8:78d:0:b0:415:141e:fa21 with SMTP id l13-20020ac8078d000000b00415141efa21mr4745755qth.6.1701433016427;
        Fri, 01 Dec 2023 04:16:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFmZJypRQ8ZHOHDscqr2RObCwTZVnQwO5c/ogqCaotObZaqVe4SbOzBArDdccHeYNc2uDvhg==
X-Received: by 2002:ac8:78d:0:b0:415:141e:fa21 with SMTP id l13-20020ac8078d000000b00415141efa21mr4745716qth.6.1701433016025;
        Fri, 01 Dec 2023 04:16:56 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32e2:4e00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id b19-20020ac87553000000b00423b8a53641sm1426528qtr.29.2023.12.01.04.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:16:55 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	NeilBrown <neilb@suse.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Jason Baron <jbaron@akamai.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 2/4] lib: move pci-specific devres code to drivers/pci/
Date: Fri,  1 Dec 2023 13:16:20 +0100
Message-ID: <20231201121622.16343-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201121622.16343-1-pstanner@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
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


