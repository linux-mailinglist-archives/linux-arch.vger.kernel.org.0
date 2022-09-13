Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0565B69CE
	for <lists+linux-arch@lfdr.de>; Tue, 13 Sep 2022 10:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIMIq7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Sep 2022 04:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIMIq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Sep 2022 04:46:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD26E46603
        for <linux-arch@vger.kernel.org>; Tue, 13 Sep 2022 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663058817; x=1694594817;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KxJFdtMzb2ziciecsE18urplRXRqyatQuS0pO3ECIR0=;
  b=ESaVKMQOejXFSAmAYNOoRVPIZpPn2EbciiKRC33V/bAJNfFEg7CQrwm7
   JSxCRbNGD+9Hn90c1Q18qVL2KEVJDQBMPiFRP6XybXhDMBr/gkTJukaZ+
   bw7Zkv8shZhGdC8Qs8VRwzQjRkH3EAXOj4q7YmYftC9XJLDBzRfVrN/QQ
   I9CgTuxMnBTmSrD5IjHLsUYT6zciQ5/wEdmmX+xIAK6is7fTmxfLTxgvI
   0jUnuTVV0nTlcfsmHQmTqqakTpA0Y7zVpY/MYWojCoafRho7fQZ1BXPTb
   NK5HMc7fy+VD0pVzblE9lqBw0Gr3+G1oUbU6sjpmmUciec0zL0hr2gtXl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298880819"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="298880819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 01:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="861472062"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2022 01:46:56 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oY1ZH-0003Py-1h;
        Tue, 13 Sep 2022 08:46:55 +0000
Date:   Tue, 13 Sep 2022 16:46:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:asm-generic] BUILD SUCCESS
 fdc5bebfb66bf0d261818c2df2b01c2a005791fe
Message-ID: <63204372.5zSTRm5sh8Fscxyy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
branch HEAD: fdc5bebfb66bf0d261818c2df2b01c2a005791fe  parisc: hide ioread64 declaration on 32-bit

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a001-20220912
i386                 randconfig-a002-20220912
i386                 randconfig-a003-20220912
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
mips                             allyesconfig
i386                 randconfig-a005-20220912
powerpc                           allnoconfig
x86_64                              defconfig
i386                                defconfig
i386                 randconfig-a004-20220912
i386                 randconfig-a006-20220912
x86_64               randconfig-a005-20220912
x86_64                               rhel-8.3
x86_64               randconfig-a006-20220912
sh                               allmodconfig
m68k                             allmodconfig
x86_64               randconfig-a001-20220912
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a002-20220912
x86_64               randconfig-a003-20220912
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a004-20220912
alpha                            allyesconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220912
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                          rhel-8.3-func
arm                              allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20220911
arm64                            allyesconfig
riscv                randconfig-r042-20220911
ia64                             allmodconfig
s390                 randconfig-r044-20220911

clang tested configs:
i386                 randconfig-a015-20220912
i386                 randconfig-a014-20220912
i386                 randconfig-a016-20220912
i386                 randconfig-a011-20220912
i386                 randconfig-a012-20220912
hexagon              randconfig-r041-20220912
i386                 randconfig-a013-20220912
hexagon              randconfig-r045-20220912
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220911
x86_64               randconfig-a012-20220912
x86_64               randconfig-a013-20220912
x86_64               randconfig-a014-20220912
x86_64               randconfig-a011-20220912
x86_64               randconfig-a015-20220912
riscv                randconfig-r042-20220912
x86_64               randconfig-a016-20220912
s390                 randconfig-r044-20220912

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
