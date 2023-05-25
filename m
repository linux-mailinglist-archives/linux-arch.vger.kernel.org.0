Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAB710852
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbjEYJIs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbjEYJIo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 05:08:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE71A7
        for <linux-arch@vger.kernel.org>; Thu, 25 May 2023 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685005722; x=1716541722;
  h=date:from:to:cc:subject:message-id;
  bh=RXS5DZj5Go9OG8ULY4lSUAPQxC+qt7gNj5RaCh0LmLA=;
  b=JKB5C0mdpFv9qRkkVBvl4rnmTl+Fz0x36ia11YQVXxlBVbTYuMQMMZ/r
   yEYnM6GmE60eSc2BpbmgYWFLulALaEmm1Osc21VffLtsx9o4t3OmQiwEc
   CQaVtBj/Nuci85wDdDbsdzg2sPBJi3Bci6regrtVekqCiZY7YhE7ssdrU
   e5Z2BsGoUf3qV1T07PCm1hjtQBE+9frgGztXLwGpVEhntet1uxCt5SJ3b
   IIViTkZf5fspfXBkeaSoRnWm1LtsM2JavYb0WC97LwPw2qKRaYkvLuR6j
   1VKW95fTW4tH/ILKrgc8kVk2SdG62Rk0/prN/wPeJ/jR5woG46E1jjyMA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="353857541"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="353857541"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 02:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951376577"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="951376577"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2023 02:08:40 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q26xb-000Fct-2k;
        Thu, 25 May 2023 09:08:39 +0000
Date:   Thu, 25 May 2023 17:07:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 6e542e9820c2645ff8db1eb2b8d61fb25fd89174
Message-ID: <20230525090745.pREmv%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 6e542e9820c2645ff8db1eb2b8d61fb25fd89174  Merge tag 'virt-to-pfn-for-arch-v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into asm-generic

elapsed time: 1176m

