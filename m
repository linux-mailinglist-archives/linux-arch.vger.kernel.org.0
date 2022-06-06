Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E135D53E31D
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiFFInj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 04:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiFFImS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 04:42:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E1DC805;
        Mon,  6 Jun 2022 01:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EB385CE1712;
        Mon,  6 Jun 2022 08:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA3DC34119;
        Mon,  6 Jun 2022 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654504897;
        bh=D+RdnsGxCjpna2nFhDsPH8yn1kQWXeuteyiCbSjG4Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqkhvRnQT5TdcQzFwYUC5t6BbcwuV7Wpx2G1o5hTpanlR8yXaV4ODVU7ew7jL8DvO
         l3JTVw7DKobxXEKQZ3heVLvDfhUmjB940bcalu6UvoP2LwHrYPpKg12kYzTLQS6pKT
         kf317YxZeSp6jD/5DgCpKbSN6CjRhym31MHdvdZtORbIwmeGN1epari6VDm6Zv3KZl
         sRRdHvKbw8lAF0HX5L+i6MurK8fE/6XIhEVBIspfhVP5cePJ7g5c65vcGINxSZpFqa
         vlwgUpxU3YlmZrSSRp2xN6dqcrwPKgCERmeHhrZ2pBVMMXljYfaBR5K2rCGXZ4IYSq
         D/00l/vISah5w==
From:   Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi@vger.kernel.org,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH 3/6] media: sta2x11: remove VIRT_TO_BUS dependency
Date:   Mon,  6 Jun 2022 10:41:06 +0200
Message-Id: <20220606084109.4108188-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220606084109.4108188-1-arnd@kernel.org>
References: <20220606084109.4108188-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This driver does not use the virt_to_bus() function, though it
depends on x86 specific fixups in the swiotlb code, which was
last rewritten in commit e380a0394c36 ("x86/PCI: sta2x11: use
default DMA address translation").

It is possible that the driver still fails to build on some
architectures that are missing CONFIG_VIRT_TO_BUS, but it is
always set on x86 machines with the STA2X11 platform enabled.

More likely though is that it was never meant to depend on
CONFIG_VIRT_TO_BUS, and the Kconfig dependency was kept from
an out-of-tree version when the driver was originally merged.

Fixes: efeb98b4e2b2 ("[media] STA2X11 VIP: new V4L2 driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/sta2x11/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/sta2x11/Kconfig b/drivers/media/pci/sta2x11/Kconfig
index a96e170ab04e..118b922c08c3 100644
--- a/drivers/media/pci/sta2x11/Kconfig
+++ b/drivers/media/pci/sta2x11/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config STA2X11_VIP
 	tristate "STA2X11 VIP Video For Linux"
-	depends on PCI && VIDEO_DEV && VIRT_TO_BUS && I2C
+	depends on PCI && VIDEO_DEV && I2C
 	depends on STA2X11 || COMPILE_TEST
 	select GPIOLIB if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_ADV7180 if MEDIA_SUBDRV_AUTOSELECT
-- 
2.29.2

