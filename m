Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E314D1DC4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiCHQvV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 11:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbiCHQvU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 11:51:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E36050041
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646758222; x=1678294222;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Df4Nr7azvvAsHOIpnvMiYycHl8jxit4VV44YTeNSXUs=;
  b=VF619315mhd5ROXdjLvSy9wI83wdHcbZ0ZxHc8Sh9flSK3gUJdadRpUK
   OHGKVzP3Qz3uw+6c6ABIPIwt9p76gmSp1Hqq7/vnWSH7hq/wLTfWVL1Bs
   qNKfEHGDQ87Za1Vqbc6mjraflHv1nggb/tfZXMu/DKBSGySwEdOHG41+c
   wqpFW5xWZh10nePoMkpJtsAq0E3+AsYzhG3y1kwOdra/fm5AfbLyhGUfd
   QY3J40HsbFZhj2V5l9A5JeqCTgNgE0CcWONf8oaRO29+Fe4PdZI6Zg7Tj
   Zd7LaCRRy5b5ElcHdjRaESYUXV1vMeRrOTSpeNWF02YQCVmdX6/vbS94v
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="279455054"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="279455054"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:45:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="537633793"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2022 08:45:33 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRcxo-0001jI-J7; Tue, 08 Mar 2022 16:45:32 +0000
Date:   Wed, 09 Mar 2022 00:44:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 3edb65f4e8fdec0569edf6a0e74675d2e5e6fe0e
Message-ID: <622787fc.m42dO3bL/RNvPQ+e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 3edb65f4e8fdec0569edf6a0e74675d2e5e6fe0e  nds32: Remove the architecture

elapsed time: 1587m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
sh                          landisk_defconfig
sh                          urquell_defconfig
mips                           ip32_defconfig
mips                      fuloong2e_defconfig
m68k                          atari_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
arm                            hisi_defconfig
riscv                               defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220307
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220308
powerpc              randconfig-c003-20220308
i386                          randconfig-c001
arm                  randconfig-c002-20220308
mips                 randconfig-c004-20220308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
