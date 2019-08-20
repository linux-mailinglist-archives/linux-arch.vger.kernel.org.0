Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80CB96382
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfHTO6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 10:58:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfHTO6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DB25AE42;
        Tue, 20 Aug 2019 14:58:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        eric@anholt.net, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 00/11] Raspberry Pi 4 DMA addressing support
Date:   Tue, 20 Aug 2019 16:58:08 +0200
Message-Id: <20190820145821.27214-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,
this series attempts to address some issues we found while bringing up
the new Raspberry Pi 4 in arm64 and it's intended to serve as a follow
up of these discussions:
v1: https://lkml.org/lkml/2019/7/31/922
RFC: https://lkml.org/lkml/2019/7/17/476

The new Raspberry Pi 4 has up to 4GB of memory but most peripherals can
only address the first GB: their DMA address range is
0xc0000000-0xfc000000 which is aliased to the first GB of physical
memory 0x00000000-0x3c000000. Note that only some peripherals have these
limitations: the PCIe, V3D, GENET, and 40-bit DMA channels have a wider
view of the address space by virtue of being hooked up trough a second
interconnect.

Part of this is solved in arm32 by setting up the machine specific
'.dma_zone_size = SZ_1G', which takes care of reserving the coherent
memory area at the right spot. That said no buffer bouncing (needed for
dma streaming) is available at the moment, but that's a story for
another series.

Unfortunately there is no such thing as 'dma_zone_size' in arm64. Only
ZONE_DMA32 is created which is interpreted by dma-direct and the arm64
arch code as if all peripherals where be able to address the first 4GB
of memory.

In the light of this, the series implements the following changes:

- Create generic 'dma_zone_size' in order for hardware description code
  to set it up when needed.

- Add a function in early_init_dt_scan() to setup 'dma_zone_size' for
  the RPi4.

- Create both DMA zones in arm64, ZONE_DMA will contain the area
  addressable by all peripherals and ZONE_DMA32 the rest of the 32 bit
  addressable memory. ZONE_DMA32 might be left empty.

- Reserve the CMA area in a place suitable for all peripherals.

- Inform dma-direct of the new runtime calculated min_mask.

This series has been tested on multiple devices both by checking the
zones setup matches the expectations and by double-checking physical
addresses on pages allocated on the three relevant areas GFP_DMA,
GFP_DMA32, GFP_KERNEL:

- On an RPi4 with variations on the ram memory size. But also forcing
  the situation where all three memory zones are nonempty by setting a 3G
  ZONE_DMA32 ceiling on a 4G setup. Both with and without NUMA support.

- On a Synquacer box[1] with 32G of memory.

- On an ACPI based Huawei TaiShan server[2] with 256G of memory.

- On a QEMU virtual machine running arm64's OpenSUSE Tumbleweed.

That's all.

Regards,
Nicolas

[1] https://www.96boards.org/product/developerbox/
[2] https://e.huawei.com/en/products/cloud-computing-dc/servers/taishan-server/taishan-2280-v2

---

Changes in v2:
- More in depth testing.
- Create new global 'dma_zone_size'.
- New approach to getting the dma_zone_size, instead of parsing the dts
  we hardcode it conditionally to the machine compatible name.
- Fix ZONE_DMA and ZONE_DMA32 split, now ZONE_DMA32 remains empty if
  ZONE_DMA fits the whole 32 bit addressable space.
- Take into account devices with DMA offset.
- Rename new dma-direct variable to zone_dma_bits.
- Try new approach by merging both ZONE_DMA and ZONE_DMA32 comments
  in mmzone.h, add new up to date examples.

Nicolas Saenz Julienne (11):
  asm-generic: add dma_zone_size
  arm: use generic dma_zone_size
  of/fdt: add of_fdt_machine_is_compatible function
  of/fdt: add early_init_dt_get_dma_zone_size()
  arm64: mm: use arm64_dma_phys_limit instead of calling
    max_zone_dma_phys()
  arm64: rename variables used to calculate ZONE_DMA32's size
  arm64: re-introduce max_zone_dma_phys()
  arm64: use both ZONE_DMA and ZONE_DMA32
  dma-direct: turn ARCH_ZONE_DMA_BITS into a variable
  arm64: edit zone_dma_bits to fine tune dma-direct min mask
  mm: refresh ZONE_DMA and ZONE_DMA32 comments in 'enum zone_type'

 arch/arm/include/asm/dma.h      |  8 ++--
 arch/arm/mm/init.c              | 12 ++----
 arch/arm64/Kconfig              |  4 ++
 arch/arm64/mm/init.c            | 73 +++++++++++++++++++++++++--------
 arch/powerpc/include/asm/page.h |  9 ----
 arch/powerpc/mm/mem.c           | 16 +++++---
 arch/s390/include/asm/page.h    |  2 -
 arch/s390/mm/init.c             |  1 +
 drivers/of/fdt.c                | 15 +++++++
 include/asm-generic/dma.h       |  8 +++-
 include/linux/dma-direct.h      |  2 +
 include/linux/mmzone.h          | 46 ++++++++++++---------
 kernel/dma/direct.c             | 13 +++---
 mm/page_alloc.c                 |  3 ++
 14 files changed, 140 insertions(+), 72 deletions(-)

-- 
2.22.0

