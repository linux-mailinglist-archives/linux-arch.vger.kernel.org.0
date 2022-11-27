Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB849639930
	for <lists+linux-arch@lfdr.de>; Sun, 27 Nov 2022 03:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiK0CkW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Nov 2022 21:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0CkW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Nov 2022 21:40:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C4C13F16
        for <linux-arch@vger.kernel.org>; Sat, 26 Nov 2022 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669516820; x=1701052820;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wAlFOlx9Pkc1rKh/sdg8KsA8mU6itfqn5lbHCwNaSCA=;
  b=XoasBI6Gtv3pFTk7EFR28M8/lRM2+xty5JrsaSPDSNDJcFx55BMTmojM
   q7U/CqKxn9gAt/R65OOJ/jF0WKLhMz5qYaNdCnW+Jkm5yGAUdd27SBLtR
   6FNOPL813ThtVWSyFAQfdxJAojSfvbK+fv58c/eAHllrfx5y02BxiXxpR
   V34zDlsoGBJo3rDDQmLtRfZmBwsD4EFZiQvhAb2W/nO3mPlOX/OJXcCNN
   3kZIJkXAAtPpOmX6Gih6z1E99wiM1twIG6PotqpWanw1skgGr9cpmhcTN
   XOq4xaVus3V0gR46a15fb8FTf3+2WLMFPMUAbuLMc5Pkr2XcNkIFVCuU3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="302211890"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="302211890"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 18:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="748961399"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="748961399"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2022 18:40:18 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oz7ac-0006j9-0m;
        Sun, 27 Nov 2022 02:40:18 +0000
Date:   Sun, 27 Nov 2022 10:40:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl] BUILD REGRESSION
 9a44a4401f3517a2475158925110f06179accabe
Message-ID: <6382ce02.GDWVLsVVutwVZlBA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl
branch HEAD: 9a44a4401f3517a2475158925110f06179accabe  arm64: generate 64-bit syscall.tbl

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202211260038.a8EFYhpS-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/loongarch/include/asm/atomic.h:23:25: error: expected identifier or '(' before string constant
arch/loongarch/include/asm/vdso/vdso.h:15:1: warning: empty declaration
arch/loongarch/include/asm/vdso/vdso.h:18:31: error: array type has incomplete element type 'struct vdso_pcpu_data'
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_adjtimex' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_clock_adjtime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_clock_getres' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_clock_gettime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_clock_nanosleep' undeclared here (not in a function); did you mean 'sys_clock_nanosleep'?
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_clock_settime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_futex' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_gettimeofday' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_io_getevents' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_io_pgetevents' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_mq_timedreceive' undeclared here (not in a function); did you mean 'sys_mq_timedreceive'?
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_mq_timedsend' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_nanosleep' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_ppoll' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_pselect6' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_recvmmsg' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_rt_sigtimedwait' undeclared here (not in a function); did you mean 'sys_rt_sigtimedwait'?
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_sched_rr_get_interval' undeclared here (not in a function); did you mean 'sys_sched_rr_get_interval'?
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_semtimedop' undeclared here (not in a function); did you mean '__do_semtimedop'?
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_settimeofday' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_timer_gettime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_timer_settime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_timerfd_gettime' undeclared here (not in a function); did you mean 'sys_timerfd_gettime'?
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_timerfd_settime' undeclared here (not in a function); did you mean 'sys_timerfd_settime'?
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_utimensat' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: '__NR___NR_wait4' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:33:51: error: array index in initializer not of integer type
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_adjtimex' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_clock_adjtime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_clock_getres' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_clock_gettime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_clock_nanosleep' undeclared here (not in a function); did you mean 'sys_clock_nanosleep'?
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_clock_settime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_futex' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_gettimeofday' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_io_getevents' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_io_pgetevents' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_mq_timedreceive' undeclared here (not in a function); did you mean 'sys_mq_timedreceive'?
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_mq_timedsend' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_nanosleep' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_ppoll' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_pselect6' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_recvmmsg' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_rt_sigtimedwait' undeclared here (not in a function); did you mean 'sys_rt_sigtimedwait'?
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_sched_rr_get_interval' undeclared here (not in a function); did you mean 'sys_sched_rr_get_interval'?
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_semtimedop' undeclared here (not in a function); did you mean '__do_semtimedop'?
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_settimeofday' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_timer_gettime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_timer_settime' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_timerfd_gettime' undeclared here (not in a function); did you mean 'sys_timerfd_gettime'?
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_timerfd_settime' undeclared here (not in a function); did you mean 'sys_timerfd_settime'?
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_utimensat' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: '__NR___NR_wait4' undeclared here (not in a function)
include/uapi/asm-generic/unistd.h:38:51: error: array index in initializer not of integer type

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_adjtimex-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_adjtime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_getres-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_gettime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_nanosleep-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_settime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_futex-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_gettimeofday-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_io_getevents-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_io_pgetevents-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_mq_timedreceive-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_mq_timedsend-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_nanosleep-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_ppoll-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_pselect6-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_recvmmsg-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_rt_sigtimedwait-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_sched_rr_get_interval-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_semtimedop-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_settimeofday-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_timer_gettime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_timer_settime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_timerfd_gettime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_timerfd_settime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_utimensat-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_wait4-undeclared-here-(not-in-a-function)
|   `-- include-uapi-asm-generic-unistd.h:error:array-index-in-initializer-not-of-integer-type
|-- arc-defconfig
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_adjtimex-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_adjtime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_getres-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_gettime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_nanosleep-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_clock_settime-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_futex-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_gettimeofday-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_io_getevents-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_io_pgetevents-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_mq_timedreceive-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_mq_timedsend-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_nanosleep-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_ppoll-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_pselect6-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_recvmmsg-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_rt_sigtimedwait-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_sched_rr_get_interval-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_semtimedop-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_settimeofday-undeclared-here-(not-in-a-function)
|   |-- include-uapi-asm-generic-unistd.h:error:__NR___NR_timer_gettime-undeclared-here-(not-in-a-function)

elapsed time: 2160m

configs tested: 56
configs skipped: 2

gcc tested configs:
arc                  randconfig-r043-20221124
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                        randconfig-a015
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig

clang tested configs:
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
