Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6615E59C4DF
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiHVRRA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiHVRQ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 13:16:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9FB240B4;
        Mon, 22 Aug 2022 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661188618; x=1692724618;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3bjX4Nqvr1niq4WhvJ4vndYQsekMu1imibjNM0OeL9c=;
  b=G7gPaerAiZ7pY8HluamIEWPfsBIsB/ljNgiiu2pwPaWaw5am0SrFA7H3
   CnhjnNkztPrUkxXXr2V6jH8qMcgtaHrAGUhiqTqEw85imXqDLOFJ9SPa8
   iZjB55BVqpozBsLXbSz40poJYaB+TK7DpmZmbbAIhGH/pbt4vrjGoUSt3
   KtHQgDmwLIDTk3+F0bYzJBXGp32KneymFvitSci3550zfvdoAbi6Vxmh7
   pSjSsuUMokHoC6V/p7deiC3lQ1A8uNdsr48p2kUFpAJe/XD0CmR7mhm7u
   stJ9Pl0fGWWnTj+ja/f81JC3m9Cum3hCt0YVXpAS8czXljGg89H5rbJjv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294262594"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294262594"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 10:16:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="585608200"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2022 10:16:55 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQB2l-0000Vn-0g;
        Mon, 22 Aug 2022 17:16:55 +0000
Date:   Tue, 23 Aug 2022 01:16:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sound-open-firmware@alsa-project.org,
        platform-driver-x86@vger.kernel.org, linux-arch@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 cc2986f4dc67df7e6209e0cd74145fffbd30d693
Message-ID: <6303b9e7.XfUgtQTlIdzz7vPk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: cc2986f4dc67df7e6209e0cd74145fffbd30d693  Add linux-next specific files for 20220822

