Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD824AE39
	for <lists+linux-arch@lfdr.de>; Thu, 20 Aug 2020 07:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgHTFD0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Aug 2020 01:03:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57906 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgHTFDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Aug 2020 01:03:25 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07K50FEE015293;
        Wed, 19 Aug 2020 22:03:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=uwgbRGsLu7TM3L7kScUPbHo+Zd1DkfFIByzJ2VIUTeQ=;
 b=KlfHUjej9R399YagK5RL/iVywco9xKfBzrbBBgbfinkZQ892HjoADoAEP5zbqNJNJBI+
 N8uxbJYdD/rqh1WecyUS6GlUdj1NEyqB3R9bTGknMXu7xiyWqXQTs2pFF/VtthaEBHYK
 FYLLRbphmevd05Dd7+D82xwQJYcnFK32PVfdWMS4iXl4ShF6HxycE1XG8EKZtQIxdDix
 0mly4nl/8RndcqP0NcId//tP08A4h/6goXzZpB/B+SNucMKuRQnbao/u+nwO4F7+h/wy
 PrDFd5w5KIgHlCuhsOcnwvgd35TmBr/y+B6rE1FCxFNhC3We4OENHG0jP3xem9Y8XfLH NA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3304hhudxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 22:03:19 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Aug
 2020 22:03:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 22:03:17 -0700
Received: from hyd1584.caveonetworks.com (unknown [10.29.37.82])
        by maili.marvell.com (Postfix) with ESMTP id 187863F7044;
        Wed, 19 Aug 2020 22:03:14 -0700 (PDT)
From:   George Cherian <george.cherian@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <arnd@arndb.de>,
        George Cherian <george.cherian@marvell.com>
Subject: [PATCHv2] PCI: Add pci_iounmap
Date:   Thu, 20 Aug 2020 10:33:06 +0530
Message-ID: <20200820050306.2015009-1-george.cherian@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_13:2020-08-19,2020-08-19 signatures=0
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

Simple bind/unbind test of any pci driver using pcim_iomap/pci_iomap,
would lead to the following error message after long hour tests

"allocation failed: out of vmalloc space - use vmalloc=<size> to
increase size."

Signed-off-by: George Cherian <george.cherian@marvell.com>
---
* Changes from v1
	- Fix the 0-day compilation error.
	- Mark the lib/iomap pci_iounmap call as weak incase 
	  if any architecture have there own implementation.

 include/asm-generic/io.h |  4 ++++
 lib/pci_iomap.c          | 10 ++++++++++
 2 files changed, 14 insertions(+)

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
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index 2d3eb1cb73b8..ecd1eb3f6c25 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -134,4 +134,14 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 	return pci_iomap_wc_range(dev, bar, 0, maxlen);
 }
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
+
+#ifndef CONFIG_GENERIC_IOMAP
+#define pci_iounmap pci_iounmap
+void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr);
+void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
+#endif
 #endif /* CONFIG_PCI */
-- 
2.25.1

