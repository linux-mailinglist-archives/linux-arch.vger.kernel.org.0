Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB053E391
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiFFIlv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiFFIld (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 04:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ABFD80B9;
        Mon,  6 Jun 2022 01:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ADF56120D;
        Mon,  6 Jun 2022 08:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35532C34119;
        Mon,  6 Jun 2022 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654504884;
        bh=sDOLXYQR0wOt3J1gNTtbMOI7sGHc/kgPyuM8RXutK6o=;
        h=From:To:Cc:Subject:Date:From;
        b=SkDVuZeDrFJ5adNIjdWczP7EVnrZrEp+b8yU8nbse1AbBTmXLuujgQXqukIPdpKP3
         jSZ31jnOZ/+J/T/tRB28RAeo8NGiBd/TKqQnFCLbG+oG/dtT3GCqi/W3IS2bDK+hNi
         i0jDa5e9iaXrvGUPpvloldIKntp4YGFDBwTdkXFsEdbaMrGtGPlL0fuvuGwxCMBdVV
         76gpV0DFczhbrMGSff3e/ZOmlqAnKy+kOhfKLgF12HFzcDvn0yARasaaVFnbObBUAl
         uX74CL7XSW/CloOp4Tr2E8Z8nhD9gE9XMoP2apFoo0WvB+vAsfa8d7hBmEvkZ2XDcE
         aSXARa3ZlYuZg==
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
Subject: [PATCH 0/6] phase out CONFIG_VIRT_TO_BUS
Date:   Mon,  6 Jun 2022 10:41:03 +0200
Message-Id: <20220606084109.4108188-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The virt_to_bus/bus_to_virt interface has been deprecated for
decades. After Jakub Kicinski put a lot of work into cleaning out the
network drivers using them, there are only a couple of other drivers
left, which can all be removed or otherwise cleaned up, to remove the
old interface for good.

Any out of tree drivers using virt_to_bus() should be converted to
using the dma-mapping interfaces, typically dma_alloc_coherent()
or dma_map_single()).

There are a few m68k and ppc32 specific drivers that keep using the
interfaces, but these are all guarded with architecture-specific
Kconfig dependencies, and are not actually broken.

There are still a number of drivers that are using virt_to_phys()
and phys_to_virt() in place of dma-mapping operations, and these
are often broken, but they are out of scope for this series.

      Arnd

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org> # dma-mapping
Cc: Marek Szyprowski <m.szyprowski@samsung.com> # dma-mapping
Cc: Robin Murphy <robin.murphy@arm.com> # dma-mapping
Cc: iommu@lists.linux-foundation.org
Cc: Khalid Aziz <khalid@gonehiking.org> # buslogic
Cc: linux-scsi@vger.kernel.org
Cc: Manohar Vanga <manohar.vanga@gmail.com> # vme
Cc: Martyn Welch <martyn@welchs.me.uk> # vme
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # vme
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-parisc@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com> # floppy

