Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5505F5FA79E
	for <lists+linux-arch@lfdr.de>; Tue, 11 Oct 2022 00:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJJWTs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 18:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJWTr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 18:19:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C46D77
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2022 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665440377; x=1696976377;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Z67bolo6ZggM1cRXcRjVS++VsLsqgkWWY/WubNKVFVM=;
  b=irZsc0Go3PX6nTWSiwn19z7xTMiJqjocWRiRESLnKboAkKhqmuup85eH
   6r6TNtZhE8OP8sBA1c7c5pDiQ0h+n8wLhDK2FsPMnDoOgyQyeNXTRuH2o
   Hj2xmoTYTSf86h7IaBPYnroEH/2hWyo+KWsHrgaqKYQS/uiulmiYAN8gl
   h48Yek1W1KijtXHZ878dtmDwMmDyaCODObdonGiWs0wm38RdLTUDCZlO9
   htJadw8S+jW9g+i7HMCBfY/0lDWwiSW0aNaAqJiWixWdOFVLIVr2J9MmD
   RUOPA+yrqzVqEFzT3Im4viQChXjGCYBPtqXYlNFwxSwevliOhuHW6aQe1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284076972"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284076972"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="730725069"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="730725069"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2022 15:19:32 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oi17U-0002Dj-0h;
        Mon, 10 Oct 2022 22:19:32 +0000
Date:   Tue, 11 Oct 2022 06:18:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS WITH WARNING
 2e21c1575208786f667cb66d8cf87a52160b81db
Message-ID: <63449a4e.uYwg08N46QSzcQ8i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 2e21c1575208786f667cb66d8cf87a52160b81db  alpha: fix marvel_ioread8 build regression

Warning reports:

https://lore.kernel.org/linux-arch/202210040004.JSEtm9uf-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread64' [-Wmissing-prototypes]
arch/alpha/include/asm/core_t2.h:594:22: warning: no previous prototype for 't2_iowrite64' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:187:21: warning: no previous prototype for 'jensen_inq' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:207:22: warning: no previous prototype for 'jensen_outq' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread64' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite64' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_ioread64
|   |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_iowrite64
|   |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_inq
|   |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_ioread64
|   |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_iowrite64
|   `-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_outq
`-- alpha-defconfig
    |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_ioread64
    |-- arch-alpha-include-asm-core_t2.h:warning:no-previous-prototype-for-t2_iowrite64
    |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_inq
    |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_ioread64
    |-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_iowrite64
    `-- arch-alpha-include-asm-jensen.h:warning:no-previous-prototype-for-jensen_outq

elapsed time: 747m

configs tested: 112
configs skipped: 3

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20221010
s390                 randconfig-r044-20221010
riscv                randconfig-r042-20221010
s390                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                             allmodconfig
alpha                               defconfig
i386                 randconfig-a012-20221010
i386                 randconfig-a011-20221010
powerpc                           allnoconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
i386                 randconfig-a013-20221010
arc                                 defconfig
i386                 randconfig-a015-20221010
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20221010
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
sh                               allmodconfig
i386                 randconfig-a016-20221010
arm                                 defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a011-20221010
arm                           h5000_defconfig
arm                        keystone_defconfig
sh                      rts7751r2d1_defconfig
x86_64               randconfig-a014-20221010
s390                             allmodconfig
x86_64               randconfig-a012-20221010
x86_64               randconfig-a013-20221010
x86_64               randconfig-a015-20221010
x86_64               randconfig-a016-20221010
ia64                             allmodconfig
s390                             allyesconfig
mips                        bcm47xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                           sama5_defconfig
arm                          pxa910_defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20221010
sh                            shmin_defconfig
powerpc                      pcm030_defconfig
powerpc                 canyonlands_defconfig
sh                        sh7785lcr_defconfig
sh                          kfr2r09_defconfig
m68k                        mvme16x_defconfig
sh                         ecovec24_defconfig
arc                        nsim_700_defconfig
arm64                               defconfig
sh                           se7750_defconfig
powerpc                     rainier_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        trizeps4_defconfig
arm                           stm32_defconfig
arm                            pleb_defconfig
arm                         s3c6400_defconfig
arm                         lubbock_defconfig
m68k                        m5272c3_defconfig
m68k                        m5407c3_defconfig
powerpc                     pq2fads_defconfig
powerpc                   currituck_defconfig
arm                      integrator_defconfig
sh                             shx3_defconfig
mips                      maltasmvp_defconfig
arm                        clps711x_defconfig
m68k                          hp300_defconfig
arm                      footbridge_defconfig
sh                     sh7710voipgw_defconfig
loongarch                        allmodconfig
sh                           se7206_defconfig
sh                        edosk7760_defconfig
x86_64               randconfig-k001-20221010
arm                            lart_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      fuloong2e_defconfig

clang tested configs:
hexagon              randconfig-r045-20221010
hexagon              randconfig-r041-20221010
i386                 randconfig-a003-20221010
x86_64               randconfig-a004-20221010
i386                 randconfig-a002-20221010
x86_64               randconfig-a002-20221010
i386                 randconfig-a006-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a004-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a003-20221010
i386                 randconfig-a005-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a005-20221010
arm                     am200epdkit_defconfig
arm                          ep93xx_defconfig
mips                      maltaaprp_defconfig
i386                             allyesconfig
hexagon                             defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
