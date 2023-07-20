Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C175B528
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jul 2023 19:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGTRDx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jul 2023 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGTRDw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jul 2023 13:03:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E8119;
        Thu, 20 Jul 2023 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689872631; x=1721408631;
  h=date:from:to:cc:subject:message-id;
  bh=al7Jq507xzKvQQBzMtR7HnB3N/JyApoMHZ77mE46uNc=;
  b=DPSLXfqNS0sPcu+LOQYVilytC/RgIv3kfk7Vuh6Tn/EzVWgPulvggoU6
   +UD7z5kb0AJcSrdo7cx5Fusp44jf843celZjnJqhGo27raZRXp6dRmqBu
   z4/2cr8ka12prnc06gln67xWCBQacBEjeTzmboKjQcn8be6nZ0oKV50kG
   QGrU9lhXVuRCKl/TslSD7EaUFcLoitK4N6Y+fVx+Rzvq0ksfjsLAL8dha
   Lt+KTTfdfQ03kQ1syp99vSXGs0yrrkGyDaggmYTUXOCI2V4+JJgQOaXyW
   yf55Gj8kezYMzjzbxQQ928sBIz1bjeDCz6+3zGrrGYnC3Npd4NQKjz8t5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351687799"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="351687799"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 10:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898379458"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="898379458"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 10:03:15 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMX3a-0006It-1J;
        Thu, 20 Jul 2023 17:03:14 +0000
Date:   Fri, 21 Jul 2023 01:02:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 c58c49dd89324b18a812762a2bfa5a0458e4f252
Message-ID: <202307210113.e8lkxP09-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: c58c49dd89324b18a812762a2bfa5a0458e4f252  Add linux-next specific files for 20230720

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307160328.P79qWZoB-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307181450.sfbuvMf5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307201439.A9MArfeq-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307202051.KikxDEX1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307210041.jT6femhS-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

