Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE4877FBDA
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353569AbjHQQRB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353571AbjHQQQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:16:45 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 09:16:44 PDT
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [IPv6:2a02:1800:110:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4B7173F
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 09:16:44 -0700 (PDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4RRVK739dGz4xbj9
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 18:07:55 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by baptiste.telenet-ops.be with bizsmtp
        id ag7i2A00B4QHFyo01g7ivk; Thu, 17 Aug 2023 18:07:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfX4-000uJD-JE;
        Thu, 17 Aug 2023 18:07:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfXC-007YFD-16;
        Thu, 17 Aug 2023 18:07:42 +0200
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
Subject: [PATCH 9/9] m68k: Remove <asm/ide.h>
Date:   Thu, 17 Aug 2023 18:07:40 +0200
Message-Id: <3e84d9f8bf0aefcbc06a73bb9f0b98dedab0271f.1692288018.git.geert@linux-m68k.org>
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

There are no more users of <asm/ide.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/ide.h | 67 -------------------------------------
 1 file changed, 67 deletions(-)
 delete mode 100644 arch/m68k/include/asm/ide.h

diff --git a/arch/m68k/include/asm/ide.h b/arch/m68k/include/asm/ide.h
deleted file mode 100644
index 05cc7dc00e0c1437..0000000000000000
--- a/arch/m68k/include/asm/ide.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-/* Copyright(c) 1996 Kars de Jong */
-/* Based on the ide driver from 1.2.13pl8 */
-
-/*
- * Credits (alphabetical):
- *
- *  - Bjoern Brauel
- *  - Kars de Jong
- *  - Torsten Ebeling
- *  - Dwight Engen
- *  - Thorsten Floeck
- *  - Roman Hodek
- *  - Guenther Kelleter
- *  - Chris Lawrence
- *  - Michael Rausch
- *  - Christian Sauer
- *  - Michael Schmitz
- *  - Jes Soerensen
- *  - Michael Thurm
- *  - Geert Uytterhoeven
- */
-
-#ifndef _M68K_IDE_H
-#define _M68K_IDE_H
-
-#ifdef __KERNEL__
-#include <asm/setup.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#ifdef CONFIG_MMU
-
-/*
- * Get rid of defs from io.h - ide has its private and conflicting versions
- * Since so far no single m68k platform uses ISA/PCI I/O space for IDE, we
- * always use the `raw' MMIO versions
- */
-#undef readb
-#undef readw
-#undef writeb
-#undef writew
-
-#define readb				in_8
-#define readw				in_be16
-#define __ide_mm_insw(port, addr, n)	raw_insw((u16 *)port, addr, n)
-#define __ide_mm_insl(port, addr, n)	raw_insl((u32 *)port, addr, n)
-#define writeb(val, port)		out_8(port, val)
-#define writew(val, port)		out_be16(port, val)
-#define __ide_mm_outsw(port, addr, n)	raw_outsw((u16 *)port, addr, n)
-#define __ide_mm_outsl(port, addr, n)	raw_outsl((u32 *)port, addr, n)
-
-#else
-
-#define __ide_mm_insw(port, addr, n)	io_insw((unsigned int)port, addr, n)
-#define __ide_mm_insl(port, addr, n)	io_insl((unsigned int)port, addr, n)
-#define __ide_mm_outsw(port, addr, n)	io_outsw((unsigned int)port, addr, n)
-#define __ide_mm_outsl(port, addr, n)	io_outsl((unsigned int)port, addr, n)
-
-#endif /* CONFIG_MMU */
-
-#endif /* __KERNEL__ */
-#endif /* _M68K_IDE_H */
-- 
2.34.1

