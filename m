Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4B054F7EA
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381999AbiFQM6G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 08:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiFQM6F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 08:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB291A832;
        Fri, 17 Jun 2022 05:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 781BF61FA8;
        Fri, 17 Jun 2022 12:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBDC3411B;
        Fri, 17 Jun 2022 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655470682;
        bh=cLraNpkEnCzF/4zKCRGjwHG57BoDqUlRiy0OHq9zjK0=;
        h=From:To:Cc:Subject:Date:From;
        b=oH4x2PycGtrhhz35364UaeAzZu23iN71evljdxuntEZ1VsVln0947L4kgXWuEzLrC
         OLWEWoJhN8r14vT4yHg3QQ8tQZDKO4OIba+kSPV417/BH7s5oxSh7c9Yljg6Gr1afz
         xj6FbXz6U/9X2aXj04KSLFiOeD9C/zZoF0JfQi5Xj9zHHyGlm4nv/8XJxqnfGaiKhC
         xU+lb1e94omoeQ0C4aaO2uCUV9m066p1W0G5moNKShM55uVOSpn4kV7bLBshwrY4Rp
         NgxDokayeZJhS/Gn+T5DZpIazOVqwZSNsiUx9537mSMzxTSIGDTQ6H1nn5bxhvpiW3
         g1++SMPFn7Evg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 0/3] phase out CONFIG_VIRT_TO_BUS
Date:   Fri, 17 Jun 2022 14:57:47 +0200
Message-Id: <20220617125750.728590-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

I would like the first two patches to either get merged through
the SCSI tree, or get an Ack from the SCSI maintainers so I can
merge them through the asm-generic tree

      Arnd

---
Changes since v1:
 - dropped VME patches that are already in staging-next
 - dropped media patch that gets merged independently
 - added a networking patch and dropped it again after it got merged
 - replace BusLogic removal with a workaround

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org> # dma-mapping
Cc: Marek Szyprowski <m.szyprowski@samsung.com> # dma-mapping
Cc: Robin Murphy <robin.murphy@arm.com> # dma-mapping
Cc: iommu@lists.linux-foundation.org
Cc: Khalid Aziz <khalid@gonehiking.org> # buslogic
Cc: Maciej W. Rozycki <macro@orcam.me.uk> # buslogic
Cc: Matt Wang <wwentao@vmware.com> # buslogic
Cc: Miquel van Smoorenburg <mikevs@xs4all.net> # dpt_i2o
Cc: Mark Salyzyn <salyzyn@android.com> # dpt_i2o
Cc: linux-scsi@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-parisc@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com> # floppy

Arnd Bergmann (3):
  scsi: dpt_i2o: drop stale VIRT_TO_BUS dependency
  scsi: BusLogic remove bus_to_virt
  arch/*/: remove CONFIG_VIRT_TO_BUS

 .../core-api/bus-virt-phys-mapping.rst        | 220 ------------------
 Documentation/core-api/dma-api-howto.rst      |  14 --
 Documentation/core-api/index.rst              |   1 -
 .../translations/zh_CN/core-api/index.rst     |   1 -
 arch/alpha/Kconfig                            |   1 -
 arch/alpha/include/asm/floppy.h               |   2 +-
 arch/alpha/include/asm/io.h                   |   8 +-
 arch/ia64/Kconfig                             |   1 -
 arch/ia64/include/asm/io.h                    |   8 -
 arch/m68k/Kconfig                             |   1 -
 arch/m68k/include/asm/virtconvert.h           |   4 +-
 arch/microblaze/Kconfig                       |   1 -
 arch/microblaze/include/asm/io.h              |   2 -
 arch/mips/Kconfig                             |   1 -
 arch/mips/include/asm/io.h                    |   9 -
 arch/parisc/Kconfig                           |   1 -
 arch/parisc/include/asm/floppy.h              |   4 +-
 arch/parisc/include/asm/io.h                  |   2 -
 arch/powerpc/Kconfig                          |   1 -
 arch/powerpc/include/asm/io.h                 |   2 -
 arch/riscv/include/asm/page.h                 |   1 -
 arch/x86/Kconfig                              |   1 -
 arch/x86/include/asm/io.h                     |   9 -
 arch/xtensa/Kconfig                           |   1 -
 arch/xtensa/include/asm/io.h                  |   3 -
 drivers/scsi/BusLogic.c                       |  27 ++-
 drivers/scsi/Kconfig                          |   4 +-
 drivers/scsi/dpt_i2o.c                        |   4 +-
 include/asm-generic/io.h                      |  14 --
 mm/Kconfig                                    |   8 -
 30 files changed, 30 insertions(+), 326 deletions(-)
 delete mode 100644 Documentation/core-api/bus-virt-phys-mapping.rst

-- 
2.29.2

