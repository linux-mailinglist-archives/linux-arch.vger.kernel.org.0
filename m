Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576FE4BAB39
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiBQUo0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 15:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbiBQUoU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 15:44:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DEE15C9DD
        for <linux-arch@vger.kernel.org>; Thu, 17 Feb 2022 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645130645; x=1676666645;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4cyPq4TvNStdY5SJmH/LFc526TtmHi8X0bDuZfmP2kA=;
  b=Mqcddi3YW5RDzr/MrcQ2RRhw3WCCcSGHgxbxz5y/K6YAaGJX+t7Oc1uU
   MdYXSsK2CYj7js29Kl2qMDloyMaWXex+RhDpVO+9R+LAm93r+qFC1wQ3W
   cep+MXPdE60kwraMxmW6wLkG2AlEslc3NPdNaHJO3Ir3icvDRr9WYD28L
   /WWS78d/H6zAbVBCrUmrOjX3WKeSSLNWvJ5KmWxq5U1v/pJP6iw72K8WG
   /GRNWAEvN442WByADGtfdgqVR9zEpJluJVdAOT+/cFqyzqFbeRRy0TVZT
   p7UF53++u84td/uA6wBDY1nEQJQmpH9bon4eHeMMiZOKncEzb6L0Ba79Y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="314235762"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="314235762"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 12:44:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="488690633"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2022 12:44:03 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKndC-0000d3-Uf; Thu, 17 Feb 2022 20:44:02 +0000
Date:   Fri, 18 Feb 2022 04:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:set_fs-3] BUILD SUCCESS
 d379ce2b3c086a6b61ac37951dca95f7d25fe65d
Message-ID: <620eb353.eEfQdZYyXMddUYS4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git set_fs-3
branch HEAD: d379ce2b3c086a6b61ac37951dca95f7d25fe65d  uaccess: drop remaining CONFIG_SET_FS users

elapsed time: 734m

configs tested: 117
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
m68k                          hp300_defconfig
powerpc                      cm5200_defconfig
powerpc                      makalu_defconfig
xtensa                    xip_kc705_defconfig
mips                        bcm47xx_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       eiger_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
m68k                       m5475evb_defconfig
arm                        spear6xx_defconfig
arm                            lart_defconfig
sh                            titan_defconfig
h8300                            alldefconfig
nios2                         3c120_defconfig
m68k                         apollo_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
m68k                          sun3x_defconfig
sh                           se7619_defconfig
sh                            shmin_defconfig
arc                          axs101_defconfig
powerpc                      bamboo_defconfig
xtensa                          iss_defconfig
arm                          simpad_defconfig
sh                          rsk7201_defconfig
powerpc                      pasemi_defconfig
arm                           h5000_defconfig
ia64                         bigsur_defconfig
mips                     decstation_defconfig
arm                         assabet_defconfig
arm                  randconfig-c002-20220217
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                   sb1250_swarm_defconfig
powerpc                    ge_imp3a_defconfig
mips                        bcm63xx_defconfig
powerpc                     mpc5200_defconfig
powerpc                      ppc64e_defconfig
mips                      maltaaprp_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
