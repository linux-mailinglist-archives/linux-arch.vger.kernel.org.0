Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1463FF95
	for <lists+linux-arch@lfdr.de>; Fri,  2 Dec 2022 05:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiLBEyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Dec 2022 23:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiLBEx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2022 23:53:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA97CAF95
        for <linux-arch@vger.kernel.org>; Thu,  1 Dec 2022 20:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669956839; x=1701492839;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HQcXooWunaislOoH7kTvG50L0PPaUGFc3S3Gw7qMLtY=;
  b=GYkw1Q6hXgvvaeKolGovKLeopKlDgZiHNCG+9l6tUx4qkEtJUCuvSvdW
   vC8JaEvRxfXkMQIrPtH8um/5S1JBrBaXDNUMmtlaRXzgDH1Z3fIoweRPb
   LzGS2iKOz0hooS/VAN4FcFOolnOa6CsmM/oC8dW8qldHDzSTLyeSNq700
   8rHerPKBnZ0MOoOTHqINEeL8+coB/IPkUaTKE9wAS63m2R6XVwBQ9cjCs
   fzRE/43+RA9aWdR0PNzLxBImHx3dtrzScniDV0PCUe/mIKry/7cdHr5gV
   XFLSUVjXWNgWvIIgTkdHiTw3/QgzzxrKUTZaq8Vf0WQxe9JWJCpR12TvE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296224895"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="296224895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 20:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="675705852"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="675705852"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2022 20:53:57 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0y3g-000DGh-2J;
        Fri, 02 Dec 2022 04:53:56 +0000
Date:   Fri, 02 Dec 2022 12:52:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 32975c491ee410598b33201344c123fcc81a7c33
Message-ID: <638984aa.fYLCne3NPPtKAJVg%lkp@intel.com>
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
branch HEAD: 32975c491ee410598b33201344c123fcc81a7c33  uapi: Add missing _UAPI prefix to <asm-generic/types.h> include guard

elapsed time: 723m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
powerpc                           allnoconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
ia64                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                  randconfig-r043-20221201
x86_64                              defconfig
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a002
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                             allyesconfig
i386                                defconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
xtensa                           alldefconfig
microblaze                          defconfig
powerpc                      arches_defconfig
powerpc                      tqm8xx_defconfig

clang tested configs:
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221201
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
