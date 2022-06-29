Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E96055F231
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiF2ADo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 20:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiF2ADn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 20:03:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7EB7E8
        for <linux-arch@vger.kernel.org>; Tue, 28 Jun 2022 17:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656461022; x=1687997022;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AkhL1qarJ7uRcWbPCvOqJRq1JXTBxhnx9ParOHQ5oGE=;
  b=jUe6oQ88pC8ULIaq3UH5QnJKs8+F8J9cTrKpui4khtrpyXx5bmoWXjIt
   WkcS/lg9hiI5/wZpXP0iFJWhSSHVrwKjlXIsFHNGmGH4MAnIjMht3yK2e
   wA5u2sTygKkThCmj17fGmXSbJLsSpoD+M9eAb2W8nnV74y63CzwIDA10M
   4duOx2lsTK16GnVTBg4MLOEY192or5i7FHOiL9RLjp/qzyPL3MDEunXMw
   HIoj0swt2Ws/Tte5ZS3dURhvgexmXhJ0MiMf3uZalaUNcMMcFuwQ+pqkO
   CMGXqaXcDJeS7Yf7UWgyeoi6oLt2a4sGa4N05Oj+Y1jn1kO33Po8M/I+c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264918976"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="264918976"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="836887822"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2022 17:03:40 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6LBE-000AlC-5i;
        Wed, 29 Jun 2022 00:03:40 +0000
Date:   Wed, 29 Jun 2022 08:03:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 4313a24985f00340eeb591fd66aa2b257b9e0a69
Message-ID: <62bb96d0.InZDtNeE9fN3BuUf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 4313a24985f00340eeb591fd66aa2b257b9e0a69  arch/*/: remove CONFIG_VIRT_TO_BUS

elapsed time: 723m

configs tested: 73
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                               j2_defconfig
sh                           se7343_defconfig
parisc64                         alldefconfig
powerpc                      ppc40x_defconfig
arm                        realview_defconfig
arm                            pleb_defconfig
parisc64                            defconfig
arm                          pxa910_defconfig
arm                            hisi_defconfig
arc                     nsimosci_hs_defconfig
arm                        cerfcube_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7712_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20220627
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a013-20220627
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a014-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a013-20220627
riscv                randconfig-r042-20220627
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
arm                      pxa255-idp_defconfig
arm                            dove_defconfig
x86_64               randconfig-a006-20220627
x86_64               randconfig-a004-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
i386                 randconfig-a002-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a006-20220627
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
