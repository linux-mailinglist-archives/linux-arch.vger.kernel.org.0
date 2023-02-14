Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66FA6967D6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 16:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBNPT3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 10:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjBNPT3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 10:19:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEB826CEC
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676387968; x=1707923968;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XKqfAQMI3x5kNfjXMY/btUxpzoRLHFs7pum4DrUXbyY=;
  b=YKT7jnFMhElabCpq4tLs08sZX/dQ2xo3LKkbRb0uOqrNUguOohtwxeL/
   xdt+3xXfOygy8MCeMJTvacyMpMCwEojOUh1/BjijuPGJhBUls2pyW/x93
   BzRBC37cyMpYXwehYmutCY+TvB5xCBWz4cZ70dqKCccTVjuOKU78U9ypP
   4pfk2LCdVozBJxbxRY2b9DfPfsfRHn4aJVKNrQxLfRWi+NDlIyP+u3chx
   +xhKJMoLwk/UnIUqqEwmF1ZAZXlzXFZBJ7J/f3O3fSEuA2swmBZBJAURd
   VG4zMqLi8TQsGiXvEuG+TM/LI8ok8Lnyvi/LvAb06DLoh2cu3wQ+3gOZ1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332494107"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="332494107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 07:19:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778374220"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="778374220"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2023 07:19:14 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRx5N-0008af-0B;
        Tue, 14 Feb 2023 15:19:13 +0000
Date:   Tue, 14 Feb 2023 23:18:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 a13408c205260716e925a734ef399899d69182ba
Message-ID: <63eba654.aRIbFyeSBVXu13g1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: a13408c205260716e925a734ef399899d69182ba  char/agp: introduce asm-generic/agp.h

elapsed time: 1083m

configs tested: 73
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                               allnoconfig
arc                              allyesconfig
arc                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                           corgi_defconfig
arm                                 defconfig
arm                        oxnas_v6_defconfig
arm                            qcom_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                          randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                 randconfig-c004-20230212
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sh                             espt_defconfig
sh                     sh7710voipgw_defconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz

clang tested configs:
arm                  colibri_pxa300_defconfig
arm                           spitz_defconfig
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
mips                           mtx1_defconfig
powerpc                     akebono_defconfig
powerpc                     ksi8560_defconfig
x86_64                           allyesconfig
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
