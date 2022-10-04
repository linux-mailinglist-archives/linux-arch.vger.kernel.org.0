Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5ED5F3E7B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 10:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJDIhm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJDIhi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 04:37:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB3C3A163
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664872655; x=1696408655;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EWcRYckl7euNpC+KgvzYa43qqvZDtRN1y6CRGga7gM8=;
  b=ZnACa3OOQd5tLedR+rOSFzDqjsUapglIfv1JGt6IHGKLtL9TObLc28Xi
   M7QHrN28z6P+AOMttXgqJx49AXMToV4ksYE0NBQOdOICU86w0uou2LIuG
   trsH8vCpFWd4D6pLxgEOMiQIAhnszVaLo6skWkfr0KPz18Hh8XY3DJZ93
   RexVwiKIo4JM8LEuQxb6uBJZkLqqIcXpFgXHsmak+8tOgAX6+iMbjp577
   YzjUdYjbdP+E0Y1uDAGncvUckHZxDGiks06EOZkyx7WSdUMBiogNFtEdn
   p+jmwu2h5yjGBXnbgd/CPypwXCDLGRajtaupwgjxOi7pFZZ/oyrVyFYCJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300459933"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="300459933"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="952693372"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="952693372"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2022 01:37:33 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofdQj-000039-0J;
        Tue, 04 Oct 2022 08:37:33 +0000
Date:   Tue, 04 Oct 2022 16:36:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD REGRESSION
 52c747bd814f599ada7a6cdb38e282090629e64e
Message-ID: <633bf09f.7dy7D8PJfKuTK1SP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 52c747bd814f599ada7a6cdb38e282090629e64e  alpha: add full ioread64/iowrite64 implementation

Error/Warning reports:

https://lore.kernel.org/linux-arch/202210040004.JSEtm9uf-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread64' [-Wmissing-prototypes]
arch/alpha/include/asm/core_t2.h:594:22: warning: no previous prototype for 't2_iowrite64' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:187:21: warning: no previous prototype for 'jensen_inq' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:207:22: warning: no previous prototype for 'jensen_outq' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread64' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite64' [-Wmissing-prototypes]
arch/alpha/kernel/core_marvel.c:807:1: error: conflicting types for 'marvel_ioread8'; have 'unsigned int(const void *)'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   `-- arch-alpha-kernel-core_marvel.c:error:conflicting-types-for-marvel_ioread8-have-unsigned-int(const-void-)
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_ioread64
|   |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_iowrite64
|   |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_inq
|   |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_ioread64
|   |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_iowrite64
|   `-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_outq
`-- alpha-defconfig
    |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_ioread64
    |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_iowrite64
    |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_inq
    |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_ioread64
    |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_iowrite64
    `-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_outq

elapsed time: 724m

configs tested: 88
configs skipped: 3

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
x86_64                              defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a016-20221003
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
s390                                defconfig
i386                 randconfig-a014-20221003
x86_64               randconfig-a011-20221003
i386                 randconfig-a011-20221003
s390                             allmodconfig
arm                                 defconfig
i386                 randconfig-a012-20221003
x86_64               randconfig-a012-20221003
i386                 randconfig-a013-20221003
x86_64               randconfig-a013-20221003
powerpc                           allnoconfig
x86_64               randconfig-a016-20221003
powerpc                          allmodconfig
i386                             allyesconfig
s390                 randconfig-r044-20221003
m68k                             allmodconfig
s390                             allyesconfig
arc                              allyesconfig
mips                             allyesconfig
i386                 randconfig-a015-20221003
sh                               allmodconfig
x86_64                           allyesconfig
x86_64               randconfig-a015-20221003
alpha                            allyesconfig
x86_64               randconfig-a014-20221003
riscv                randconfig-r042-20221003
m68k                             allyesconfig
arc                  randconfig-r043-20221003
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20221002
ia64                             allmodconfig
arm                        realview_defconfig
xtensa                           alldefconfig
sh                          kfr2r09_defconfig
arm                          exynos_defconfig
sh                           se7619_defconfig
m68k                          sun3x_defconfig
powerpc                     tqm8548_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                      mgcoge_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     mpc83xx_defconfig
sh                      rts7751r2d1_defconfig
nios2                               defconfig
m68k                          amiga_defconfig
arc                            hsdk_defconfig
loongarch                 loongson3_defconfig
powerpc                      cm5200_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221002
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a004-20221003
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
