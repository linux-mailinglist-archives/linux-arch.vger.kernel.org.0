Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197036D91BB
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDFIev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjDFIer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 04:34:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECD512F
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680770086; x=1712306086;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jd+6UW6q9elquw5bZDGjMqW7rOg0F1EQwi8lrQCZdBk=;
  b=GVKg25t66Dpwexc3IsXV0Ko+mnDB4x0wLQcHhrqwjNhJ2QXfVUjCdcWZ
   a7Y2AJkCpBjOpDOt1EvLTqDuGOHChCPA7D+4CdGqptRWm/W8M3Ip7Eomx
   yumQnCfF+1CorZuRHuDWrinLwbcfb+wSdls4R/33HiynZDOQ9SOH5G1XE
   l5dHFltr+w/VjH6jI96jNVASpI0haiPTo05+1t7nqY8L7fLpvcomYnP+H
   sCPIr0BCNfUaNUpCovJxGKwHwxf/bRlVV8W8R/nZ6LDEuklzM0Y5gfh09
   1GGjPuO9PWI/AF3qYmK20FiTn9K1b0J1s/Z6xbp1kV0YcbFBVj9Yb6MHj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="407778821"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407778821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 01:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="664367274"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="664367274"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2023 01:34:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkL4u-000RE1-1S;
        Thu, 06 Apr 2023 08:34:44 +0000
Date:   Thu, 06 Apr 2023 16:34:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic-io] BUILD SUCCESS
 fcbfe8121a45152a3cfbe1c28c96a3b611b7347d
Message-ID: <642e83f9.5QLtuhNr00jluzSH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-io
branch HEAD: fcbfe8121a45152a3cfbe1c28c96a3b611b7347d  Kconfig: introduce HAS_IOPORT option and select it as necessary

elapsed time: 726m

configs tested: 101
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230403   clang
arm                  randconfig-r046-20230403   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230403   gcc  
csky                 randconfig-r021-20230403   gcc  
csky                 randconfig-r032-20230405   gcc  
csky                 randconfig-r035-20230405   gcc  
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230404   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230403   gcc  
m68k                 randconfig-r031-20230405   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r033-20230405   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230403   gcc  
openrisc     buildonly-randconfig-r005-20230404   gcc  
openrisc             randconfig-r034-20230405   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc                       holly_defconfig   gcc  
powerpc              randconfig-r001-20230403   clang
powerpc              randconfig-r005-20230403   clang
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230403   clang
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r001-20230404   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r022-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
