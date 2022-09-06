Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3FF5ADEC1
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 07:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiIFFJO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 01:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiIFFJN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 01:09:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC56C77B
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 22:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662440952; x=1693976952;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vDqcz7qkR7DibVzSJGHxXVy4fzU4XsTijHFTm7khFu0=;
  b=T0MfZsB7xZS1q4PjtdoD0gbv3rvbpOloviNTnd0R9yFg/XspswrnmRzJ
   b7XE2KEa0iQBDPPZgaTczvPVwMKG/xzWAkoPYBdJs+qQpe1MjH+e7pX+z
   xOhMfFtFg24MJbsIBDQ6z4Dga5HyZzblZVv1XxleGH8CV0HSK2y0MDTcT
   6F143ZmH2rN6dxkM9/Tq1wTkixkPp7koZQ2MArZjv3MFksk83pxHjXlXt
   BmahJshRyC/h8M04feq96pJm6KYywXkMwUnyyhSXb1S8UWKFTnxEKx+Oc
   zzmm2L4aVsW8UORsJ3tWkbLpmhDL3z6g8A8TW58sbU1gIQQ5MO6juI3WT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="283499946"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="283499946"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 22:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="591125774"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2022 22:09:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVQph-0004pl-1m;
        Tue, 06 Sep 2022 05:09:09 +0000
Date:   Tue, 06 Sep 2022 13:09:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 8cbb2b50ee2dcb082675237eaaa48fe8479f8aa5
Message-ID: <6316d5ed.ckIw1Tqs2j1j7Wlg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 8cbb2b50ee2dcb082675237eaaa48fe8479f8aa5  asm-generic: Conditionally enable do_softirq_own_stack() via Kconfig.

elapsed time: 720m

configs tested: 119
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
i386                 randconfig-a003-20220905
i386                 randconfig-a005-20220905
i386                 randconfig-a006-20220905
i386                 randconfig-a001-20220905
i386                 randconfig-a002-20220905
i386                 randconfig-a004-20220905
m68k                             allyesconfig
arm                      integrator_defconfig
sh                         ap325rxa_defconfig
arm                        spear6xx_defconfig
arm                          iop32x_defconfig
sh                         microdev_defconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a001-20220905
x86_64               randconfig-a006-20220905
x86_64               randconfig-a004-20220905
x86_64               randconfig-a003-20220905
x86_64               randconfig-a002-20220905
x86_64               randconfig-a005-20220905
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
um                               alldefconfig
parisc                generic-32bit_defconfig
loongarch                 loongson3_defconfig
arm                            lart_defconfig
sh                           se7721_defconfig
mips                  decstation_64_defconfig
arc                            hsdk_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
arm                            hisi_defconfig
sh                            titan_defconfig
powerpc                       maple_defconfig
arm                             pxa_defconfig
loongarch                        alldefconfig
powerpc                  storcenter_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        m5407c3_defconfig
powerpc                     sequoia_defconfig
mips                            ar7_defconfig
xtensa                          iss_defconfig
i386                 randconfig-c001-20220905
sparc                            allyesconfig
sh                             shx3_defconfig
mips                           ip32_defconfig
sh                          sdk7780_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
ia64                         bigsur_defconfig
powerpc                         ps3_defconfig
sh                          r7780mp_defconfig
openrisc                 simple_smp_defconfig
s390                          debug_defconfig
arm                         vf610m4_defconfig
sh                             sh03_defconfig
powerpc                      pcm030_defconfig
sh                           se7780_defconfig
ia64                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                  randconfig-c002-20220905
x86_64               randconfig-c001-20220905
powerpc                      ppc40x_defconfig
microblaze                          defconfig
m68k                          sun3x_defconfig
sh                          rsk7201_defconfig

clang tested configs:
x86_64               randconfig-a014-20220905
x86_64               randconfig-a011-20220905
x86_64               randconfig-a016-20220905
x86_64               randconfig-a012-20220905
x86_64               randconfig-a015-20220905
x86_64               randconfig-a013-20220905
riscv                randconfig-r042-20220905
hexagon              randconfig-r041-20220905
hexagon              randconfig-r045-20220905
s390                 randconfig-r044-20220905
arm                          moxart_defconfig
arm                         palmz72_defconfig
arm                        spear3xx_defconfig
powerpc                       ebony_defconfig
i386                 randconfig-a016-20220905
i386                 randconfig-a012-20220905
i386                 randconfig-a015-20220905
i386                 randconfig-a011-20220905
i386                 randconfig-a013-20220905
i386                 randconfig-a014-20220905
x86_64               randconfig-k001-20220905
arm                       cns3420vb_defconfig
mips                       lemote2f_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                          malta_defconfig
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
