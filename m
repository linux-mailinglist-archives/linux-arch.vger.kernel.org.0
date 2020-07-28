Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4AC23104F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgG1Q7z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 12:59:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:37284 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731523AbgG1Q7z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 12:59:55 -0400
IronPort-SDR: Rzam0maEZ8OP02peYRhHgNxZD6ikL+l1MLnPs74Bo6tvtJW7VMJK/9swY9s2GyVzDY/rptWuDp
 Il3yODPN3CDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="152508853"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="152508853"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 09:59:54 -0700
IronPort-SDR: aSH3jc1fMtjcCKIVBrzJnfKDuQUq1sosnbdRWHlFiQqwQX2A58ilcPEir4VLJsvHgvzAP3MhC9
 NCM+T7H51PVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="273619683"
Received: from lkp-server01.sh.intel.com (HELO d27eb53fc52b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2020 09:59:53 -0700
Received: from kbuild by d27eb53fc52b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0SxE-0000yP-Bk; Tue, 28 Jul 2020 16:59:52 +0000
Date:   Wed, 29 Jul 2020 00:59:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [asm-generic:asm-generic] BUILD SUCCESS
 214ba3584b2e2c57536fa8aed52521ac59c5b448
Message-ID: <5f205965.c7HQlfcGwa+HPe4A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git  asm-generic
branch HEAD: 214ba3584b2e2c57536fa8aed52521ac59c5b448  io: Fix return type of _inb and _inl

elapsed time: 1746m

configs tested: 48
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