Error/Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regmap-mmio.c:221:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:224:17: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:227:17: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writeq'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writesl'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:358:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:361:17: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:364:17: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readq'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readsl'? [-Werror=implicit-function-declaration]
drivers/platform/mellanox/mlxreg-lc.c:866 mlxreg_lc_probe() warn: passing zero to 'PTR_ERR'
sound/soc/sof/compress.c:330:13: warning: variable 'dai_posn' set but not used [-Wunused-but-set-variable]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- alpha-allyesconfig
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|   `-- sound-soc-sof-compress.c:warning:variable-dai_posn-set-but-not-used
|-- alpha-buildonly-randconfig-r001-20220822
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- alpha-buildonly-randconfig-r006-20220821
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- alpha-randconfig-r031-20220822
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- arc-allyesconfig
|   `-- sound-soc-sof-compress.c:warning:variable-dai_posn-set-but-not-used
|-- arm-allyesconfig
|   `-- sound-soc-sof-compress.c:warning:variable-dai_posn-set-but-not-used
clang_recent_errors
|-- hexagon-randconfig-r001-20220821
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insb
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insl
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insw
|   |-- include-asm-generic-io.h:error:conflicting-types-for-memcpy_fromio
|   |-- include-asm-generic-io.h:error:conflicting-types-for-memcpy_toio
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsb
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsl
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsw
|   |-- include-asm-generic-io.h:error:redefinition-of-memset_io
|   |-- include-asm-generic-io.h:error:redefinition-of-phys_to_virt
|   |-- include-asm-generic-io.h:error:redefinition-of-readb
|   |-- include-asm-generic-io.h:error:redefinition-of-readl
|   |-- include-asm-generic-io.h:error:redefinition-of-readw
|   |-- include-asm-generic-io.h:error:redefinition-of-virt_to_phys
|   |-- include-asm-generic-io.h:error:redefinition-of-writeb
|   |-- include-asm-generic-io.h:error:redefinition-of-writel
|   `-- include-asm-generic-io.h:error:redefinition-of-writew
|-- hexagon-randconfig-r004-20220822
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insb
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insl
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insw
|   |-- include-asm-generic-io.h:error:conflicting-types-for-memcpy_fromio
|   |-- include-asm-generic-io.h:error:conflicting-types-for-memcpy_toio
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsb
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsl
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsw
|   |-- include-asm-generic-io.h:error:redefinition-of-memset_io
|   |-- include-asm-generic-io.h:error:redefinition-of-phys_to_virt
|   |-- include-asm-generic-io.h:error:redefinition-of-readb
|   |-- include-asm-generic-io.h:error:redefinition-of-readl
|   |-- include-asm-generic-io.h:error:redefinition-of-readw
|   |-- include-asm-generic-io.h:error:redefinition-of-virt_to_phys
|   |-- include-asm-generic-io.h:error:redefinition-of-writeb
|   |-- include-asm-generic-io.h:error:redefinition-of-writel
|   `-- include-asm-generic-io.h:error:redefinition-of-writew
|-- hexagon-randconfig-r032-20220821
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insb
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insl
|   |-- include-asm-generic-io.h:error:conflicting-types-for-insw
|   |-- include-asm-generic-io.h:error:conflicting-types-for-memcpy_fromio
|   |-- include-asm-generic-io.h:error:conflicting-types-for-memcpy_toio
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsb
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsl
|   |-- include-asm-generic-io.h:error:conflicting-types-for-outsw
|   |-- include-asm-generic-io.h:error:redefinition-of-memset_io
|   |-- include-asm-generic-io.h:error:redefinition-of-phys_to_virt
|   |-- include-asm-generic-io.h:error:redefinition-of-readb
|   |-- include-asm-generic-io.h:error:redefinition-of-readl
|   |-- include-asm-generic-io.h:error:redefinition-of-readw

elapsed time: 721m

configs tested: 76
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-a012-20220822
x86_64               randconfig-a013-20220822
x86_64               randconfig-a011-20220822
i386                 randconfig-a014-20220822
x86_64                              defconfig
i386                 randconfig-a013-20220822
i386                 randconfig-a011-20220822
csky                              allnoconfig
x86_64               randconfig-a016-20220822
arc                               allnoconfig
x86_64               randconfig-a014-20220822
i386                 randconfig-a012-20220822
alpha                             allnoconfig
x86_64               randconfig-a015-20220822
i386                                defconfig
i386                 randconfig-a016-20220822
x86_64                               rhel-8.3
arm                                 defconfig
riscv                             allnoconfig
arc                  randconfig-r043-20220821
arm                           sama5_defconfig
mips                           jazz_defconfig
x86_64                           allyesconfig
i386                 randconfig-a015-20220822
powerpc                           allnoconfig
alpha                            allyesconfig
m68k                         apollo_defconfig
arc                  randconfig-r043-20220822
m68k                             allmodconfig
arc                              allyesconfig
arm                            lart_defconfig
riscv                randconfig-r042-20220822
sh                           se7724_defconfig
m68k                       m5275evb_defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20220822
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                           rhel-8.3-syz
mips                             allyesconfig
sh                   sh7770_generic_defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
m68k                             allyesconfig

clang tested configs:
i386                 randconfig-a001-20220822
i386                 randconfig-a002-20220822
i386                 randconfig-a003-20220822
i386                 randconfig-a005-20220822
i386                 randconfig-a004-20220822
i386                 randconfig-a006-20220822
x86_64               randconfig-a002-20220822
x86_64               randconfig-a004-20220822
hexagon              randconfig-r041-20220822
arm                        neponset_defconfig
powerpc                      katmai_defconfig
x86_64               randconfig-a003-20220822
mips                      maltaaprp_defconfig
x86_64               randconfig-a001-20220822
x86_64               randconfig-a006-20220822
x86_64               randconfig-a005-20220822
hexagon              randconfig-r045-20220822
hexagon              randconfig-r045-20220821
hexagon              randconfig-r041-20220821
s390                 randconfig-r044-20220821
riscv                randconfig-r042-20220821
mips                        bcm63xx_defconfig
powerpc                    socrates_defconfig
powerpc                     powernv_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
