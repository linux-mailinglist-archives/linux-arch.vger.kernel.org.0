Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42E76A700C
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 16:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCAPp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 10:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAPp3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 10:45:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3A113E1;
        Wed,  1 Mar 2023 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677685527; x=1709221527;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pbp3V9v3IHoln3VTxeY5EiT636+2yaIZ+8lKQgynV7M=;
  b=I6IpOOPfupzTlvckSIJssDA8Gc7sjzokRw+C5TSENiNm97gpLXMSLvqG
   1vS1h06ThFGvu4yqsk94Kv2/xxSXu/bT/b3cGKRJqkeR8XD+3t6ziSQCu
   NaEbD3CXXX/T2SjAqyEdKzJhGYEJX8VD4t81zvV9sYVvfpPbnm3OZIwMv
   d7/4RAR9Azyp9KbrZn9fU7BYEUUr9M1yRAOIE56/0ZpMeY0IKv9xOLhUb
   D6TCWKUIg546HBkR/Qtr2IItSCOE4BVNffMh/mvkBIjUv5IQqi/qDTStU
   egAqxNR3TuWDHoyQq9v7mlSICcXRiQ2bgzHNJk1PDHwkb5sr1CTbJsnsq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362022171"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="362022171"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:45:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738682476"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738682476"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 07:45:22 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXOdu-0006Fj-0Q;
        Wed, 01 Mar 2023 15:45:22 +0000
Date:   Wed, 01 Mar 2023 23:44:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     loongarch@lists.linux.dev, linux-watchdog@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, asahi@lists.linux.dev,
        amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 1716a175592aff9549a0c07aac8f9cadd03003f5
Message-ID: <63ff72ed.GV64WhqVJwrx6pJw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 1716a175592aff9549a0c07aac8f9cadd03003f5  Add linux-next specific files for 20230301

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302111601.jtY4lKrA-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302201555.OI4N54jb-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302210350.lynWcL4t-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202303011456.WEPeM0ZN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

FAILED: load BTF from vmlinux: No data available
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.c:294:6: warning: no previous prototype for 'optc3_wait_drr_doublebuffer_pending_clear' [-Wmissing-prototypes]
idma64.c:(.text+0x145a): undefined reference to `devm_platform_ioremap_resource'
include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/loongarch/include/asm/loongarch.h:226:9: sparse: sparse: too many errors
drivers/iommu/apple-dart.c:1281:1: sparse: sparse: symbol 'apple_dart_pm_ops' was not declared. Should it be static?
drivers/usb/gadget/composite.c:2082:33: sparse: sparse: restricted __le16 degrades to integer
drivers/watchdog/imx2_wdt.c:442:22: sparse: sparse: symbol 'imx_wdt' was not declared. Should it be static?
drivers/watchdog/imx2_wdt.c:446:22: sparse: sparse: symbol 'imx_wdt_legacy' was not declared. Should it be static?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- arc-randconfig-r001-20230226
|   `-- FAILED:load-BTF-from-vmlinux:No-data-available
|-- arm-allmodconfig
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- arm-allyesconfig
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- arm64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- arm64-randconfig-r025-20230227
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- i386-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
|-- i386-randconfig-s001
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- i386-randconfig-s003
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- loongarch-randconfig-s041-20230226
|   |-- arch-loongarch-include-asm-loongarch.h:sparse:sparse:too-many-errors
|   |-- arch-loongarch-kernel-relocate.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-char-cmdline-got-void-noderef-__iomem
|   |-- drivers-iommu-apple-dart.c:sparse:sparse:symbol-apple_dart_pm_ops-was-not-declared.-Should-it-be-static
|   |-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt-was-not-declared.-Should-it-be-static
|   `-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt_legacy-was-not-declared.-Should-it-be-static
|-- loongarch-randconfig-s053-20230226
|   |-- arch-loongarch-kernel-relocate.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-char-cmdline-got-void-noderef-__iomem
|   |-- drivers-iommu-apple-dart.c:sparse:sparse:symbol-apple_dart_pm_ops-was-not-declared.-Should-it-be-static
|   `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|-- mips-randconfig-s051-20230226
|   |-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer
|   |-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt-was-not-declared.-Should-it-be-static
|   `-- drivers-watchdog-imx2_wdt.c:sparse:sparse:symbol-imx_wdt_legacy-was-not-declared.-Should-it-be-static
|-- nios2-allyesconfig
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- powerpc-allmodconfig
|   `-- include-asm-generic-div64.h:error:passing-argument-of-__div64_32-from-incompatible-pointer-type
|-- s390-randconfig-s033-20230226
|   `-- idma64.c:(.text):undefined-reference-to-devm_platform_ioremap_resource
|-- x86_64-allnoconfig
|   `-- Warning:Documentation-devicetree-bindings-usb-rockchip-dwc3.yaml-references-a-file-that-doesn-t-exist:Documentation-devicetree-bindings-phy-phy-rockchip-inno-usb2.yaml
|-- x86_64-allyesconfig
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-dcn30-dcn30_optc.c:warning:no-previous-prototype-for-optc3_wait_drr_doublebuffer_pending_clear
`-- x86_64-randconfig-s021
    `-- drivers-usb-gadget-composite.c:sparse:sparse:restricted-__le16-degrades-to-integer

