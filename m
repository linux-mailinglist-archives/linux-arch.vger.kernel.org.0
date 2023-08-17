Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDB77FB99
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353467AbjHQQI1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353476AbjHQQIA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:08:00 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F38D35A9
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 09:07:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by xavier.telenet-ops.be with bizsmtp
        id ag7i2A0044QHFyo01g7imX; Thu, 17 Aug 2023 18:07:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfX4-000uJ0-FK;
        Thu, 17 Aug 2023 18:07:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfXB-007YEx-Ua;
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
Subject: [PATCH 6/9] ata: pata_buddha: Remove #include <asm/ide.h>
Date:   Thu, 17 Aug 2023 18:07:37 +0200
Message-Id: <0e03e9d36c80f9d6702191fb202ce7b56360bf49.1692288018.git.geert@linux-m68k.org>
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

The Buddha, Catweasel, and X-Surf PATA driver does not need anything
from <asm/ide.h>.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/pata_buddha.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
index 49bc619b83e255a3..c36ee991d5e5fdcc 100644
--- a/drivers/ata/pata_buddha.c
+++ b/drivers/ata/pata_buddha.c
@@ -27,7 +27,6 @@
 
 #include <asm/amigahw.h>
 #include <asm/amigaints.h>
-#include <asm/ide.h>
 #include <asm/setup.h>
 
 #define DRV_NAME "pata_buddha"
-- 
2.34.1

