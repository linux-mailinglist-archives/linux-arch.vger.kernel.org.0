Return-Path: <linux-arch+bounces-5483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B7934568
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 02:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4091C21404
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F9C10FA;
	Thu, 18 Jul 2024 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4UQNO8G"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66E2C1AC
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721262670; cv=none; b=MFujE5oZ+dmFBSxq1Ciy5N+lXqm9tnbTqxCm26GjXtLoDUEKKqiLJuIWQbaL5suI+FKoXIgsepWcdc9I77U84NnXBDtp309lL3QmNHEec3fmzwus8YzbMDGJsUvTQels6jA13BysFmO0Wxd6K5R193qWqQrbFPTC2Mcl+KsW0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721262670; c=relaxed/simple;
	bh=qx5tErHCf47J8iStfXqd3J78Y35jFuseArEtxyHiIt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dbJ2IA+OwdyU4dzcjSJkcXZmKUr+B8QslXaPtASHMBNS2kY3tPLO/sZziKU8xNAOJGHmvNpBlPycgHkHBaNwPLZCMvtM9bslMmgMGgHu18t1HLVdH6rTaJaj9Z9y/+cUxyObXGJOwvRJrESPwDvy/h81z2EBNFwnA+xTYV6vFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4UQNO8G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721262668; x=1752798668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qx5tErHCf47J8iStfXqd3J78Y35jFuseArEtxyHiIt4=;
  b=D4UQNO8Gz53kF5ogzfSv8NIDwquPTSk8Pk+ZJ8CDwpJI/EOr+Z/5b9Qt
   AYf7uom4H9keIx057/fJ8kGUD5NVxMAj9ESRoAEefb0HU5vSoin6ucgen
   MfyIqorPBeWWpd2BYW5OGTcdljAVnvxTziRd1Wy6k1ttIr9Ia7n4tyr80
   H89O8pdO5XviDW+d0q0F4eDUjp/7YTCUjMYeL4lpb29MrxNwQiRdyWJ8J
   5CmFPjvFhXIAdalEC/k2duvnehq8ksnRPG2zoItzXIfaFn18nOx8dIG1L
   wMHwJQotjRD1eOxQPeVLfVoEt617MElk9E/+bNZy3ZonAeW6juRkSgZ6t
   A==;
X-CSE-ConnectionGUID: BpFhbuoiSa+ueWSecui4lg==
X-CSE-MsgGUID: lL2Cd80aSpGlqfZd8efF5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29415490"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="29415490"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 17:31:06 -0700
X-CSE-ConnectionGUID: 0YB8OA8pRoymnzIK+bbgvw==
X-CSE-MsgGUID: fAl0a9BNT4+5iWhz0nsWew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="50295325"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jul 2024 17:31:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUF30-000gna-1V;
	Thu, 18 Jul 2024 00:31:02 +0000
Date: Thu, 18 Jul 2024 08:30:20 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 92/98]
 arch/arm64/include/asm/syscalls.h:11:75: error: unknown type name
 'compat_size_t'; did you mean 'compat_sp_abt'?
Message-ID: <202407180852.frUNVOxd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   9a99991d90521113a738c2a4761a4147fe4b31ca
commit: d079d82a6231c5cb40ba4b46f9d0634a36051523 [92/98] syscalls: check syscall prototypes
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240718/202407180852.frUNVOxd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180852.frUNVOxd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180852.frUNVOxd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/syscalls.h:84,
                    from arch/arm64/kernel/sys.c:16:
