Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6C4F21C6
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 06:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiDEDCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 23:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiDEDCG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 23:02:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC972B2B6A
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649126564; x=1680662564;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mtO2hr63TXxfKWASRa0HOf1PzQgM09J/Dl/E6k9glss=;
  b=FT1awo+ufsT8+QCiBanDsYRGEr1UIBUxQB2Fdi2GaOItAbW3kRdVXeTi
   8Od5qTyA3Ta15GKXCTek69sjJ2gWizaJ+mqBrGdpxpbcZocMM1XfGmJBb
   ND2XpEJ+hxjITVDzhss7Uu1VYCCLfbDgvnoCfxMJbfWJPxscxURQPYW8G
   LhYVb0NcrOvmPlZA2vv9EDwuW/jaAcN5JLSPA5v4jL8iFZ9IL61mzNAfh
   iOSdW0kTzD/NPOhe4Ul1XxjwrUtXRwuNT4ptpZ7+wQ6MC3ciSx50g3wA9
   Jxfe0EX5Eay20xDRkoe/Oy5H2L/NiZxmi0PwM75GyX0T1lLdQvpr2VXDz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260349321"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="260349321"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 19:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="620208241"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2022 19:42:42 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbZ9V-0002Yt-Cx;
        Tue, 05 Apr 2022 02:42:41 +0000
Date:   Tue, 05 Apr 2022 10:41:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 fba2689ee77e63b05e203b3f26079ef915e55660
Message-ID: <624bac70.YWhk5CpZZeNvC1sF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: fba2689ee77e63b05e203b3f26079ef915e55660  Merge branch 'remove-h8300' of git://git.infradead.org/users/hch/misc into asm-generic

elapsed time: 725m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
i386                 randconfig-c001-20220404
arm                       aspeed_g5_defconfig
mips                      maltasmvp_defconfig
powerpc                       ppc64_defconfig
alpha                            alldefconfig
arc                        nsimosci_defconfig
sh                                  defconfig
xtensa                              defconfig
m68k                          sun3x_defconfig
powerpc                      mgcoge_defconfig
arm                       imx_v6_v7_defconfig
powerpc                    sam440ep_defconfig
s390                          debug_defconfig
arm                          pxa3xx_defconfig
arm                         lubbock_defconfig
powerpc                      chrp32_defconfig
arm                        mini2440_defconfig
arm                      integrator_defconfig
arm                        realview_defconfig
sh                           se7780_defconfig
mips                          rb532_defconfig
sparc                               defconfig
sh                         ap325rxa_defconfig
m68k                       m5475evb_defconfig
arm                        keystone_defconfig
arm                       omap2plus_defconfig
sh                          rsk7201_defconfig
x86_64               randconfig-c001-20220404
arm                  randconfig-c002-20220404
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                              debian-10.3
i386                             allyesconfig
i386                                defconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20220404
x86_64               randconfig-a011-20220404
x86_64               randconfig-a013-20220404
x86_64               randconfig-a014-20220404
x86_64               randconfig-a012-20220404
x86_64               randconfig-a015-20220404
i386                 randconfig-a013-20220404
i386                 randconfig-a011-20220404
i386                 randconfig-a014-20220404
i386                 randconfig-a012-20220404
i386                 randconfig-a015-20220404
i386                 randconfig-a016-20220404
arc                  randconfig-r043-20220404
riscv                randconfig-r042-20220404
s390                 randconfig-r044-20220404
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  colibri_pxa300_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   bluestone_defconfig
powerpc                     powernv_defconfig
powerpc                     mpc512x_defconfig
arm                       spear13xx_defconfig
arm                        neponset_defconfig
i386                 randconfig-a001-20220404
i386                 randconfig-a003-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a005-20220404
i386                 randconfig-a006-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a004-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a006-20220404
hexagon              randconfig-r045-20220404
hexagon              randconfig-r041-20220404

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
