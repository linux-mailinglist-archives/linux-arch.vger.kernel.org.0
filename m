Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8053877FB9E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353497AbjHQQI2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353290AbjHQQH5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:07:57 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1103230F5
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 09:07:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by albert.telenet-ops.be with bizsmtp
        id ag7i2A0054QHFyo06g7iZw; Thu, 17 Aug 2023 18:07:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfX4-000uJ9-HE;
        Thu, 17 Aug 2023 18:07:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfXC-007YF9-0C;
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
Subject: [PATCH 8/9] ata: pata_gayle: Remove #include <asm/ide.h>
Date:   Thu, 17 Aug 2023 18:07:39 +0200
Message-Id: <8a6ff4d7caad33dcb6b32ab49329b7bc4ec0c29b.1692288018.git.geert@linux-m68k.org>
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

The Amiga Gayle PATA driver does not need anything from <asm/ide.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/pata_gayle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pata_gayle.c b/drivers/ata/pata_gayle.c
index e5aa07f92106547e..3bdbe2b65a2b49f1 100644
--- a/drivers/ata/pata_gayle.c
+++ b/drivers/ata/pata_gayle.c
@@ -27,7 +27,6 @@
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
 #include <asm/amigayle.h>
-#include <asm/ide.h>
 #include <asm/setup.h>
 
 #define DRV_NAME "pata_gayle"
-- 
2.34.1