>> arch/arm64/include/asm/syscalls.h:11:75: error: unknown type name 'compat_size_t'; did you mean 'compat_sp_abt'?
      11 | asmlinkage long compat_sys_aarch32_statfs64(const char __user * pathname, compat_size_t sz, struct compat_statfs64 __user * buf);
         |                                                                           ^~~~~~~~~~~~~
         |                                                                           compat_sp_abt
   arch/arm64/include/asm/syscalls.h:12:63: error: unknown type name 'compat_size_t'; did you mean 'compat_sp_abt'?
      12 | asmlinkage long compat_sys_aarch32_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user * buf);
         |                                                               ^~~~~~~~~~~~~
         |                                                               compat_sp_abt
   arch/arm64/kernel/sys.c:59:40: warning: initialized field overwritten [-Woverride-init]
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:52:52: note: in expansion of macro '__SYSCALL'
      52 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:1:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       1 | __SYSCALL_WITH_COMPAT(0, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: note: (near initialization for 'sys_call_table[0]')
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:52:52: note: in expansion of macro '__SYSCALL'
      52 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:1:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       1 | __SYSCALL_WITH_COMPAT(0, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: warning: initialized field overwritten [-Woverride-init]
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:2:1: note: in expansion of macro '__SYSCALL'
       2 | __SYSCALL(1, sys_io_destroy)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: note: (near initialization for 'sys_call_table[1]')
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:2:1: note: in expansion of macro '__SYSCALL'
       2 | __SYSCALL(1, sys_io_destroy)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: warning: initialized field overwritten [-Woverride-init]
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:52:52: note: in expansion of macro '__SYSCALL'
      52 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:3:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       3 | __SYSCALL_WITH_COMPAT(2, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: note: (near initialization for 'sys_call_table[2]')
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:52:52: note: in expansion of macro '__SYSCALL'
      52 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:3:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       3 | __SYSCALL_WITH_COMPAT(2, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: warning: initialized field overwritten [-Woverride-init]
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:4:1: note: in expansion of macro '__SYSCALL'
       4 | __SYSCALL(3, sys_io_cancel)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: note: (near initialization for 'sys_call_table[3]')
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:4:1: note: in expansion of macro '__SYSCALL'
       4 | __SYSCALL(3, sys_io_cancel)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: warning: initialized field overwritten [-Woverride-init]
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:5:1: note: in expansion of macro '__SYSCALL'
       5 | __SYSCALL(4, sys_io_getevents)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: note: (near initialization for 'sys_call_table[4]')
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:5:1: note: in expansion of macro '__SYSCALL'
       5 | __SYSCALL(4, sys_io_getevents)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: warning: initialized field overwritten [-Woverride-init]
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:6:1: note: in expansion of macro '__SYSCALL'
       6 | __SYSCALL(5, sys_setxattr)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: note: (near initialization for 'sys_call_table[5]')
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:6:1: note: in expansion of macro '__SYSCALL'
       6 | __SYSCALL(5, sys_setxattr)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: warning: initialized field overwritten [-Woverride-init]
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:7:1: note: in expansion of macro '__SYSCALL'
       7 | __SYSCALL(6, sys_lsetxattr)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:59:40: note: (near initialization for 'sys_call_table[6]')
      59 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
--
   In file included from include/linux/syscalls.h:84,
                    from arch/arm64/kernel/syscall.c:9:
>> arch/arm64/include/asm/syscalls.h:11:75: error: unknown type name 'compat_size_t'; did you mean 'compat_sp_abt'?
      11 | asmlinkage long compat_sys_aarch32_statfs64(const char __user * pathname, compat_size_t sz, struct compat_statfs64 __user * buf);
         |                                                                           ^~~~~~~~~~~~~
         |                                                                           compat_sp_abt
   arch/arm64/include/asm/syscalls.h:12:63: error: unknown type name 'compat_size_t'; did you mean 'compat_sp_abt'?
      12 | asmlinkage long compat_sys_aarch32_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user * buf);
         |                                                               ^~~~~~~~~~~~~
         |                                                               compat_sp_abt


vim +11 arch/arm64/include/asm/syscalls.h

40504bb779d375 Arnd Bergmann 2024-06-04  10  
40504bb779d375 Arnd Bergmann 2024-06-04 @11  asmlinkage long compat_sys_aarch32_statfs64(const char __user * pathname, compat_size_t sz, struct compat_statfs64 __user * buf);
40504bb779d375 Arnd Bergmann 2024-06-04  12  asmlinkage long compat_sys_aarch32_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user * buf);
40504bb779d375 Arnd Bergmann 2024-06-04  13  asmlinkage long compat_sys_aarch32_mmap2(unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags, unsigned long fd, unsigned long off_4k);
40504bb779d375 Arnd Bergmann 2024-06-04  14  

:::::: The code at line 11 was first introduced by commit
:::::: 40504bb779d37533d0c7f68d612b17c5e5f9a4a5 arm64: add asm/syscalls.h

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

