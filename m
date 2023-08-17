Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414ED77FB8F
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353490AbjHQQI2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbjHQQID (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:08:03 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00A535BC
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 09:07:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by laurent.telenet-ops.be with bizsmtp
        id ag7i2A0054QHFyo01g7i1F; Thu, 17 Aug 2023 18:07:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfX4-000uIv-EU;
        Thu, 17 Aug 2023 18:07:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfXB-007YEt-Th;
        Thu, 17 Aug 2023 18:07:41 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Russell King <linux@armlinux.org.uk>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/9] asm-generic: Remove ide_iops.h
Date:   Thu, 17 Aug 2023 18:07:36 +0200
Message-Id: <54ed1ce4b29346803bd732aac560a74896d1ecfe.1692288018.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692288018.git.geert@linux-m68k.org>
References: <cover.1692288018.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The last user of ide_iops.h was removed in commit b7fb14d3ac63117e
("ide: remove the legacy ide driver") in v5.14.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/asm-generic/ide_iops.h | 39 ----------------------------------
 1 file changed, 39 deletions(-)
 delete mode 100644 include/asm-generic/ide_iops.h

diff --git a/include/asm-generic/ide_iops.h b/include/asm-generic/ide_iops.h
deleted file mode 100644
index 81dfa3ee5e0697b7..0000000000000000
--- a/include/asm-generic/ide_iops.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Generic I/O and MEMIO string operations.  */
-
-#define __ide_insw	insw
-#define __ide_insl	insl
-#define __ide_outsw	outsw
-#define __ide_outsl	outsl
-
-static __inline__ void __ide_mm_insw(void __iomem *port, void *addr, u32 count)
-{
-	while (count--) {
-		*(u16 *)addr = readw(port);
-		addr += 2;
-	}
-}
-
-static __inline__ void __ide_mm_insl(void __iomem *port, void *addr, u32 count)
-{
-	while (count--) {
-		*(u32 *)addr = readl(port);
-		addr += 4;
-	}
-}
-
-static __inline__ void __ide_mm_outsw(void __iomem *port, void *addr, u32 count)
-{
-	while (count--) {
-		writew(*(u16 *)addr, port);
-		addr += 2;
-	}
-}
-
-static __inline__ void __ide_mm_outsl(void __iomem * port, void *addr, u32 count)
-{
-	while (count--) {
-		writel(*(u32 *)addr, port);
-		addr += 4;
-	}
-}
-- 
2.34.1

