Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0D559DC6
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiFXPwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiFXPwj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 11:52:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42F50003;
        Fri, 24 Jun 2022 08:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA677B8293E;
        Fri, 24 Jun 2022 15:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7BCC341D6;
        Fri, 24 Jun 2022 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656085955;
        bh=z0VIW50hHPorhgqCOjEj4pIbQj4gKEKNY/gMJ41P6tw=;
        h=From:To:Cc:Subject:Date:From;
        b=NEolLau7ihjMHKnysJJTyokDl06zDeTXySMwLvr7vqyVI0L6Nc0fQCjHbkY/zj8Iu
         G2xCgk13FrCQJFnP5wiJ9Plh24nPNake3VPaJ1jDX0SfVpT9BIR9P7BzlET5GnVu0W
         009KSRMprpkQXnDutZG8Vhd4dNM7gMIfiiiyFoLXJNioKUth+KVJbGuJv4bMy2eIWh
         g2BS1YRav2MMUWz7FNWsJdXmZpYZG7C1JSg0xkJF59/7egI/0vitb0b/H0jl0xQrd5
         emKVPOJRccRvz/AglHixFGdOa6q3Xd8SkI34jYzxj1PQZQcHcG8LCmScMy/HfqyGiu
         Kk4iuiK7m3XBw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-scsi@vger.kernel.org
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
Subject: [PATCH v3 0/3] phase out CONFIG_VIRT_TO_BUS
Date:   Fri, 24 Jun 2022 17:52:23 +0200
Message-Id: <20220624155226.2889613-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Kconfig dependencies, and are not actually broken. It might be
helpful as a follow-up to replace them with platform specific
helpers for amiga, m68k-vme and powermac.

There are still a number of drivers that are using virt_to_phys()
and phys_to_virt() in place of dma-mapping operations, and these
are often broken, but they are out of scope for this series.

If there are no more issues identified with this series, I'll
merge it through the asm-generic tree. The SCSI patches can
also get merged separately through the SCSI maintainers' tree
if they prefer.

      Arnd

---
Changes since v2:
 - Drop the dpt_i2o driver completely rather than fixing it
 - fix mistake in BusLogic patch

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
  scsi: BusLogic remove bus_to_virt
  scsi: dpt_i2o: remove obsolete driver
  arch/*/: remove CONFIG_VIRT_TO_BUS

 .../core-api/bus-virt-phys-mapping.rst        |  220 -
 Documentation/core-api/dma-api-howto.rst      |   14 -
 Documentation/core-api/index.rst              |    1 -
 .../translations/zh_CN/core-api/index.rst     |    1 -
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +-
 MAINTAINERS                                   |    8 -
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
 drivers/scsi/BusLogic.c                       |   35 +-
 drivers/scsi/Kconfig                          |   13 +-
 drivers/scsi/Makefile                         |    1 -
 drivers/scsi/dpt/dpti_i2o.h                   |  441 --
 drivers/scsi/dpt/dpti_ioctl.h                 |  136 -
 drivers/scsi/dpt/dptsig.h                     |  336 --
 drivers/scsi/dpt/osd_defs.h                   |   79 -
 drivers/scsi/dpt/osd_util.h                   |  358 --
 drivers/scsi/dpt/sys_info.h                   |  417 --
 drivers/scsi/dpt_i2o.c                        | 3546 -----------------
 drivers/scsi/dpti.h                           |  331 --
 include/asm-generic/io.h                      |   14 -
 mm/Kconfig                                    |    8 -
 40 files changed, 35 insertions(+), 5989 deletions(-)
 delete mode 100644 Documentation/core-api/bus-virt-phys-mapping.rst
 delete mode 100644 drivers/scsi/dpt/dpti_i2o.h
 delete mode 100644 drivers/scsi/dpt/dpti_ioctl.h
 delete mode 100644 drivers/scsi/dpt/dptsig.h
 delete mode 100644 drivers/scsi/dpt/osd_defs.h
 delete mode 100644 drivers/scsi/dpt/osd_util.h
 delete mode 100644 drivers/scsi/dpt/sys_info.h
 delete mode 100644 drivers/scsi/dpt_i2o.c
 delete mode 100644 drivers/scsi/dpti.h

-- 
2.29.2

