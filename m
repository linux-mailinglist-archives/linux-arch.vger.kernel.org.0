Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C757C11C
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jul 2022 01:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiGTXuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 19:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiGTXuN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 19:50:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17414DEEF
        for <linux-arch@vger.kernel.org>; Wed, 20 Jul 2022 16:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658361013; x=1689897013;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kpZ6GzsX8ABr+QclHd5XE9Y0Hs3If53xrh5xdVMohec=;
  b=R1j7mhLNNQOe3FZ6+M7788fgrT1R8a595L6PZ43TK+T+CpG9jYfwrZex
   JosBMysfJimUwhy8IE+hhG+25GMfQkE+Y2QYlWQWOJF7OYZIwCbY/43GP
   fdy0D500co0BwmRUfVNwayckDfcNJx7dgLLN4AZJSh/Y0BjinJZyrFeRr
   UKEnLESi1FBzP326YCQTdY6CMedlJvSJNINAxXTLhqRJoRPSxCsybTZvu
   QycX8sBlbDbo+1iIZJMJqlzddfoK8HJTcFZGYea2GasnjgHIt8N/55Zv3
   3Bg8D5GC5nhN0VdMez28N/tYo9ZxfQiLu7D1nww/3zTtZJNkiqF8eNxSX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="286918615"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="286918615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 16:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="740470266"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2022 16:50:10 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEJSD-000145-R6;
        Wed, 20 Jul 2022 23:50:09 +0000
Date:   Thu, 21 Jul 2022 07:49:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic-fixes] BUILD SUCCESS
 9b31e60800d8fa69027baf9ec7f03a0c5b145079
Message-ID: <62d8947a.7cvrgya1sywWXsEj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes
branch HEAD: 9b31e60800d8fa69027baf9ec7f03a0c5b145079  tools: Fixed MIPS builds due to struct flock re-definition

elapsed time: 728m

configs tested: 100
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
arm                          iop32x_defconfig
sh                      rts7751r2d1_defconfig
arm                         nhk8815_defconfig
sh                           se7206_defconfig
sh                             shx3_defconfig
sh                                  defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          badge4_defconfig
sparc                             allnoconfig
arm                        mini2440_defconfig
arc                        nsimosci_defconfig
sparc                            allyesconfig
mips                  maltasmvp_eva_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pcm030_defconfig
alpha                            allyesconfig
m68k                            q40_defconfig
mips                  decstation_64_defconfig
loongarch                        alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    gamecube_defconfig
arm                          pxa168_defconfig
arm                          moxart_defconfig
powerpc                          allmodconfig
mips                          ath25_defconfig
powerpc                      acadia_defconfig
mips                          malta_defconfig
mips                           rs90_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a003-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a004-20220718
i386                 randconfig-a005-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
