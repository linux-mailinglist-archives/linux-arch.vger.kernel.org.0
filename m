Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5485D5847C1
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jul 2022 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiG1Vdx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jul 2022 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiG1Vdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2022 17:33:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6012476E97
        for <linux-arch@vger.kernel.org>; Thu, 28 Jul 2022 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659044027; x=1690580027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A9Vf7VckT0A0nWrVtoO66CIC9didfRPCq4KXSyol7KY=;
  b=ICOHYxsNaurxm4+sUWJVY9Y3jovbVwBbL6qp3BaFVOlHLqSqClbwRyCj
   ItfEmYMMHshokKj8iejiYcLi9nhlDm5n25nxwoEqYJWFZmh2kU35pJWgE
   ckSuCSM8sblU5S0I5ot2cdo4l+P0iWCTysTcCr/1sV6//66XqNDs9wB2F
   O3jts6KsKtxMCICI591hu+KNsQYRLqy81GPsVgIbwYPG7TKRxa2h4Whqc
   ykxopWHoPyMgHChYju7fXeB/uJ3DcWALd5tBnXfwhL1vbDtTBh7vuvmr+
   +aRRXYqeAn3WtNSzG/4uDNwbhZJIwz70qCJnLzispG43zEyvtV/nYjXpC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="269015075"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="269015075"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 14:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="928492848"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2022 14:33:45 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHB8a-000AbW-2B;
        Thu, 28 Jul 2022 21:33:44 +0000
Date:   Fri, 29 Jul 2022 05:32:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic-fixes] BUILD SUCCESS
 e2a619ca0b38f2114347b7078b8a67d72d457a3d
Message-ID: <62e30089.f+MVdl7gYNnCIfI4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes
branch HEAD: e2a619ca0b38f2114347b7078b8a67d72d457a3d  asm-generic: remove a broken and needless ifdef conditional

elapsed time: 1665m

configs tested: 173
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
i386                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20220727
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                              alldefconfig
powerpc                        cell_defconfig
m68k                                defconfig
mips                           gcw0_defconfig
m68k                            q40_defconfig
sh                            titan_defconfig
m68k                          sun3x_defconfig
mips                      fuloong2e_defconfig
sh                           se7712_defconfig
i386                          randconfig-c001
sparc                       sparc32_defconfig
powerpc                      mgcoge_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                        vdk_hs38_defconfig
mips                            ar7_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
mips                     decstation_defconfig
xtensa                  cadence_csp_defconfig
arc                                 defconfig
powerpc                      pasemi_defconfig
m68k                         amcore_defconfig
arm                            lart_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         ps3_defconfig
arm                        mvebu_v7_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sparc                       sparc64_defconfig
arm                           sama5_defconfig
arm                            qcom_defconfig
arm                            hisi_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7264_defconfig
mips                  decstation_64_defconfig
arm                         assabet_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc8540_ads_defconfig
sh                   sh7770_generic_defconfig
m68k                          amiga_defconfig
arm                         cm_x300_defconfig
ia64                                defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                    smp_lx200_defconfig
parisc64                            defconfig
csky                             alldefconfig
arm                           viper_defconfig
mips                 randconfig-c004-20220728
powerpc              randconfig-c003-20220728
loongarch                           defconfig
loongarch                         allnoconfig
s390                 randconfig-r044-20220728
riscv                randconfig-r042-20220728
arc                  randconfig-r043-20220728
xtensa                           allyesconfig
arm                           u8500_defconfig
powerpc                 linkstation_defconfig
powerpc                     taishan_defconfig
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
powerpc                    amigaone_defconfig
sh                          landisk_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
arc                           tb10x_defconfig
m68k                       m5475evb_defconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
x86_64                        randconfig-c001
arm                  randconfig-c002-20220728
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
sh                           se7343_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
mips                           ip32_defconfig
sh                 kfr2r09-romimage_defconfig
sh                     sh7710voipgw_defconfig
m68k                        m5407c3_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220727
hexagon              randconfig-r041-20220727
s390                 randconfig-r044-20220727
riscv                randconfig-r042-20220727
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                             mxs_defconfig
arm                        neponset_defconfig
hexagon              randconfig-r041-20220728
hexagon              randconfig-r045-20220728
powerpc                    mvme5100_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                 mpc8315_rdb_defconfig
mips                      pic32mzda_defconfig
hexagon                             defconfig
arm                          ixp4xx_defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                    gamecube_defconfig
arm                          collie_defconfig
mips                 randconfig-c004-20220728
x86_64                        randconfig-c007
s390                 randconfig-c005-20220728
powerpc              randconfig-c003-20220728
i386                          randconfig-c001
riscv                randconfig-c006-20220728
arm                  randconfig-c002-20220728
arm                       imx_v4_v5_defconfig
arm                       versatile_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
