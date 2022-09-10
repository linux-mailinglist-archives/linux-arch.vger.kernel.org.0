Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A955B48DE
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIJUtV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIJUtU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 16:49:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD58840BC3
        for <linux-arch@vger.kernel.org>; Sat, 10 Sep 2022 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662842959; x=1694378959;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8vOxWuRyhOEgoBTygdEG3bDbNU/KIdDa4laXTaeZono=;
  b=WjzQnO3+m5XQWCnVj9x9AjV7pVKlNGEPQDHueVLDezwyb9vEOYo7BdJm
   U4D9MFdgFG9YYSoCpesD842KiK0/HvcWIYNRBYCUkIAzaOzhnnzfxkv3T
   /isaD4gn1nnqS414xtGEr6GSk2390nJkmIBElJW7N5LtJvKQ7b5lgU9B+
   e4+bBJKKOHK7/0YW+yF66nBbvKXD9a5aINf1kL5iuZ8bS7mcjG1tKqs1F
   HPafnCxkHqkkN3dXAfGdl6dyz1EhvsXf8XPGh2aCby9mAVvoVh+U2VNCL
   gbhGXBKb+cRpSqCUNaw/FC+kudqJMXy4LCCd2vjZ+hQ1zaSdYck9FraMZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="280690940"
X-IronPort-AV: E=Sophos;i="5.93,306,1654585200"; 
   d="scan'208";a="280690940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 13:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,306,1654585200"; 
   d="scan'208";a="677595171"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2022 13:49:17 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oX7Ph-0000SR-0k;
        Sat, 10 Sep 2022 20:49:17 +0000
Date:   Sun, 11 Sep 2022 04:48:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 773428ffd867d1ef116c041cdbc4890bee112854
Message-ID: <631cf815.L+IzNDITO8Qd5EgO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: 773428ffd867d1ef116c041cdbc4890bee112854  asm-generic: Remove empty #ifdef SA_RESTORER

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
i386                                defconfig
m68k                             allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
mips                             allyesconfig
arc                              allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
i386                          randconfig-a005
i386                          randconfig-a001
sh                               allmodconfig
arc                  randconfig-r043-20220908
i386                          randconfig-a003
riscv                randconfig-r042-20220908
x86_64                        randconfig-a015
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                        randconfig-a006
s390                 randconfig-r044-20220908
arc                  randconfig-r043-20220907
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a004
i386                          randconfig-a016
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
ia64                             allmodconfig
arm                              allyesconfig
i386                          randconfig-a012
arm64                            allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig

clang tested configs:
i386                          randconfig-a004
i386                          randconfig-a002
hexagon              randconfig-r041-20220908
hexagon              randconfig-r045-20220908
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220907
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
riscv                randconfig-r042-20220907
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
