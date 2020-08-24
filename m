Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63A724FEBA
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHXNVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 09:21:18 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:29760 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgHXNVC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 09:21:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ODFZd5017021;
        Mon, 24 Aug 2020 06:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=0vJr/7mSUU6cK8vu083hfwJhVAeHoflMOLszU2nLchY=;
 b=LWqXfg3xxrK5D8hArvckfKN5Aj3XKCozOhdSxqSSR1n2h3tgWdylMEetiHpFv8Ec7KT9
 LRcL8n+0UDl3+zwQuSydzps9mr4Uvw3w49w3iPcM7YziuSbobKhVjDDQsJH6xWiQDze+
 R6HSLH0UWbNnDhQ7u95MlUAB9ecF3B/NvtO2PCvwUIlaCkGAK6EUJB+RgFxooH/sF8S6
 LNEK4WQ4+t8x0IXLw/ObuDxAhRYKJhvWuHZrBelzDJyyCbwYIjdK9DPoUEtX8Z4Ode+l
 TRV7tC4E5rQYOgXMFqKpd2oWX+oSULDe314VN6yZ9z09ZAhh3rJ3X2yn8vcdZz2Rh8n1 oQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3332vmpr7p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 06:20:54 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Aug
 2020 06:20:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 06:20:53 -0700
Received: from hyd1584.caveonetworks.com (unknown [10.29.37.82])
        by maili.marvell.com (Postfix) with ESMTP id 9B7C63F7043;
        Mon, 24 Aug 2020 06:20:50 -0700 (PDT)
From:   George Cherian <george.cherian@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <arnd@arndb.de>, <mst@redhat.com>,
        George Cherian <george.cherian@marvell.com>
Subject: [PATCH v3] PCI: Add pci_iounmap
Date:   Mon, 24 Aug 2020 18:50:46 +0530
Message-ID: <20200824132046.3114383-1-george.cherian@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In case if any architecture selects CONFIG_GENERIC_PCI_IOMAP and not
CONFIG_GENERIC_IOMAP, then the pci_iounmap function is reduced to a NULL
function. Due to this the managed release variants or even the explicit
pci_iounmap calls doesn't really remove the mappings.

This issue is seen on an arm64 based system. arm64 by default selects
only CONFIG_GENERIC_PCI_IOMAP and not CONFIG_GENERIC_IOMAP from this
'commit cb61f6769b88 ("ARM64: use GENERIC_PCI_IOMAP")'

Also '66eab4df288a ("lib: add GENERIC_PCI_IOMAP")' moved only  the iomap
functions to lib/pci_iomap.c. The pci_iounmap() was left in lib/iomap.c
as different achitectures has its own pci_iounmap implementation.
For architectures, which doesn't have pci_iounmap implemented, this
would lead to a potential leak. So provide a generic iounmap function in
lib/pci_iomap.c.

Simple bind/unbind test of any pci driver using pcim_iomap/pci_iomap,
would lead to the following error message after long hour tests

"allocation failed: out of vmalloc space - use vmalloc=<size> to
increase size."

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
* Changes from v2
	- Get rid of the #ifdefs around pci_iounmap()
* Changes from v1
	- Fix the 0-day compilation error.
	- Mark the lib/iomap pci_iounmap call as weak incase
	if any architecture have there own implementation.
 include/asm-generic/io.h        | 4 ++++
 include/asm-generic/iomap.h     | 1 -
 include/asm-generic/pci_iomap.h | 1 +
 lib/pci_iomap.c                 | 6 ++++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index dabf8cb7203b..5986b37226b7 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -915,12 +915,16 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 struct pci_dev;
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 
+#ifdef CONFIG_GENERIC_PCI_IOMAP
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *p);
+#else
 #ifndef pci_iounmap
 #define pci_iounmap pci_iounmap
 static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 {
 }
 #endif
+#endif /* CONFIG_GENERIC_PCI_IOMAP */
 #endif /* CONFIG_GENERIC_IOMAP */
 
 /*
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 649224664969..68c75e26edbd 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -104,7 +104,6 @@ extern void ioport_unmap(void __iomem *);
 #ifdef CONFIG_PCI
 /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 #elif defined(CONFIG_GENERIC_IOMAP)
 struct pci_dev;
 static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index d4f16dcc2ed7..3684307a6b44 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -18,6 +18,7 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *p);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index 2d3eb1cb73b8..e97b73995af7 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -134,4 +134,10 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 	return pci_iomap_wc_range(dev, bar, 0, maxlen);
 }
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
+
+void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
 #endif /* CONFIG_PCI */
-- 
2.25.1

