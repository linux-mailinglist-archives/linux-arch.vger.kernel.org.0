Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385177D9DD3
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJ0QOx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0QOx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 12:14:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BCEE3
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698423290; x=1729959290;
  h=date:from:to:cc:subject:message-id;
  bh=c/vye7WmJvYd6ydwz1Xp38fuhW6WywGuTBEoG3uYlKg=;
  b=bt8lI6jOkOVAOMvWV9p/zUgibvlj2pfRRvd3sPadHk7K6yw4Xb1lVySA
   gpo8i/NHy+F+MoPWd+806imtZXjU6Hn0USnf4LLCSng8wpFB97dHfS6T3
   eNPQD58U/bHYVEZCxeAml33uwJ5EDOCJPNwsZu5Etaqy3GOuonxfzf6r7
   b9/tsUyFPAxkKK2dk+kpdR66rQPEvwfAsk3UWxOT24YzBamPX3vEnMr2X
   tPnsbA7DWdZ8VppXedUhZnuhtYctrqNy3DAKG2c1BOK8il3TXztSHy1DW
   EqaGjWFRm8sNX3n5dNjD7lFHVin8bh2mkk0r/K+ycw6E7gtObwYsGVsQW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="418913574"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="418913574"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="736113163"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="736113163"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2023 09:14:49 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwPTy-000B07-2y;
        Fri, 27 Oct 2023 16:14:46 +0000
Date:   Sat, 28 Oct 2023 00:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 550087a0ba91eb001c139f563a193b1e9ef5a8dd
Message-ID: <202310280018.pbYHkNmT-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 550087a0ba91eb001c139f563a193b1e9ef5a8dd  hexagon: Remove unusable symbols from the ptrace.h uapi

elapsed time: 2898m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231026   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231026   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231026   gcc  
i386         buildonly-randconfig-002-20231026   gcc  
i386         buildonly-randconfig-003-20231026   gcc  
i386         buildonly-randconfig-004-20231026   gcc  
i386         buildonly-randconfig-005-20231026   gcc  
i386         buildonly-randconfig-006-20231026   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231026   gcc  
i386                  randconfig-002-20231026   gcc  
i386                  randconfig-003-20231026   gcc  
i386                  randconfig-004-20231026   gcc  
i386                  randconfig-005-20231026   gcc  
i386                  randconfig-006-20231026   gcc  
i386                  randconfig-011-20231026   gcc  
i386                  randconfig-012-20231026   gcc  
i386                  randconfig-013-20231026   gcc  
i386                  randconfig-014-20231026   gcc  
i386                  randconfig-015-20231026   gcc  
i386                  randconfig-016-20231026   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231026   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231026   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231026   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231026   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231026   gcc  
x86_64       buildonly-randconfig-002-20231026   gcc  
x86_64       buildonly-randconfig-003-20231026   gcc  
x86_64       buildonly-randconfig-004-20231026   gcc  
x86_64       buildonly-randconfig-005-20231026   gcc  
x86_64       buildonly-randconfig-006-20231026   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231026   gcc  
x86_64                randconfig-002-20231026   gcc  
x86_64                randconfig-003-20231026   gcc  
x86_64                randconfig-004-20231026   gcc  
x86_64                randconfig-005-20231026   gcc  
x86_64                randconfig-006-20231026   gcc  
x86_64                randconfig-011-20231026   gcc  
x86_64                randconfig-012-20231026   gcc  
x86_64                randconfig-013-20231026   gcc  
x86_64                randconfig-014-20231026   gcc  
x86_64                randconfig-015-20231026   gcc  
x86_64                randconfig-016-20231026   gcc  
x86_64                randconfig-071-20231026   gcc  
x86_64                randconfig-072-20231026   gcc  
x86_64                randconfig-073-20231026   gcc  
x86_64                randconfig-074-20231026   gcc  
x86_64                randconfig-075-20231026   gcc  
x86_64                randconfig-076-20231026   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