elapsed time: 866m

configs tested: 179
configs skipped: 11

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230227   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230227   gcc  
alpha                randconfig-r026-20230227   gcc  
alpha                randconfig-r031-20230228   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230226   gcc  
arc                  randconfig-r015-20230226   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm          buildonly-randconfig-r005-20230227   clang
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                  randconfig-c002-20230226   gcc  
arm                  randconfig-r012-20230226   gcc  
arm                  randconfig-r035-20230226   clang
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230227   clang
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230227   gcc  
arm64                randconfig-r036-20230228   gcc  
csky         buildonly-randconfig-r003-20230227   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r001-20230226   clang
hexagon              randconfig-r015-20230228   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                 randconfig-a002-20230227   clang
i386                 randconfig-a003-20230227   clang
i386                 randconfig-a004-20230227   clang
i386                 randconfig-a005-20230227   clang
i386                 randconfig-a006-20230227   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230226   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230228   gcc  
ia64                 randconfig-r021-20230227   gcc  
ia64                 randconfig-r025-20230226   gcc  
ia64                 randconfig-r031-20230227   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230226   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230227   gcc  
loongarch            randconfig-r011-20230228   gcc  
loongarch            randconfig-r036-20230227   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r003-20230226   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230227   gcc  
m68k                 randconfig-r016-20230227   gcc  
m68k                 randconfig-r034-20230228   gcc  
microblaze   buildonly-randconfig-r006-20230227   gcc  
microblaze           randconfig-r004-20230227   gcc  
microblaze           randconfig-r011-20230226   gcc  
microblaze           randconfig-r014-20230228   gcc  
microblaze           randconfig-r023-20230227   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           ci20_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                 randconfig-r012-20230227   clang
mips                 randconfig-r035-20230227   gcc  
mips                           rs90_defconfig   clang
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230227   gcc  
openrisc     buildonly-randconfig-r002-20230227   gcc  
openrisc             randconfig-r012-20230228   gcc  
openrisc             randconfig-r014-20230226   gcc  
openrisc             randconfig-r016-20230226   gcc  
openrisc             randconfig-r031-20230226   gcc  
openrisc             randconfig-r034-20230227   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r033-20230226   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230226   clang
riscv                               defconfig   gcc  
riscv                randconfig-r024-20230226   clang
riscv                randconfig-r036-20230226   gcc  
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230226   gcc  
s390                 randconfig-r013-20230226   clang
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                   randconfig-r033-20230227   gcc  
sh                             sh03_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230227   gcc  
sparc                randconfig-r005-20230226   gcc  
sparc                randconfig-r013-20230227   gcc  
sparc                randconfig-r015-20230227   gcc  
sparc                randconfig-r022-20230227   gcc  
sparc                randconfig-r032-20230227   gcc  
sparc64      buildonly-randconfig-r004-20230226   gcc  
sparc64              randconfig-r033-20230228   gcc  
sparc64              randconfig-r035-20230228   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64                        randconfig-c001   gcc  
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230227   gcc  
xtensa               randconfig-r003-20230226   gcc  
xtensa               randconfig-r004-20230226   gcc  
xtensa               randconfig-r016-20230228   gcc  
xtensa               randconfig-r023-20230226   gcc  
xtensa               randconfig-r032-20230226   gcc  
xtensa               randconfig-r032-20230228   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
