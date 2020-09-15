Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6961C26A23C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIOJcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 05:32:19 -0400
Received: from foss.arm.com ([217.140.110.172]:59054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOJcQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 05:32:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9395F113E;
        Tue, 15 Sep 2020 02:32:15 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.14.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22413F68F;
        Tue, 15 Sep 2020 02:32:13 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "David S. Miller" <davem@davemloft.net>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 1/2] sparc32: Move ioremap/iounmap declaration before asm-generic/io.h include
Date:   Tue, 15 Sep 2020 10:32:02 +0100
Message-Id: <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the ioremap/iounmap declaration before asm-generic/io.h is
included so that it is visible within it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/asm/io_32.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 9a52d9506f80..042201c79ad1 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -11,6 +11,16 @@
 #define memcpy_fromio(d,s,sz) _memcpy_fromio(d,s,sz)
 #define memcpy_toio(d,s,sz)   _memcpy_toio(d,s,sz)
 
+#ifdef __KERNEL__
+
+/*
+ * Bus number may be embedded in the higher bits of the physical address.
+ * This is why we have no bus number argument to ioremap().
+ */
+void __iomem *ioremap(phys_addr_t offset, size_t size);
+void iounmap(volatile void __iomem *addr);
+#endif
+
 #include <asm-generic/io.h>
 
 static inline void _memset_io(volatile void __iomem *dst,
@@ -123,12 +133,6 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
 
 #ifdef __KERNEL__
 
-/*
- * Bus number may be embedded in the higher bits of the physical address.
- * This is why we have no bus number argument to ioremap().
- */
-void __iomem *ioremap(phys_addr_t offset, size_t size);
-void iounmap(volatile void __iomem *addr);
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr);
 void ioport_unmap(void __iomem *);
-- 
2.26.1

