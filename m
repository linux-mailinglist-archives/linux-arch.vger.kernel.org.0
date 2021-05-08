Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50E3770AC
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhEHIdj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 May 2021 04:33:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:1864 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHIdj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 8 May 2021 04:33:39 -0400
IronPort-SDR: iGj3HWXJafN/APTQo/U2tdJHDuXW9TG2Puqfi67+Cc7urwkeVI5v++HZocuLiSIionO55HGgnb
 ZfsWURppXSCw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198937932"
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="198937932"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 01:32:38 -0700
IronPort-SDR: XkC4+XOIU6X4lp3gObPf4QBuGo3wwaaRcNnP9IEl8zMwNX5CF07oqoRTGhVBKNdx79a252oFb6
 KRzTU6aCUrHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="453379337"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2021 01:32:36 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lfIO4-000Bas-8F; Sat, 08 May 2021 08:32:36 +0000
Date:   Sat, 08 May 2021 16:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:unaligned-rework] BUILD SUCCESS
 e9fbd0aaca697320141b15df7df33656467cddfb
Message-ID: <60964c73.m7ibGGRdRJSh+GB0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git unaligned-rework
branch HEAD: e9fbd0aaca697320141b15df7df33656467cddfb  asm-generic: simplify asm/unaligned.h

elapsed time: 724m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
mips                           ip27_defconfig
powerpc64                           defconfig
xtensa                              defconfig
um                            kunit_defconfig
arm                        oxnas_v6_defconfig
arm                  colibri_pxa300_defconfig
mips                            ar7_defconfig
mips                           xway_defconfig
powerpc                     ksi8560_defconfig
mips                         cobalt_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
sh                           se7206_defconfig
sh                           se7722_defconfig
arm                       cns3420vb_defconfig
mips                          malta_defconfig
m68k                          sun3x_defconfig
sparc64                             defconfig
mips                           ip22_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a013-20210508
i386                 randconfig-a015-20210508
i386                 randconfig-a014-20210508
i386                 randconfig-a016-20210508
i386                 randconfig-a011-20210508
i386                 randconfig-a012-20210508
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
