Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347D876BBA4
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjHARtn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjHARtm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 13:49:42 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D37FE61;
        Tue,  1 Aug 2023 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690912175; x=1722448175;
  h=date:from:to:cc:subject:message-id;
  bh=+hiKzgVIdfd4Ul1Hh9n+HHx4lcITo+xaMCT5DwRKcdI=;
  b=DbgE+L+aSFuNbba4hCdg3L5E3LxJ7AuIkABL6fWSc+/V/pGv8kjpNi5/
   tvKBl7zDI+YXNU2mX3UaG5HP3MnFQkn4wK+QS1G9kgPM2FdGfO+amDYxz
   SyGYNZOICCs05rNl4qDLxNps4qYx9nxUZuKI6590ubxmdbNxguHv6jBwg
   M/XReCa6aPMGaOr2Iqgy38iSrMG+hsWTdz/OGFo9vdWhO8UNIgSZIxGra
   HuldsSwXAvARKqU+jXqr8VCs79AYI826xJbmZBSmXoq85kYVggxTvORXX
   SFYwpEn7dTf6RtMrLzuDnfk0gH46pxzTIeQBNOr5bkSEQdAwPyFX4tbip
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369368299"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="369368299"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794275606"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="794275606"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 10:49:32 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQtUx-0000UD-2k;
        Tue, 01 Aug 2023 17:49:31 +0000
Date:   Wed, 02 Aug 2023 01:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [linux-next:master] BUILD REGRESSION
 a734662572708cf062e974f659ae50c24fc1ad17
Message-ID: <202308020108.zBWJNwcE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: a734662572708cf062e974f659ae50c24fc1ad17  Add linux-next specific files for 20230801

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307251531.p8ZLFTMZ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308020154.Xrcb9bWT-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

../lib/gcc/loongarch64-linux/12.3.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
clang-16: error: unknown argument: '-msym32'
drivers/i2c/busses/i2c-virtio.c:270:3: error: field designator 'freeze' does not refer to any field in type 'struct virtio_driver'
drivers/i2c/busses/i2c-virtio.c:271:3: error: field designator 'restore' does not refer to any field in type 'struct virtio_driver'
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

sh4-linux-gcc: internal compiler error: Segmentation fault signal terminated program cc1
{standard input}: Warning: end of file not at end of a line; newline inserted
{standard input}:1095: Error: pcrel too far

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- loongarch-allmodconfig
|   `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
|-- sh-allmodconfig
|   |-- sh4-linux-gcc:internal-compiler-error:Segmentation-fault-signal-terminated-program-cc1
|   |-- standard-input:Error:pcrel-too-far
|   `-- standard-input:Warning:end-of-file-not-at-end-of-a-line-newline-inserted
`-- sh-randconfig-r023-20230731
    |-- include-asm-generic-io.h:error:redefinition-of-inb_p
    |-- include-asm-generic-io.h:error:redefinition-of-inl_p
    |-- include-asm-generic-io.h:error:redefinition-of-insb
    |-- include-asm-generic-io.h:error:redefinition-of-insl
    |-- include-asm-generic-io.h:error:redefinition-of-insw
    |-- include-asm-generic-io.h:error:redefinition-of-inw_p
    |-- include-asm-generic-io.h:error:redefinition-of-outb_p
    |-- include-asm-generic-io.h:error:redefinition-of-outl_p
    |-- include-asm-generic-io.h:error:redefinition-of-outsb
    |-- include-asm-generic-io.h:error:redefinition-of-outsl
    |-- include-asm-generic-io.h:error:redefinition-of-outsw
    |-- include-asm-generic-io.h:error:redefinition-of-outw_p
    |-- include-asm-generic-io.h:error:static-declaration-of-ioport_map-follows-non-static-declaration
    `-- include-asm-generic-io.h:error:static-declaration-of-ioport_unmap-follows-non-static-declaration
clang_recent_errors
|-- hexagon-allmodconfig
|   |-- drivers-i2c-busses-i2c-virtio.c:error:field-designator-freeze-does-not-refer-to-any-field-in-type-struct-virtio_driver
|   |-- drivers-i2c-busses-i2c-virtio.c:error:field-designator-restore-does-not-refer-to-any-field-in-type-struct-virtio_driver
|   `-- drivers-regulator-max77857-regulator.c:error:initializer-element-is-not-a-compile-time-constant
|-- hexagon-randconfig-r015-20230731
|   `-- drivers-regulator-max77857-regulator.c:error:initializer-element-is-not-a-compile-time-constant
|-- i386-randconfig-i012-20230731
|   |-- drivers-i2c-busses-i2c-virtio.c:error:field-designator-freeze-does-not-refer-to-any-field-in-type-struct-virtio_driver
|   `-- drivers-i2c-busses-i2c-virtio.c:error:field-designator-restore-does-not-refer-to-any-field-in-type-struct-virtio_driver
`-- mips-sb1250_swarm_defconfig
    `-- clang:error:unknown-argument:msym32

elapsed time: 725m

configs tested: 111
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230731   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230731   gcc  
arc                  randconfig-r033-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r046-20230731   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230731   gcc  
arm64                randconfig-r021-20230731   clang
csky                                defconfig   gcc  
hexagon              randconfig-r001-20230731   clang
hexagon              randconfig-r022-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230731   gcc  
m68k                 randconfig-r025-20230731   gcc  
microblaze           randconfig-r002-20230731   gcc  
microblaze           randconfig-r023-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                   sb1250_swarm_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230731   gcc  
nios2                randconfig-r035-20230731   gcc  
nios2                randconfig-r036-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230731   gcc  
parisc               randconfig-r031-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230731   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230731   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230731   gcc  
sparc                randconfig-r012-20230731   gcc  
sparc64              randconfig-r015-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
