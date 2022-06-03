Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD8853C3E8
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiFCE6x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 00:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiFCE6v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 00:58:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074512D1DD
        for <linux-arch@vger.kernel.org>; Thu,  2 Jun 2022 21:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654232331; x=1685768331;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yHcoRzAqzEzKTiIxbp7ocfuiQRSJl67vBRrwa5q3Nc0=;
  b=mFBg4gLGoBFnr80Mggee40J9ZWwE9utzT3gpwq3kZQD1f8tqdQIOdfL1
   Mc3Sjnbj1lGiqB23RrVJ7imBJNgt6AVC0GgmKZ8IOwKceNl/3YdVD4zKf
   3+hlwYX2aZaG1Ug3zFyEUdfr6SHr5dw5UbtNQEEMYyADI7x5A5TZ+CBIK
   le44Nuo6AREOuiU21r0PMvEmG50cAFArwGMC/Gw9AaVE+nKA18N1Z1CYf
   kLc3wZI5Norh5xuTZZhZh3W1y+SCBmo8rUzPhO0g7DhmQJ9whXj0S651i
   EobXCH/YHjYIqdPx2aIvhCBgmFX/c06XOk9mihHNlTPSNoFv5C8XBU+7Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="258240615"
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="258240615"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 21:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,273,1647327600"; 
   d="scan'208";a="553176532"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Jun 2022 21:58:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwzOX-0006JR-R1;
        Fri, 03 Jun 2022 04:58:45 +0000
Date:   Fri, 03 Jun 2022 12:57:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 8cc5b032240ae5220b62c689c20459d3e1825b2d
Message-ID: <629994c9.0VznuWefvHXF6whG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 8cc5b032240ae5220b62c689c20459d3e1825b2d  binder: fix sender_euid type in uapi header

elapsed time: 724m

configs tested: 120
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arc                          axs101_defconfig
arm                          gemini_defconfig
arm                         vf610m4_defconfig
arm                           viper_defconfig
nios2                               defconfig
sh                   secureedge5410_defconfig
arm64                            alldefconfig
sh                         microdev_defconfig
xtensa                generic_kc705_defconfig
powerpc                      cm5200_defconfig
m68k                         apollo_defconfig
powerpc                     ep8248e_defconfig
sh                           se7780_defconfig
sh                          kfr2r09_defconfig
sh                ecovec24-romimage_defconfig
arm                       aspeed_g5_defconfig
arm                           sama5_defconfig
powerpc                    amigaone_defconfig
m68k                         amcore_defconfig
mips                         mpc30x_defconfig
openrisc                 simple_smp_defconfig
arm                        mini2440_defconfig
sh                           se7343_defconfig
arm                       imx_v6_v7_defconfig
sh                     magicpanelr2_defconfig
ia64                                defconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220531
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220531
s390                 randconfig-r044-20220531
riscv                randconfig-r042-20220531
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220531
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220531
arm                  randconfig-c002-20220531
powerpc              randconfig-c003-20220531
riscv                randconfig-c006-20220531
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
powerpc                      acadia_defconfig
arm                         hackkit_defconfig
mips                malta_qemu_32r6_defconfig
mips                        workpad_defconfig
arm                             mxs_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8540_defconfig
arm                       cns3420vb_defconfig
arm                       netwinder_defconfig
arm                         lpc32xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
