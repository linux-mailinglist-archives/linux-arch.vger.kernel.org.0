Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2E719154
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 05:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjFAD23 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 23:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFAD2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 23:28:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CDF185
        for <linux-arch@vger.kernel.org>; Wed, 31 May 2023 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685590094; x=1717126094;
  h=date:from:to:cc:subject:message-id;
  bh=+wHaCm9v7lpMf67MCWMlqjqESjvNW95KJZrc7670UEY=;
  b=B9FMvV7gHlxc/fGczINm0C9u05UtVfRfwaiVSTHEhxGSwee3YYTkWAcF
   tU7AAqYjgTu1ZrWyKTuJeC5Vm/NS4/FxxWYt1kc6tCI9BGBpesneGR1cn
   GTzNC6tB/2ua0AE7oEiHrww8zo5j6uGouNMF2g/LfiGgfS74aTZQskfcj
   ootHdtIIJcGHS7MoUoKREswwg+yjnDAGj1kBHpp4ZYowxfhxFVj3B0Stw
   mSBuhwT7UQtsxj7pRBvEn4c+e2nyr9LeWfC+VlRborvC1MpbXK8TzWu7k
   oAQiRwB1hBQDi4plL186k4jOc7zG+6gxKXmtT1g9LlDeekmP0lxNrLsC8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="418939517"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="418939517"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 20:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="1037299579"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="1037299579"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 20:27:59 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4Yyk-0001s5-23;
        Thu, 01 Jun 2023 03:27:58 +0000
Date:   Thu, 01 Jun 2023 11:27:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 3b1ddbb62e7e7d2433781cd2f59d77c2f9aee934
Message-ID: <20230601032720.A9WJy%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 3b1ddbb62e7e7d2433781cd2f59d77c2f9aee934  Merge tag 'virt-to-pfn-for-arch-v6.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator into asm-generic

elapsed time: 720m

configs tested: 178
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230531   gcc  
alpha                randconfig-r025-20230531   gcc  
alpha                randconfig-r034-20230531   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                  randconfig-r046-20230531   gcc  
arm                        spear3xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230531   clang
arm64                randconfig-r036-20230531   gcc  
csky         buildonly-randconfig-r005-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230531   gcc  
hexagon      buildonly-randconfig-r003-20230531   clang
hexagon              randconfig-r001-20230531   clang
hexagon              randconfig-r014-20230531   clang
hexagon              randconfig-r015-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                              allnoconfig   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i011-20230531   clang
i386                 randconfig-i012-20230531   clang
i386                 randconfig-i013-20230531   clang
i386                 randconfig-i014-20230531   clang
i386                 randconfig-i015-20230531   clang
i386                 randconfig-i016-20230531   clang
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r005-20230531   gcc  
i386                 randconfig-r021-20230531   clang
i386                 randconfig-r026-20230531   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230531   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230531   gcc  
loongarch            randconfig-r021-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230531   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                 randconfig-r003-20230531   gcc  
m68k                 randconfig-r011-20230531   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r022-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230531   clang
mips                     decstation_defconfig   gcc  
mips                           ip22_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                 randconfig-r004-20230531   clang
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230531   gcc  
openrisc             randconfig-r035-20230531   gcc  
parisc                           alldefconfig   gcc  
parisc       buildonly-randconfig-r005-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230531   gcc  
parisc               randconfig-r011-20230531   gcc  
parisc               randconfig-r015-20230531   gcc  
parisc               randconfig-r032-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc              randconfig-r003-20230531   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230531   clang
riscv        buildonly-randconfig-r006-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230531   gcc  
riscv                randconfig-r023-20230531   clang
riscv                randconfig-r031-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230531   gcc  
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r002-20230531   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r004-20230531   gcc  
sh                   randconfig-r012-20230531   gcc  
sh                   randconfig-r034-20230531   gcc  
sh                   randconfig-r035-20230531   gcc  
sh                           se7619_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230531   gcc  
sparc                randconfig-r022-20230531   gcc  
sparc64              randconfig-r006-20230531   gcc  
sparc64              randconfig-r012-20230531   gcc  
sparc64              randconfig-r014-20230531   gcc  
sparc64              randconfig-r033-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-a011-20230531   clang
x86_64               randconfig-a012-20230531   clang
x86_64               randconfig-a013-20230531   clang
x86_64               randconfig-a014-20230531   clang
x86_64               randconfig-a015-20230531   clang
x86_64               randconfig-a016-20230531   clang
x86_64               randconfig-x051-20230531   clang
x86_64               randconfig-x052-20230531   clang
x86_64               randconfig-x053-20230531   clang
x86_64               randconfig-x054-20230531   clang
x86_64               randconfig-x055-20230531   clang
x86_64               randconfig-x056-20230531   clang
x86_64               randconfig-x061-20230531   clang
x86_64               randconfig-x062-20230531   clang
x86_64               randconfig-x063-20230531   clang
x86_64               randconfig-x064-20230531   clang
x86_64               randconfig-x065-20230531   clang
x86_64               randconfig-x066-20230531   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230531   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r002-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
