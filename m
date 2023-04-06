Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF326D91BD
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 10:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjDFIe5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 04:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjDFIe4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 04:34:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21F5133
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680770094; x=1712306094;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cxvafbVNYQ061kXmxBXN7uUl3kJbTM9Dp3HlzYWqsI0=;
  b=SRdkFewUORJPZdvfgkgPdgoVStfChO//mjxfq8k64vAQfeujuJZFbYhD
   dXztBygLBjGWkJcxFoyrES/Ktegyf5xuTMQxkG7tnKJ1ZnP/aixpzACbZ
   f4kmrKGWZW68mfi1dE1PG0dRP0Y6wD00AZP3NhpvEJ+I2lqW5qVHXa9GH
   FzGYjZQwr/I4s3e1WGWLmGPmrZUrcI3ERw4IHtflfTdheIJuUdJCGDRi1
   ieBU0joOzdCf8nKu2d2+fuioCAD1PkiRzNr8sCCi6Sp3hSJWFtqSkK+7m
   vzLmGwx3cLGiZkOP0t1XhMc91Nwxev34UFzKtRk3GALscaNpnVaZkI5sK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="340172622"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="340172622"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 01:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="680587004"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="680587004"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Apr 2023 01:34:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkL4u-000RDe-0b;
        Thu, 06 Apr 2023 08:34:44 +0000
Date:   Thu, 06 Apr 2023 16:33:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 5e98654e30e18bb33d21b773b75fd68fcf673bae
Message-ID: <642e83f0.igwJXaRLtUPM+iQb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 5e98654e30e18bb33d21b773b75fd68fcf673bae  Merge branch 'asm-generic-fixes' into asm-generic

elapsed time: 727m

configs tested: 244
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r003-20230405   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r016-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r006-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arc                  randconfig-r043-20230404   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r031-20230403   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r035-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm                  randconfig-r046-20230404   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230404   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230403   clang
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r021-20230403   gcc  
arm64                randconfig-r026-20230405   gcc  
arm64                randconfig-r035-20230403   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230405   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r012-20230403   gcc  
csky                 randconfig-r032-20230405   gcc  
csky                 randconfig-r035-20230403   gcc  
csky                 randconfig-r035-20230405   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon      buildonly-randconfig-r003-20230404   clang
hexagon      buildonly-randconfig-r004-20230404   clang
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230404   clang
hexagon              randconfig-r041-20230406   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230404   clang
hexagon              randconfig-r045-20230406   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230403   clang
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r016-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230403   gcc  
ia64         buildonly-randconfig-r002-20230403   gcc  
ia64         buildonly-randconfig-r004-20230404   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230406   gcc  
ia64                 randconfig-r024-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230405   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r023-20230405   gcc  
loongarch            randconfig-r026-20230403   gcc  
loongarch            randconfig-r031-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230406   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r021-20230405   gcc  
m68k                 randconfig-r024-20230403   gcc  
m68k                 randconfig-r031-20230405   gcc  
microblaze   buildonly-randconfig-r002-20230404   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips         buildonly-randconfig-r005-20230403   gcc  
mips                 randconfig-r004-20230403   gcc  
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r026-20230403   clang
mips                 randconfig-r033-20230405   gcc  
nios2        buildonly-randconfig-r003-20230403   gcc  
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230406   gcc  
nios2                randconfig-r032-20230403   gcc  
openrisc     buildonly-randconfig-r005-20230404   gcc  
openrisc     buildonly-randconfig-r006-20230403   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230405   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r022-20230403   gcc  
openrisc             randconfig-r026-20230403   gcc  
openrisc             randconfig-r034-20230403   gcc  
openrisc             randconfig-r034-20230405   gcc  
openrisc                 simple_smp_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r006-20230403   clang
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r015-20230403   gcc  
powerpc              randconfig-r025-20230403   gcc  
powerpc              randconfig-r036-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230403   clang
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r013-20230403   gcc  
riscv                randconfig-r014-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230404   clang
riscv                randconfig-r042-20230406   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230404   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230403   clang
s390                 randconfig-r005-20230406   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230404   clang
s390                 randconfig-r044-20230406   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230403   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r002-20230406   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r005-20230405   gcc  
sh                   randconfig-r025-20230405   gcc  
sh                   randconfig-r026-20230403   gcc  
sh                   randconfig-r034-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230404   gcc  
sparc        buildonly-randconfig-r006-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r021-20230403   gcc  
sparc                randconfig-r024-20230403   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r002-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230405   gcc  
sparc64              randconfig-r004-20230406   gcc  
sparc64              randconfig-r005-20230403   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
sparc64              randconfig-r024-20230403   gcc  
sparc64              randconfig-r026-20230403   gcc  
sparc64              randconfig-r031-20230403   gcc  
sparc64              randconfig-r033-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230403   clang
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230403   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230403   clang
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230403   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230403   clang
x86_64                        randconfig-a006   gcc  
x86_64               randconfig-a011-20230403   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r012-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230403   gcc  
xtensa       buildonly-randconfig-r003-20230403   gcc  
xtensa       buildonly-randconfig-r004-20230403   gcc  
xtensa               randconfig-r001-20230403   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r033-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
