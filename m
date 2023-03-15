Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E66BAF43
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjCOLb5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjCOLbp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EAF64849;
        Wed, 15 Mar 2023 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879904; x=1710415904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=emKW1DsDd6J7BoaliTpiqaTlAsPQ1Xr/3FNEg+io6NQ=;
  b=YBQo49A55PKeoUSU5BCFs2agz8PmUVtJt+YZOEMAV1NMkBxtToYRazVt
   AjDCbSdgAmSN7D5bJ5pD2S6CIOUJiHmluUnsrXOzm5BA4RdYyuF0Bq1YX
   nFJR3h6ZfsZQyXG6LFqv/Qo8C8SBqjHCfPIadtNiIUdQWHLtrXsRZqmoo
   vl8+VtnTak+6fzh0WqvKVMahp1Obxqdcsvy5BrWjrbT88csIPqfYpTB5Q
   1yOJ2CCVvjqMYd4ATlxJTyQhLOpqbU77U4u/om5trkG3oB0lK52VH7PLK
   4zmsCy11YVDQ7iRTtFEL9o7ud4iDKpU8uedSSGuiPcnfyaBlM1ApDC3I2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340040093"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340040093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768455999"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768455999"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A507B10CC9C; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 00/10] Fix confusion around MAX_ORDER
Date:   Wed, 15 Mar 2023 14:31:23 +0300
Message-Id: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MAX_ORDER currently defined as number of orders page allocator supports:
user can ask buddy allocator for page order between 0 and MAX_ORDER-1.

This definition is counter-intuitive and lead to number of bugs all over
the kernel.

Fix the bugs and then change the definition of MAX_ORDER to be
inclusive: the range of orders user can ask from buddy allocator is
0..MAX_ORDER now.

Kirill A. Shutemov (10):
  sparc/mm: Fix MAX_ORDER usage in tsb_grow()
  um: Fix MAX_ORDER usage in linux_main()
  floppy: Fix MAX_ORDER usage
  drm/i915: Fix MAX_ORDER usage in i915_gem_object_get_pages_internal()
  genwqe: Fix MAX_ORDER usage
  perf/core: Fix MAX_ORDER usage in rb_alloc_aux_page()
  mm/page_reporting: Fix MAX_ORDER usage in page_reporting_register()
  mm/slub: Fix MAX_ORDER usage in calculate_order()
  iommu: Fix MAX_ORDER usage in __iommu_dma_alloc_pages()
  mm, treewide: Redefine MAX_ORDER sanely

 .../admin-guide/kdump/vmcoreinfo.rst          |  2 +-
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/arc/Kconfig                              |  4 +-
 arch/arm/Kconfig                              |  9 ++---
 arch/arm/configs/imx_v6_v7_defconfig          |  2 +-
 arch/arm/configs/milbeaut_m10v_defconfig      |  2 +-
 arch/arm/configs/oxnas_v6_defconfig           |  2 +-
 arch/arm/configs/pxa_defconfig                |  2 +-
 arch/arm/configs/sama7_defconfig              |  2 +-
 arch/arm/configs/sp7021_defconfig             |  2 +-
 arch/arm64/Kconfig                            | 27 ++++++-------
 arch/arm64/include/asm/sparsemem.h            |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 10 ++---
 arch/csky/Kconfig                             |  2 +-
 arch/ia64/Kconfig                             |  8 ++--
 arch/ia64/include/asm/sparsemem.h             |  4 +-
 arch/ia64/mm/hugetlbpage.c                    |  2 +-
 arch/loongarch/Kconfig                        | 15 +++-----
 arch/m68k/Kconfig.cpu                         |  5 +--
 arch/mips/Kconfig                             | 19 ++++------
 arch/nios2/Kconfig                            |  7 +---
 arch/powerpc/Kconfig                          | 27 ++++++-------
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |  2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config     |  2 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |  2 +-
 arch/powerpc/mm/hugetlbpage.c                 |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     |  2 +-
 arch/sh/configs/ecovec24_defconfig            |  2 +-
 arch/sh/mm/Kconfig                            | 17 ++++-----
 arch/sparc/Kconfig                            |  5 +--
 arch/sparc/kernel/pci_sun4v.c                 |  2 +-
 arch/sparc/kernel/traps_64.c                  |  2 +-
 arch/sparc/mm/tsb.c                           |  4 +-
 arch/xtensa/Kconfig                           |  5 +--
 drivers/base/regmap/regmap-debugfs.c          |  8 ++--
 drivers/block/floppy.c                        |  2 +-
 drivers/crypto/ccp/sev-dev.c                  |  2 +-
 drivers/crypto/hisilicon/sgl.c                |  6 +--
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                | 22 +++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 drivers/iommu/dma-iommu.c                     |  4 +-
 drivers/irqchip/irq-gic-v3-its.c              |  4 +-
 drivers/md/dm-bufio.c                         |  2 +-
 drivers/misc/genwqe/card_utils.c              |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
 drivers/video/fbdev/hyperv_fb.c               |  4 +-
 drivers/video/fbdev/vermilion/vermilion.c     |  2 +-
 drivers/virtio/virtio_balloon.c               |  2 +-
 drivers/virtio/virtio_mem.c                   | 12 +++---
 fs/ramfs/file-nommu.c                         |  2 +-
 include/drm/ttm/ttm_pool.h                    |  2 +-
 include/linux/hugetlb.h                       |  2 +-
 include/linux/mmzone.h                        | 10 ++---
 include/linux/pageblock-flags.h               |  4 +-
 include/linux/slab.h                          |  6 +--
 kernel/crash_core.c                           |  2 +-
 kernel/dma/pool.c                             |  6 +--
 mm/Kconfig                                    |  6 +--
 mm/compaction.c                               |  8 ++--
 mm/debug_vm_pgtable.c                         |  4 +-
 mm/huge_memory.c                              |  2 +-
 mm/hugetlb.c                                  |  4 +-
 mm/kmsan/init.c                               |  6 +--
 mm/memblock.c                                 |  2 +-
 mm/memory_hotplug.c                           |  4 +-
 mm/page_alloc.c                               | 38 +++++++++----------
 mm/page_isolation.c                           | 12 +++---
 mm/page_owner.c                               |  6 +--
 mm/page_reporting.c                           |  4 +-
 mm/shuffle.h                                  |  2 +-
 mm/slab.c                                     |  2 +-
 mm/slub.c                                     |  4 +-
 mm/vmscan.c                                   |  2 +-
 mm/vmstat.c                                   | 14 +++----
 net/smc/smc_ib.c                              |  2 +-
 security/integrity/ima/ima_crypto.c           |  2 +-
 tools/testing/memblock/linux/mmzone.h         |  6 +--
 80 files changed, 210 insertions(+), 240 deletions(-)

-- 
2.39.2

