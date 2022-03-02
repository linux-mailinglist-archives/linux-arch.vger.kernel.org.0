Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6434CB093
	for <lists+linux-arch@lfdr.de>; Wed,  2 Mar 2022 22:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbiCBVCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Mar 2022 16:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbiCBVCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Mar 2022 16:02:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4738DCE07
        for <linux-arch@vger.kernel.org>; Wed,  2 Mar 2022 13:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646254898; x=1677790898;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TAOAPrrddaTjIBzHgCtYdju0zqNRcGjkUpH/yulgPyA=;
  b=JBP7HGWJskEgzr7Fw+XSshJZxt7mN1fcsXmyWQhf2PiQ+HBWNm9J0Rj4
   mARQInJp31LheUi4YG7FAckSZAX7DvH+MVbElItxKoBGOFitaefqQ0tvF
   wSd2S71i7RhIncboz8GXZuEa5zSWS6MXxVlzh7GQQnGCsY077G2lZiLPv
   QeDAze565Xnxtlk6GExw1XJA0MRBnBwyTEm5IvCRDzupR4s5PgyliRU4t
   uFR8HzJADbozmpl50AMFx8nkkuAjOJ2GrfR4VbQ1s0ayIDwWd+EQ2/0xw
   5D0/ZFAyQMB9WNs2++5qJ3/TmaEW91EG9yE87GfQu1BZ0MATmcXumPPPr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234120871"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="234120871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 13:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="576246919"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2022 13:01:36 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPW6J-0001uJ-OG; Wed, 02 Mar 2022 21:01:35 +0000
Date:   Thu, 03 Mar 2022 05:00:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 9f15ac318b836c881f9e3cc0cdbc7497033a6336
Message-ID: <621fdb0b.XI88WbIE0WfZYGXB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 9f15ac318b836c881f9e3cc0cdbc7497033a6336  nds32: Remove the architecture

elapsed time: 726m

configs tested: 132
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
i386                          randconfig-c001
arm                        clps711x_defconfig
powerpc                 mpc834x_itx_defconfig
h8300                               defconfig
sh                           se7705_defconfig
sh                          r7780mp_defconfig
sh                           sh2007_defconfig
arm                            zeus_defconfig
powerpc                      pasemi_defconfig
sh                ecovec24-romimage_defconfig
openrisc                            defconfig
sh                        dreamcast_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1b_defconfig
powerpc                    klondike_defconfig
arm                             ezx_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
sparc                            allyesconfig
mips                        jmr3927_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                 decstation_r4k_defconfig
nios2                               defconfig
powerpc                         ps3_defconfig
m68k                            q40_defconfig
m68k                          amiga_defconfig
m68k                          hp300_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     rainier_defconfig
arm                           stm32_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      mgcoge_defconfig
powerpc                     taishan_defconfig
sparc64                          alldefconfig
sh                            titan_defconfig
m68k                        m5272c3_defconfig
powerpc                     pq2fads_defconfig
sh                          sdk7786_defconfig
parisc64                         alldefconfig
arm                  randconfig-c002-20220302
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                            allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20220302
riscv                randconfig-r042-20220302
s390                 randconfig-r044-20220302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
i386                          randconfig-c001
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
arm                          pxa168_defconfig
powerpc                 mpc8560_ads_defconfig
mips                   sb1250_swarm_defconfig
mips                         tb0219_defconfig
arm                         socfpga_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
