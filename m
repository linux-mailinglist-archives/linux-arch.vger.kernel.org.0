Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D239CE37
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFFJGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFJGt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:06:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5084A61422;
        Sun,  6 Jun 2021 09:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970300;
        bh=WCq0jCKZFKVHZkUKk3gJmYAjMTZohhpA6kBYeDMWP54=;
        h=From:To:Cc:Subject:Date:From;
        b=oxm3u1RP/XRReqemGC1w532UhAYbNFeDtf/dUXCrcNLysVUcw4/kGCyTdx9vNl5TS
         r6hlzvO/e7yX0PDSFziN3hyZcemocYljnFsJP7aY75U+5QY16SyqN0TRAakBGTCQmN
         PQM1cFGkvmha5xMK1voUxdWPUHNPcNqiCJsAvuLLb0SSka+oLcnleqO/S/4lNlMoFk
         oAkyp08HeBmpT1lJreARal81zS5mUr89OQm7JCNabNHIoAxKVWRc52fFZMnIfrVAEZ
         G8Mr7Zk5CE5h5lVNkRb8WJQOtmVvTDTQDUjAEjuNcTRB/NuYG+/NPmJNRiZRhEdXiq
         OkMVD5ZRlFBhA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v2 00/11] riscv: Add DMA_COHERENT support for Allwinner D1
Date:   Sun,  6 Jun 2021 09:03:55 +0000
Message-Id: <1622970249-50770-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
vendors define the custom properties of memory regions in PTE.

This patchset helps SOC vendors to support their own custom interconnect
coherent solution with PTE attributes.

For example, allwinner D1[1] uses T-HEAD C906 as main processor, C906 has
two modes in MMU:
 - Compatible mode, the same as the definitions in spec.
 - Enhanced mode, add custom DMA_COHERENT attribute bits in PTE which
   not mentioned in spec.

Allwinner D1 needs the enhanced mode to support the DMA type device with
non-coherent interconnect in its SOC. C906 uses BITS(63 - 59) as custom
attribute bits in PTE.

The patchset contain 4 parts (asid, pgtable, cmo, soc) which have been
tested on D1:
 - asid: T-HEAD C906 of D1 contains full asid hw facilities which has no
   conflict with RISC-V spec, and hope these patches soon could be
   approved.
 - pgtable: Using a image-hdr to pass vendor specific information and
   setup custom PTE attributes in a global struct variable during boot
   stage. Also it needs define custom protection_map in linux/mm.
 - cmo: We need deal with dma_sync & icache_sync & __vdso_icache_sync.
   In this patchset, I just show you how T-HEAD C9xx work, and seems Atish
   is working for the DMA infrustructure, please let me know the idea.
 - soc: Add allwinner gmac driver & dts & Kconfig for sunxi test.

The patchset could work with linux-5.13-rc4, here is the steps for D1:
 - Download linux-5.13-rc4 and apply the patchset
 - make ARCH=riscv CROSS_COMPILE=riscv64-linux- defconfig
 - make ARCH=riscv CROSS_COMPILE=riscv64-linux- Image modules dtbs
 - mkimage -A riscv -O linux -T kernel -C none -a 0x00200000 -e 0x00200000 -n Linux -d arch/riscv/boot/Image uImage
 - Download newest opensbi [2], build with [3], and get fw_dynamic.bin
 - Copy uImage, fw_dynamic.bin, allwinner-d1-nezha-kit.dtb into boot
   partition of TF card.
 - Plugin the TF card and power on D1.

Link: https://linux-sunxi.org/D1 [1]
Link: https://github.com/riscv/opensbi branch:master [2]
Link: https://github.com/riscv/opensbi/blob/master/docs/platform/thead-c9xx.md [3]

Changes since v1:
 - Rebase on linux-5.13-rc4
 - Support defconfig for different PTE attributes
 - Support C906 icache_sync
 - Add Allwinner D1 dts & Kconfig & gmac for testing
 - Add asid optimization for D1 usage

Guo Ren (10):
  riscv: asid: Use global mappings for kernel pages
  riscv: asid: Add ASID-based tlbflushing methods
  riscv: asid: Optimize tlbflush coding convention
  riscv: pgtable: Fixup _PAGE_CHG_MASK usage
  riscv: pgtable: Add custom protection_map init
  riscv: pgtable: Add DMA_COHERENT with custom PTE attributes
  riscv: cmo: Add dma-noncoherency support
  riscv: cmo: Add vendor custom icache sync
  riscv: soc: Initial DTS for Allwinner D1 NeZha board
  riscv: soc: Add Allwinner SoC kconfig option

liush (1):
  riscv: soc: Allwinner D1 GMAC driver only for temp use

 arch/riscv/Kconfig                                 |    9 +
 arch/riscv/Kconfig.socs                            |   12 +
 arch/riscv/boot/dts/Makefile                       |    1 +
 arch/riscv/boot/dts/allwinner/Makefile             |    2 +
 .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  |   29 +
 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    |  100 +
 arch/riscv/configs/defconfig                       |    1 +
 arch/riscv/include/asm/cacheflush.h                |   48 +-
 arch/riscv/include/asm/mmu_context.h               |    2 +
 arch/riscv/include/asm/pgtable-64.h                |    8 +-
 arch/riscv/include/asm/pgtable-bits.h              |   20 +-
 arch/riscv/include/asm/pgtable.h                   |   44 +-
 arch/riscv/include/asm/sbi.h                       |   15 +
 arch/riscv/include/asm/soc.h                       |    1 +
 arch/riscv/include/asm/tlbflush.h                  |   22 +
 arch/riscv/include/asm/vendorid_list.h             |    1 +
 arch/riscv/kernel/sbi.c                            |   19 +
 arch/riscv/kernel/soc.c                            |   22 +
 arch/riscv/kernel/vdso/flush_icache.S              |   33 +-
 arch/riscv/mm/Makefile                             |    1 +
 arch/riscv/mm/cacheflush.c                         |    3 +-
 arch/riscv/mm/context.c                            |    2 +-
 arch/riscv/mm/dma-mapping.c                        |   53 +
 arch/riscv/mm/init.c                               |   26 +
 arch/riscv/mm/tlbflush.c                           |   57 +-
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/allwinnertmp/Kconfig          |   17 +
 drivers/net/ethernet/allwinnertmp/Makefile         |    7 +
 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c |  690 ++++++
 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c     | 2240 ++++++++++++++++++++
 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h     |  258 +++
 drivers/net/phy/realtek.c                          |    2 +-
 mm/mmap.c                                          |    4 +
 34 files changed, 3714 insertions(+), 37 deletions(-)
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
 create mode 100644 arch/riscv/mm/dma-mapping.c
 create mode 100644 drivers/net/ethernet/allwinnertmp/Kconfig
 create mode 100644 drivers/net/ethernet/allwinnertmp/Makefile
 create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac-ops.c
 create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.c
 create mode 100644 drivers/net/ethernet/allwinnertmp/sunxi-gmac.h

-- 
2.7.4

