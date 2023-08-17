Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF27A77FB8D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353465AbjHQQI0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353507AbjHQQIE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:08:04 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF13A84
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 09:07:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by laurent.telenet-ops.be with bizsmtp
        id ag7i2A0034QHFyo01g7i1C; Thu, 17 Aug 2023 18:07:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfX4-000uIf-BZ;
        Thu, 17 Aug 2023 18:07:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWfXB-007YEb-P7;
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
Subject: [PATCH treewide 0/9] Remove obsolete IDE headers
Date:   Thu, 17 Aug 2023 18:07:31 +0200
Message-Id: <cover.1692288018.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
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

	Hi all,

This patch series removes all unused <asm/ide.h> headers and
<asm-generic/ide_iops.h>.  <asm/ide.h> was still included by 3 PATA
drivers for m68k platforms, but without any real need.

The first 5 patches have no dependencies.
The last patch depends on the 3 pata patches.

Thanks for your comments!

Geert Uytterhoeven (9):
  ARM: Remove <asm/ide.h>
  parisc: Remove <asm/ide.h>
  powerpc: Remove <asm/ide.h>
  sparc: Remove <asm/ide.h>
  asm-generic: Remove ide_iops.h
  ata: pata_buddha: Remove #include <asm/ide.h>
  ata: pata_falcon: Remove #include <asm/ide.h>
  ata: pata_gayle: Remove #include <asm/ide.h>
  m68k: Remove <asm/ide.h>

 arch/arm/include/asm/ide.h     | 24 ---------
 arch/m68k/include/asm/ide.h    | 67 -----------------------
 arch/parisc/include/asm/ide.h  | 54 -------------------
 arch/powerpc/include/asm/ide.h | 18 -------
 arch/sparc/include/asm/ide.h   | 97 ----------------------------------
 drivers/ata/pata_buddha.c      |  1 -
 drivers/ata/pata_falcon.c      |  1 -
 drivers/ata/pata_gayle.c       |  1 -
 include/asm-generic/ide_iops.h | 39 --------------
 9 files changed, 302 deletions(-)
 delete mode 100644 arch/arm/include/asm/ide.h
 delete mode 100644 arch/m68k/include/asm/ide.h
 delete mode 100644 arch/parisc/include/asm/ide.h
 delete mode 100644 arch/powerpc/include/asm/ide.h
 delete mode 100644 arch/sparc/include/asm/ide.h
 delete mode 100644 include/asm-generic/ide_iops.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
