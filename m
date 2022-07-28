Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6BA583BEC
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jul 2022 12:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiG1KUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jul 2022 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiG1KUH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2022 06:20:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D94E1C2
        for <linux-arch@vger.kernel.org>; Thu, 28 Jul 2022 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659003606; x=1690539606;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4BiTJvFNxKwegQvZagIMibjySls1lbiK+NQ8cvsHEaw=;
  b=ZvLs5uUxAJ6O913iBTfTKK3DyVubwpW7CUWjFJPl9lUEtBUJ9WshXp06
   YR2QoD3PSEIwBaUBNyLSmL2mHlipkjopR6f6AlyYHmmYN2EAnEA5HG7Qc
   /JTRYrpklQhRQ9IY+sq3wDj/1G/S3aIOkCrMbzvFXQku9FvyOZTbRWTpA
   Upibrfa1Dum9yFzOc300U2f+YuesOwGAybSG/JOyKeyn96LZrcHjYJlgE
   oKjh7yH/9zoYrMLSf7Dm1lQ8e8eVLolwYtiMREoneDMjAWJyfRlCXiCiC
   tb5QlVsA3ynImDaOblsjb75Fc+C/8+TrRgd2Qax2oOIW7qYv+LTQ9uTfd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="352474127"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="352474127"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 03:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="928226037"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2022 03:20:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH0cd-0009tm-0I;
        Thu, 28 Jul 2022 10:20:03 +0000
Date:   Thu, 28 Jul 2022 18:19:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 82dc270146a82edd67228be94b0fe302a6f78395
Message-ID: <62e262a9.h1Ex4Vbu2cBWPCzE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 82dc270146a82edd67228be94b0fe302a6f78395  Merge branch 'asm-generic-fixes' into asm-generic

elapsed time: 991m

configs tested: 122
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
arc                  randconfig-r043-20220727
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a015
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
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

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
riscv                randconfig-r042-20220727
hexagon              randconfig-r041-20220727
hexagon              randconfig-r045-20220727
s390                 randconfig-r044-20220727
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