configs tested: 232
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230524   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230524   gcc  
alpha                randconfig-r005-20230524   gcc  
alpha                randconfig-r015-20230524   gcc  
alpha                randconfig-r034-20230524   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc          buildonly-randconfig-r001-20230524   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230524   gcc  
arc                  randconfig-r014-20230524   gcc  
arc                  randconfig-r015-20230524   gcc  
arc                  randconfig-r031-20230525   gcc  
arc                  randconfig-r032-20230524   gcc  
arc                  randconfig-r043-20230524   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230524   clang
arm                  randconfig-r031-20230524   clang
arm                  randconfig-r046-20230524   gcc  
arm                         s5pv210_defconfig   clang
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230524   gcc  
arm64                randconfig-r006-20230524   gcc  
arm64                randconfig-r011-20230524   clang
arm64                randconfig-r023-20230524   clang
arm64                randconfig-r032-20230524   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230524   gcc  
csky                 randconfig-r004-20230524   gcc  
csky                 randconfig-r013-20230524   gcc  
hexagon      buildonly-randconfig-r004-20230524   clang
hexagon              randconfig-r041-20230524   clang
hexagon              randconfig-r045-20230524   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230524   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230524   gcc  
i386                 randconfig-i002-20230524   gcc  
i386                 randconfig-i003-20230524   gcc  
i386                 randconfig-i004-20230524   gcc  
i386                 randconfig-i005-20230524   gcc  
i386                 randconfig-i006-20230524   gcc  
i386                 randconfig-i011-20230524   clang
i386                 randconfig-i012-20230524   clang
i386                 randconfig-i013-20230524   clang
i386                 randconfig-i014-20230524   clang
i386                 randconfig-i015-20230524   clang
i386                 randconfig-i016-20230524   clang
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i055-20230524   gcc  
i386                 randconfig-i056-20230524   gcc  
i386                 randconfig-i061-20230524   gcc  
i386                 randconfig-i062-20230524   gcc  
i386                 randconfig-i063-20230524   gcc  
i386                 randconfig-i064-20230524   gcc  
i386                 randconfig-i065-20230524   gcc  
i386                 randconfig-i066-20230524   gcc  
i386                 randconfig-i071-20230524   clang
i386                 randconfig-i072-20230524   clang
i386                 randconfig-i073-20230524   clang
i386                 randconfig-i074-20230524   clang
i386                 randconfig-i075-20230524   clang
i386                 randconfig-i076-20230524   clang
i386                 randconfig-i081-20230524   clang
i386                 randconfig-i082-20230524   clang
i386                 randconfig-i083-20230524   clang
i386                 randconfig-i084-20230524   clang
i386                 randconfig-i085-20230524   clang
i386                 randconfig-i086-20230524   clang
i386                 randconfig-i091-20230524   gcc  
i386                 randconfig-i092-20230524   gcc  
i386                 randconfig-i093-20230524   gcc  
i386                 randconfig-i094-20230524   gcc  
i386                 randconfig-i095-20230524   gcc  
i386                 randconfig-i096-20230524   gcc  
i386                 randconfig-r005-20230524   gcc  
i386                 randconfig-r024-20230524   clang
i386                 randconfig-r025-20230524   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230524   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230524   gcc  
ia64                 randconfig-r022-20230525   gcc  
ia64                 randconfig-r035-20230524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230525   gcc  
loongarch            randconfig-r036-20230524   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze   buildonly-randconfig-r003-20230524   gcc  
microblaze           randconfig-r012-20230524   gcc  
microblaze           randconfig-r015-20230524   gcc  
microblaze           randconfig-r026-20230524   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230524   clang
mips                      malta_kvm_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r021-20230524   gcc  
mips                 randconfig-r025-20230525   clang
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230524   gcc  
openrisc     buildonly-randconfig-r005-20230524   gcc  
openrisc             randconfig-r036-20230524   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r031-20230524   gcc  
parisc               randconfig-r032-20230525   gcc  
parisc               randconfig-r033-20230524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230524   clang
powerpc      buildonly-randconfig-r003-20230524   clang
powerpc      buildonly-randconfig-r004-20230524   clang
powerpc      buildonly-randconfig-r005-20230524   clang
powerpc                      makalu_defconfig   gcc  
powerpc              randconfig-r003-20230524   gcc  
powerpc              randconfig-r011-20230524   clang
powerpc              randconfig-r014-20230524   clang
powerpc              randconfig-r033-20230524   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230524   clang
riscv                randconfig-r042-20230524   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230524   clang
s390                                defconfig   gcc  
s390                 randconfig-r023-20230525   gcc  
s390                 randconfig-r025-20230524   clang
s390                 randconfig-r044-20230524   clang
sh                               allmodconfig   gcc  
sh                             espt_defconfig   gcc  
sh                   randconfig-r003-20230524   gcc  
sh                   randconfig-r004-20230524   gcc  
sh                   randconfig-r021-20230525   gcc  
sh                   randconfig-r023-20230524   gcc  
sh                   randconfig-r024-20230525   gcc  
sh                           se7751_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230524   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230524   gcc  
sparc                randconfig-r006-20230524   gcc  
sparc64                          alldefconfig   gcc  
sparc64      buildonly-randconfig-r003-20230524   gcc  
sparc64      buildonly-randconfig-r004-20230524   gcc  
sparc64              randconfig-r005-20230524   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230524   gcc  
x86_64               randconfig-a002-20230524   gcc  
x86_64               randconfig-a003-20230524   gcc  
x86_64               randconfig-a004-20230524   gcc  
x86_64               randconfig-a005-20230524   gcc  
x86_64               randconfig-a006-20230524   gcc  
x86_64               randconfig-a011-20230524   clang
x86_64               randconfig-a011-20230525   gcc  
x86_64               randconfig-a012-20230524   clang
x86_64               randconfig-a012-20230525   gcc  
x86_64               randconfig-a013-20230524   clang
x86_64               randconfig-a013-20230525   gcc  
x86_64               randconfig-a014-20230524   clang
x86_64               randconfig-a014-20230525   gcc  
x86_64               randconfig-a015-20230524   clang
x86_64               randconfig-a015-20230525   gcc  
x86_64               randconfig-a016-20230524   clang
x86_64               randconfig-a016-20230525   gcc  
x86_64               randconfig-r011-20230524   clang
x86_64               randconfig-r012-20230524   clang
x86_64               randconfig-r035-20230524   gcc  
x86_64               randconfig-x051-20230524   clang
x86_64               randconfig-x051-20230525   gcc  
x86_64               randconfig-x052-20230524   clang
x86_64               randconfig-x052-20230525   gcc  
x86_64               randconfig-x053-20230524   clang
x86_64               randconfig-x053-20230525   gcc  
x86_64               randconfig-x054-20230524   clang
x86_64               randconfig-x054-20230525   gcc  
x86_64               randconfig-x055-20230524   clang
x86_64               randconfig-x055-20230525   gcc  
x86_64               randconfig-x056-20230524   clang
x86_64               randconfig-x056-20230525   gcc  
x86_64               randconfig-x061-20230524   clang
x86_64               randconfig-x062-20230524   clang
x86_64               randconfig-x063-20230524   clang
x86_64               randconfig-x064-20230524   clang
x86_64               randconfig-x065-20230524   clang
x86_64               randconfig-x066-20230524   clang
x86_64               randconfig-x071-20230524   gcc  
x86_64               randconfig-x072-20230524   gcc  
x86_64               randconfig-x073-20230524   gcc  
x86_64               randconfig-x074-20230524   gcc  
x86_64               randconfig-x075-20230524   gcc  
x86_64               randconfig-x076-20230524   gcc  
x86_64               randconfig-x081-20230524   gcc  
x86_64               randconfig-x082-20230524   gcc  
x86_64               randconfig-x083-20230524   gcc  
x86_64               randconfig-x084-20230524   gcc  
x86_64               randconfig-x085-20230524   gcc  
x86_64               randconfig-x086-20230524   gcc  
x86_64               randconfig-x091-20230524   clang
x86_64               randconfig-x092-20230524   clang
x86_64               randconfig-x093-20230524   clang
x86_64               randconfig-x094-20230524   clang
x86_64               randconfig-x095-20230524   clang
x86_64               randconfig-x096-20230524   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230524   gcc  
xtensa               randconfig-r034-20230525   gcc  
xtensa               randconfig-r035-20230525   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
