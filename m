Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A2527925
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiEOSec (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbiEOSeb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 14:34:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68991BE09
        for <linux-arch@vger.kernel.org>; Sun, 15 May 2022 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652639670; x=1684175670;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2GvE5DOU2mzWRogCDbuuIlaAxl36ZO2lb7vAdBplCbM=;
  b=VMT2EEFjCQjpOIiLVuYkmhNIJZtV/Mr2+/mvwYlNB2r/ykQxnARUxqZM
   WOgFQemA+wPkm7i4WEwSGacrv0t0/CmW/njJg7eAIxqU7k5LHmSDKM7n9
   cNg2d/qXbxSm0wfNnr3jie3jKFPJUBOauUcjSoqxvEgRIiRH2dGIHfHsj
   wzgET+17pV8NPy34BDW6zgccrulax+pEKgs4zRkkFoyCiNO1PArcEK8tH
   AohLfbJNfzZQ1sUP4zM3DZv/xXl2HZV/D6cj02aULSDhGt8hDAD3Nlrje
   jRlDjYts3v/VIHn9NfiIyxtSDfAt9JmHE3Dc/SZ3syvNdc0CLl1N6fMV0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="268242434"
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="268242434"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 11:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,228,1647327600"; 
   d="scan'208";a="659814464"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2022 11:34:27 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqJ4V-0001th-6N;
        Sun, 15 May 2022 18:34:27 +0000
Date:   Mon, 16 May 2022 02:34:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 678e9c3a9389e48507e8f832963ad4290405adbc
Message-ID: <628147a7.vu+hqtVA4aIY2ReB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 678e9c3a9389e48507e8f832963ad4290405adbc  Merge branch 'asm-generic-headers-cleanup' into asm-generic

elapsed time: 3438m

configs tested: 87
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                          simpad_defconfig
arm                        cerfcube_defconfig
sh                          r7785rp_defconfig
sh                          urquell_defconfig
arm                         axm55xx_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
mips                       capcella_defconfig
arm                         s3c6400_defconfig
sh                   rts7751r2dplus_defconfig
mips                         mpc30x_defconfig
sh                         ecovec24_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc64                            defconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
parisc                              defconfig
s390                             allmodconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220512
hexagon              randconfig-r041-20220512

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
