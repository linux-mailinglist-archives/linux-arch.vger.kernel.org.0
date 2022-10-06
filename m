Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F85F70EF
	for <lists+linux-arch@lfdr.de>; Fri,  7 Oct 2022 00:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiJFWFe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 18:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiJFWFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 18:05:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E591AD8F
        for <linux-arch@vger.kernel.org>; Thu,  6 Oct 2022 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665093891; x=1696629891;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oILdn99IiSLJZQ0xtX1dFxkdF04AYRHeXJ1RsWZuzlM=;
  b=cXRjil7L4bD2ujtJlW3/L2wlh2/tBEt2KWSyR2xr3Nug7klP6BCK33zh
   1HBxOwtCEpTpg7uIWyifwFNdcdqHjubprklNY6B6dhe7qS9x98eSumm35
   jndRE/L8SPLCn2qXQ0xGzKGxhINyVPYQzfMJAB/+rMBco0yznWaBJmE84
   WCi3xPhuWcj7Nrm36SUgvHISv/ybgCwX2AUINHF+OAvtn4SbuTo550l1d
   k2iPHhTKEmx0Grf0U6th3jrVoS/bvkvqCghoeAf0dV4+joUpHB47z3fJ+
   +V7eiRZVftQpdsB3jHcWw4GXraunNP9NZcB7Ec4qVP13pdRn1rwVpwNvq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="305166027"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="305166027"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:04:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="693537387"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="693537387"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2022 15:04:49 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogYz2-0000Wt-2O;
        Thu, 06 Oct 2022 22:04:48 +0000
Date:   Fri, 07 Oct 2022 06:03:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD REGRESSION
 e19d4ebc536dadb607fe305fdaf48218d3e32d7c
Message-ID: <633f50cd.f8YCVB8cGH9bOVWW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: e19d4ebc536dadb607fe305fdaf48218d3e32d7c  alpha: add full ioread64/iowrite64 implementation

Error/Warning reports:

https://lore.kernel.org/linux-arch/202210040004.JSEtm9uf-lkp@intel.com
https://lore.kernel.org/linux-arch/202210062117.wJypzBWL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread64' [-Wmissing-prototypes]
arch/alpha/include/asm/core_t2.h:594:22: warning: no previous prototype for 't2_iowrite64' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:187:21: warning: no previous prototype for 'jensen_inq' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:207:22: warning: no previous prototype for 'jensen_outq' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread64' [-Wmissing-prototypes]
arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite64' [-Wmissing-prototypes]
arch/alpha/kernel/core_marvel.c:807:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'marvel_ioread8'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allnoconfig
|   `-- arch-alpha-kernel-core_marvel.c:error:expected-asm-or-__attribute__-before-marvel_ioread8
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

elapsed time: 720m

configs tested: 111
configs skipped: 14

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
arm                                 defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
i386                 randconfig-a013-20221003
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20221003
i386                 randconfig-a015-20221003
x86_64                           allyesconfig
x86_64               randconfig-a015-20221003
i386                 randconfig-a016-20221003
x86_64               randconfig-a016-20221003
s390                             allyesconfig
s390                 randconfig-r044-20221003
i386                             allyesconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20221003
i386                 randconfig-a014-20221003
arm64                            allyesconfig
arc                  randconfig-r043-20221002
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64               randconfig-a011-20221003
mips                             allyesconfig
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
m68k                             allmodconfig
x86_64               randconfig-a014-20221003
arc                              allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
i386                          randconfig-c001
m68k                             allyesconfig
arm                     eseries_pxa_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
nios2                            alldefconfig
mips                        bcm47xx_defconfig
arm                          simpad_defconfig
powerpc                      cm5200_defconfig
arm                           viper_defconfig
s390                                defconfig
arc                        nsim_700_defconfig
sh                          r7780mp_defconfig
xtensa                              defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
m68k                            q40_defconfig
mips                  decstation_64_defconfig
powerpc                     tqm8548_defconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
m68k                            mac_defconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                     tqm8555_defconfig
sh                           se7619_defconfig
riscv                            allyesconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
x86_64               randconfig-a003-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
hexagon              randconfig-r045-20221003
x86_64               randconfig-a005-20221003
hexagon              randconfig-r041-20221003
hexagon              randconfig-r041-20221002
x86_64               randconfig-a004-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
hexagon              randconfig-r045-20221002
i386                 randconfig-a005-20221003
x86_64               randconfig-a006-20221003
i386                 randconfig-a006-20221003
i386                 randconfig-a004-20221003
riscv                randconfig-r042-20221002
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
s390                 randconfig-r044-20221002
x86_64                        randconfig-k001
riscv                randconfig-r042-20221006
hexagon              randconfig-r041-20221006
s390                 randconfig-r044-20221006
hexagon              randconfig-r045-20221006
i386                             allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