../lib/gcc/loongarch64-linux/12.3.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]
drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not a compile-time constant
include/asm-generic/io.h:1137:20: error: static declaration of 'ioport_map' follows non-static declaration
include/asm-generic/io.h:1147:22: error: static declaration of 'ioport_unmap' follows non-static declaration
include/asm-generic/io.h:636:15: error: redefinition of 'inb_p'
include/asm-generic/io.h:644:15: error: redefinition of 'inw_p'
include/asm-generic/io.h:652:15: error: redefinition of 'inl_p'
include/asm-generic/io.h:660:16: error: redefinition of 'outb_p'
include/asm-generic/io.h:668:16: error: redefinition of 'outw_p'
include/asm-generic/io.h:676:16: error: redefinition of 'outl_p'
include/asm-generic/io.h:689:14: error: redefinition of 'insb'
include/asm-generic/io.h:697:14: error: redefinition of 'insw'
include/asm-generic/io.h:705:14: error: redefinition of 'insl'
include/asm-generic/io.h:713:15: error: redefinition of 'outsb'
include/asm-generic/io.h:722:15: error: redefinition of 'outsw'
include/asm-generic/io.h:731:15: error: redefinition of 'outsl'

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/gpu/drm/tests/drm_exec_test.c:137 test_prepare_array() error: uninitialized symbol 'ret'.
drivers/regulator/max77857-regulator.c:428:28: sparse: sparse: symbol 'max77857_id' was not declared. Should it be static?
drivers/regulator/max77857-regulator.c:446:19: sparse: sparse: symbol 'max77857_driver' was not declared. Should it be static?
drivers/regulator/max77857-regulator.c:70:22: sparse: sparse: symbol 'max77857_regmap_config' was not declared. Should it be static?
mm/khugepaged.c:2137 collapse_file() warn: variable dereferenced before check 'cc' (see line 1787)
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'
{standard input}:13: Error: symbol `__export_symbol_alpha_mv' is already defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r025-20230720
|   `-- standard-input:Error:symbol-__export_symbol_alpha_mv-is-already-defined
|-- arc-randconfig-r083-20230720
|   |-- drivers-gpu-drm-loongson-lsdc_benchmark.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-volatile-noderef-__iomem-addr-got-void-kptr
|   `-- drivers-gpu-drm-loongson-lsdc_benchmark.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-volatile-noderef-__iomem-addr-got-void-kptr
|-- arc-randconfig-r093-20230720
|   |-- drivers-iio-adc-max14001.c:sparse:sparse:incorrect-type-in-assignment-(different-base-types)-expected-restricted-__be16-usertype-spi_tx_buffer-got-int
|   `-- drivers-iio-adc-max14001.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-unsigned-short-usertype-__x-got-restricted-__be16-usertype
|-- arm-randconfig-r091-20230720
|   |-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_driver-was-not-declared.-Should-it-be-static
|   |-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_id-was-not-declared.-Should-it-be-static
|   `-- drivers-regulator-max77857-regulator.c:sparse:sparse:symbol-max77857_regmap_config-was-not-declared.-Should-it-be-static
|-- i386-randconfig-m021-20230720
|   `-- mm-khugepaged.c-collapse_file()-warn:variable-dereferenced-before-check-cc-(see-line-)
|-- loongarch-randconfig-r001-20230720
|   `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
|-- parisc-randconfig-m041-20230720
|   |-- drivers-gpu-drm-tests-drm_exec_test.c-test_prepare_array()-error:uninitialized-symbol-ret-.
|   |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
|   `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
|-- sh-randconfig-r083-20230720
|   |-- include-asm-generic-io.h:error:redefinition-of-inb_p
|   |-- include-asm-generic-io.h:error:redefinition-of-inl_p
|   |-- include-asm-generic-io.h:error:redefinition-of-insb
|   |-- include-asm-generic-io.h:error:redefinition-of-insl
|   |-- include-asm-generic-io.h:error:redefinition-of-insw
|   |-- include-asm-generic-io.h:error:redefinition-of-inw_p
|   |-- include-asm-generic-io.h:error:redefinition-of-outb_p
|   |-- include-asm-generic-io.h:error:redefinition-of-outl_p
|   |-- include-asm-generic-io.h:error:redefinition-of-outsb
|   |-- include-asm-generic-io.h:error:redefinition-of-outsl
|   |-- include-asm-generic-io.h:error:redefinition-of-outsw
|   |-- include-asm-generic-io.h:error:redefinition-of-outw_p
|   |-- include-asm-generic-io.h:error:static-declaration-of-ioport_map-follows-non-static-declaration
|   `-- include-asm-generic-io.h:error:static-declaration-of-ioport_unmap-follows-non-static-declaration
`-- x86_64-randconfig-m001-20230720
    `-- mm-khugepaged.c-collapse_file()-warn:variable-dereferenced-before-check-cc-(see-line-)
clang_recent_errors
|-- hexagon-randconfig-r004-20230720
|   `-- drivers-regulator-max77857-regulator.c:error:initializer-element-is-not-a-compile-time-constant
|-- hexagon-randconfig-r021-20230720
|   `-- drivers-regulator-max77857-regulator.c:error:initializer-element-is-not-a-compile-time-constant
`-- riscv-randconfig-r042-20230720
    `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void

elapsed time: 726m

configs tested: 110
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r022-20230720   gcc  
alpha                randconfig-r025-20230720   gcc  
alpha                randconfig-r031-20230720   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                  randconfig-r012-20230720   gcc  
arm                  randconfig-r034-20230720   clang
arm                  randconfig-r046-20230720   gcc  
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230720   gcc  
hexagon              randconfig-r004-20230720   clang
hexagon              randconfig-r021-20230720   clang
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
i386                 randconfig-r002-20230720   gcc  
i386                 randconfig-r011-20230720   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch            randconfig-r001-20230720   gcc  
loongarch            randconfig-r023-20230720   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r035-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230720   gcc  
nios2                randconfig-r013-20230720   gcc  
openrisc             randconfig-r003-20230720   gcc  
openrisc             randconfig-r006-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8555_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230720   clang
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r014-20230720   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r036-20230720   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
