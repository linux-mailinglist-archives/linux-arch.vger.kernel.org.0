Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F251153DB0
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 04:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBFDsH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 22:48:07 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50120 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727415AbgBFDsH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:48:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=majun258@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TpFHoWM_1580960879;
Received: from localhost(mailfrom:majun258@linux.alibaba.com fp:SMTPD_---0TpFHoWM_1580960879)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Feb 2020 11:48:04 +0800
From:   MaJun <majun258@linux.alibaba.com>
To:     guoren@kernel.org
Cc:     majun258@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org
Subject: [PATCH] arch/cksy: Support the pci in csky serial core
Date:   Mon, 27 Jan 2020 10:56:21 +0800
Message-Id: <1580093781-927-1-git-send-email-majun258@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the pci related code for csky serial core.

Signed-off-by: MaJun <majun258@linux.alibaba.com>
---
 arch/csky/Kconfig           |  4 ++++
 arch/csky/include/asm/pci.h | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/csky/include/asm/pci.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index cc5dc37..6ceafa3 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -62,6 +62,10 @@ config CSKY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_KPROBES if !CPU_CK610
 	select HAVE_KRETPROBES if !CPU_CK610
+	select GENERIC_PCI_IOMAP
+	select HAVE_PCI
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_SYSCALL if PCI
 
 config CPU_HAS_CACHEV2
 	bool
diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
new file mode 100644
index 0000000..ccd844e
--- /dev/null
+++ b/arch/csky/include/asm/pci.h
@@ -0,0 +1,17 @@
+#ifndef __ASM_CSKY_PCI_H
+#define __ASM_CSKY_PCI_H
+
+extern int isa_dma_bridge_buggy;
+
+#define PCIBIOS_MIN_IO      0x1000
+#define PCIBIOS_MIN_MEM     0x10000000
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc/bus/pci */
+	return 1;
+}
+
+#define pcibios_assign_all_busses()	1
+
+#endif /* __ASM_CSKY_PCI_H */
-- 
1.8.3.1

