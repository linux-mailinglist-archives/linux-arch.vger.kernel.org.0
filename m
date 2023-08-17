Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6892F77FB88
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbjHQQI1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353467AbjHQQH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:07:59 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369F358E
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 09:07:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by michel.telenet-ops.be with bizsmtp
        id ag7i2A0034QHFyo06g7i5M; Thu, 17 Aug 2023 18:07:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfX4-000uIj-CR;
        Thu, 17 Aug 2023 18:07:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfXB-007YEk-Re;
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
Subject: [PATCH 3/9] powerpc: Remove <asm/ide.h>
Date:   Thu, 17 Aug 2023 18:07:34 +0200
Message-Id: <eb79960c5f9f72013b3b2f6d19461e5d8134fcc2.1692288018.git.geert@linux-m68k.org>
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

As of commit b7fb14d3ac63117e ("ide: remove the legacy ide driver") in
v5.14, there are no more generic users of <asm/ide.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/powerpc/include/asm/ide.h | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/ide.h

diff --git a/arch/powerpc/include/asm/ide.h b/arch/powerpc/include/asm/ide.h
deleted file mode 100644
index ce87a4441ca34887..0000000000000000
--- a/arch/powerpc/include/asm/ide.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright (C) 1994-1996 Linus Torvalds & authors
- *
- *  This file contains the powerpc architecture specific IDE code.
- */
-#ifndef _ASM_POWERPC_IDE_H
-#define _ASM_POWERPC_IDE_H
-
-#include <linux/compiler.h>
-#include <asm/io.h>
-
-#define __ide_mm_insw(p, a, c)	readsw((void __iomem *)(p), (a), (c))
-#define __ide_mm_insl(p, a, c)	readsl((void __iomem *)(p), (a), (c))
-#define __ide_mm_outsw(p, a, c)	writesw((void __iomem *)(p), (a), (c))
-#define __ide_mm_outsl(p, a, c)	writesl((void __iomem *)(p), (a), (c))
-
-#endif /* _ASM_POWERPC_IDE_H */
-- 
2.34.1

