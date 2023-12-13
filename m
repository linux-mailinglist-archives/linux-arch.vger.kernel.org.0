Return-Path: <linux-arch+bounces-974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1999810EDE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7462D1F21267
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397122EE2;
	Wed, 13 Dec 2023 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbiUHHy+"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E793136
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702464583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EfRzkqO1aZ81ioSW+ft5HOgZe0RLE7oV5/ARH+xGkg=;
	b=hbiUHHy+hJxhsmY3PEl8POdtgK+ti/Ph4PwhwugnHqn521d6+KA1qiimiqP54KB4tAZgIi
	gmfIKUkeggoAqWEADkVrB/cwfaHDiZCW7u15wqlKTZ1TfthUsjnj+Q3lSRZaTNcTX0FwuY
	eSFuJRH7kreK0otiONzUhOZ/P5vO9Vo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-as1hCzdhOdqO8UWeWyH8gQ-1; Wed, 13 Dec 2023 05:49:41 -0500
X-MC-Unique: as1hCzdhOdqO8UWeWyH8gQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1df644f6a8so108412466b.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 02:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464579; x=1703069379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EfRzkqO1aZ81ioSW+ft5HOgZe0RLE7oV5/ARH+xGkg=;
        b=bDO/vG8c5peeLyRXVfGyRB3us1SJ3gbyfFABqhNZkondk9Z/E9d9NUcC4Yo4C3Q62W
         8Yfg+yCyCpLjaINoAS3IYtsNmVBwW7LK+JZ0jMyYrXo1EK0vp67/jtFosqNNoCaiS/Qd
         3ot/uWqetNdadXA9VBSYZSn/kt70V6grMbsBP46+m6fa841FiVn2qnteZcWIp+b/no7M
         4tgca5SBimChVSQ4IMcCHqttFzqqvfl08yvQyp2t+dcZZ93va506tzkP+2Z9tYcCURjL
         V8mGffAHMSKiL4bypu88NHX+d+ZoJlrtTIlOBktfH+zB+nfr+FFUfSUhK5JS7xJqEbE9
         1NNA==
X-Gm-Message-State: AOJu0YwkwmnvlURCTpOWOC8KtGgdI04LN6SA72OEeyfXCO9up4faDnik
	VA2+6PiDZen0DSRBWIvw46vybR1LUn9yPA1jd2hyoH1TL66pFldDHNfFFEmZK61yfL2cfZpqSft
	eZ5T3dwVQSMXQ1/hJQcVvkA==
X-Received: by 2002:a17:907:d30a:b0:a19:2ca9:8e4d with SMTP id vg10-20020a170907d30a00b00a192ca98e4dmr7900737ejc.2.1702464579532;
        Wed, 13 Dec 2023 02:49:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzcyvE6RsoEjo1awvN2wlyb+ky4w8avG542iLhlOqg3mIBzDiuZGHpP0ZLf1JFTFiSN9Q0tg==
X-Received: by 2002:a17:907:d30a:b0:a19:2ca9:8e4d with SMTP id vg10-20020a170907d30a00b00a192ca98e4dmr7900706ejc.2.1702464579041;
        Wed, 13 Dec 2023 02:49:39 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:914:ed27:4fa9:dbce:10f5:d0b9])
        by smtp.gmail.com with ESMTPSA id vu8-20020a170907a64800b00a1d5c52d628sm7527135ejc.3.2023.12.13.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:49:38 -0800 (PST)
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
Date: Wed, 13 Dec 2023 11:49:20 +0100
Message-ID: <20231213104922.13894-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213104922.13894-1-pstanner@redhat.com>
References: <20231213104922.13894-1-pstanner@redhat.com>
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


