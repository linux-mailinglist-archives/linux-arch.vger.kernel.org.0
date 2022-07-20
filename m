Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAA57B453
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jul 2022 12:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGTKO1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jul 2022 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTKO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jul 2022 06:14:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF457216
        for <linux-arch@vger.kernel.org>; Wed, 20 Jul 2022 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658312066; x=1689848066;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dRSM5jR52KAq/jubFaVko3r2v7MBMeYMIHNfklif2Xo=;
  b=CXAG6l+j0DzqGhMOR/VfDHusfMqOlrnb3Qg9J5tcKlTCJd6S8VQxHsq7
   MDKA7+qsIvfqHDss58qhIOPb+Ills7+IbknvG8j3Cu9vLBIe4Z3eftgZ8
   u8dg50c33C7N/BnL69BIIje/+7ybX8OUzyTImieNdmghyS06E1RBgy+pm
   seJKChC5TdcqpuDvA8giNoxC/lJ4P475nPT8YcegesoWbpdYCJ3qrLZME
   NDEUhkuwg1qmCNeRgIi3TXVa9/iOvhM6u6H7AsGSZTKfjc9q8tlTYMFeU
   +I7R7BZ8Fz6C6NhqSIJu3V4N6QYnokeL00ErSSNjVP5BpNonNk1GhdFp/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="284296596"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="284296596"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 03:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="665804861"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2022 03:14:25 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE6im-0000ND-GF;
        Wed, 20 Jul 2022 10:14:24 +0000
Date:   Wed, 20 Jul 2022 18:14:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic-fixes] BUILD REGRESSION
 2d0eabc8971edae11cf6f8ed9571a158b75996eb
Message-ID: <62d7d568.CctD1HqnB+o/lU0x%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic-fixes
branch HEAD: 2d0eabc8971edae11cf6f8ed9571a158b75996eb  tools: Fixed MIPS builds due to struct flock re-definition

Error/Warning: (recently discovered and may have been fixed)

drivers/char/mem.c:66:16: error: implicit declaration of function 'devmem_is_allowed'; did you mean 'page_is_allowed'? [-Werror=implicit-function-declaration]
kernel/resource.c:1124:13: error: implicit declaration of function 'devmem_is_allowed'; did you mean 'do_set_cpus_allowed'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allyesconfig
|   |-- drivers-char-mem.c:error:implicit-declaration-of-function-devmem_is_allowed
|   `-- kernel-resource.c:error:implicit-declaration-of-function-devmem_is_allowed
|-- arm64-allyesconfig
|   |-- drivers-char-mem.c:error:implicit-declaration-of-function-devmem_is_allowed
|   `-- kernel-resource.c:error:implicit-declaration-of-function-devmem_is_allowed
`-- riscv-randconfig-r011-20220718
    `-- drivers-char-mem.c:error:implicit-declaration-of-function-devmem_is_allowed

elapsed time: 730m

configs tested: 52
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64               randconfig-a013-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a014-20220718
x86_64               randconfig-a011-20220718
x86_64               randconfig-a016-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a013-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a015-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
arc                  randconfig-r043-20220718
riscv                randconfig-r042-20220718
s390                 randconfig-r044-20220718
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a001-20220718
i386                 randconfig-a003-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a004-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a005-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