Arnd Bergmann (6):
  vme: remove ca91cx42 Universe-II support
  vme: move back to staging
  media: sta2x11: remove VIRT_TO_BUS dependency
  scsi: dpt_i2o: drop stale VIRT_TO_BUS dependency
  scsi: remove stale BusLogic driver
  arch/*/: remove CONFIG_VIRT_TO_BUS

 .../core-api/bus-virt-phys-mapping.rst        |  220 -
 Documentation/core-api/dma-api-howto.rst      |   14 -
 Documentation/core-api/index.rst              |    1 -
 Documentation/driver-api/vme.rst              |    4 +-
 Documentation/scsi/BusLogic.rst               |  581 --
 Documentation/scsi/FlashPoint.rst             |  176 -
 .../translations/zh_CN/core-api/index.rst     |    1 -
 MAINTAINERS                                   |   11 +-
 arch/alpha/Kconfig                            |    1 -
 arch/alpha/include/asm/floppy.h               |    2 +-
 arch/alpha/include/asm/io.h                   |    8 +-
 arch/ia64/Kconfig                             |    1 -
 arch/ia64/include/asm/io.h                    |    8 -
 arch/m68k/Kconfig                             |    1 -
 arch/m68k/include/asm/virtconvert.h           |    4 +-
 arch/microblaze/Kconfig                       |    1 -
 arch/microblaze/include/asm/io.h              |    2 -
 arch/mips/Kconfig                             |    1 -
 arch/mips/include/asm/io.h                    |    9 -
 arch/parisc/Kconfig                           |    1 -
 arch/parisc/include/asm/floppy.h              |    4 +-
 arch/parisc/include/asm/io.h                  |    2 -
 arch/powerpc/Kconfig                          |    1 -
 arch/powerpc/include/asm/io.h                 |    2 -
 arch/riscv/include/asm/page.h                 |    1 -
 arch/x86/Kconfig                              |    1 -
 arch/x86/include/asm/io.h                     |    9 -
 arch/xtensa/Kconfig                           |    1 -
 arch/xtensa/include/asm/io.h                  |    3 -
 drivers/Kconfig                               |    2 -
 drivers/Makefile                              |    1 -
 drivers/media/pci/sta2x11/Kconfig             |    2 +-
 drivers/scsi/BusLogic.c                       | 3727 --------
 drivers/scsi/BusLogic.h                       | 1284 ---
 drivers/scsi/FlashPoint.c                     | 7560 -----------------
 drivers/scsi/Kconfig                          |   26 +-
 drivers/scsi/dpt_i2o.c                        |    4 +-
 drivers/staging/vme_user/Kconfig              |   27 +
 drivers/staging/vme_user/Makefile             |    3 +
 drivers/{vme => staging/vme_user}/vme.c       |    2 +-
 .../linux => drivers/staging/vme_user}/vme.h  |    0
 .../{vme => staging/vme_user}/vme_bridge.h    |    2 +-
 .../bridges => staging/vme_user}/vme_fake.c   |    4 +-
 .../bridges => staging/vme_user}/vme_tsi148.c |    4 +-
 .../bridges => staging/vme_user}/vme_tsi148.h |    0
 drivers/staging/vme_user/vme_user.c           |    2 +-
 drivers/vme/Kconfig                           |   18 -
 drivers/vme/Makefile                          |    8 -
 drivers/vme/boards/Kconfig                    |   10 -
 drivers/vme/boards/Makefile                   |    6 -
 drivers/vme/boards/vme_vmivme7805.c           |  106 -
 drivers/vme/boards/vme_vmivme7805.h           |   33 -
 drivers/vme/bridges/Kconfig                   |   24 -
 drivers/vme/bridges/Makefile                  |    4 -
 drivers/vme/bridges/vme_ca91cx42.c            | 1928 -----
 drivers/vme/bridges/vme_ca91cx42.h            |  579 --
 include/asm-generic/io.h                      |   14 -
 mm/Kconfig                                    |    8 -
 58 files changed, 54 insertions(+), 16405 deletions(-)
 delete mode 100644 Documentation/core-api/bus-virt-phys-mapping.rst
 delete mode 100644 Documentation/scsi/BusLogic.rst
 delete mode 100644 Documentation/scsi/FlashPoint.rst
 delete mode 100644 drivers/scsi/BusLogic.c
 delete mode 100644 drivers/scsi/BusLogic.h
 delete mode 100644 drivers/scsi/FlashPoint.c
 rename drivers/{vme => staging/vme_user}/vme.c (99%)
 rename {include/linux => drivers/staging/vme_user}/vme.h (100%)
 rename drivers/{vme => staging/vme_user}/vme_bridge.h (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_fake.c (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_tsi148.c (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_tsi148.h (100%)
 delete mode 100644 drivers/vme/Kconfig
 delete mode 100644 drivers/vme/Makefile
 delete mode 100644 drivers/vme/boards/Kconfig
 delete mode 100644 drivers/vme/boards/Makefile
 delete mode 100644 drivers/vme/boards/vme_vmivme7805.c
 delete mode 100644 drivers/vme/boards/vme_vmivme7805.h
 delete mode 100644 drivers/vme/bridges/Kconfig
 delete mode 100644 drivers/vme/bridges/Makefile
 delete mode 100644 drivers/vme/bridges/vme_ca91cx42.c
 delete mode 100644 drivers/vme/bridges/vme_ca91cx42.h

-- 
2.29.2

