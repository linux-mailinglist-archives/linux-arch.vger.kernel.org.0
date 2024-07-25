Return-Path: <linux-arch+bounces-5627-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729C93BCA0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 08:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25EC1F23C7C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jul 2024 06:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2C5589A;
	Thu, 25 Jul 2024 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eE6JIhC6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB516C87D
	for <linux-arch@vger.kernel.org>; Thu, 25 Jul 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889536; cv=none; b=pIsL08W9e+0mB8HI8W9q0H0HsrZV1RuAXV5HQjhk4dv+XZTnarUA2y9ZJhBCYnlkqrRwFC8VwkDlf+NS9KJr5NEsX22GMR5gG1nIe9vMGWdtYsbSCYglQ9QY721yY8c+HKSeJD+i+ZVno/t14VUh8f/8k01dm+GFOn5CRDys07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889536; c=relaxed/simple;
	bh=Aky7SXoXyDv6JngM+2VvzsvtiuEL2FnDFUgffCmpclo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jKQX6b9syKtlbLjSZSSyiJRopZO5F/hYPJTjMw0wtPKpQP3VXiP4TePfur7srPA/tr/Mo2jk2Lt2wlOarjRUb+/F4iYJTpG5dHjKQ5S8n6d67Qy8C2/3PJeyckn7ShmgZuYZdNEic/7YNyiRbnPyAbg++eRu8ihIVfUVzAxUbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eE6JIhC6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721889534; x=1753425534;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aky7SXoXyDv6JngM+2VvzsvtiuEL2FnDFUgffCmpclo=;
  b=eE6JIhC6Mt54n0awvQU4ivhFRm8HvlOaZ5AfgcjF0F9gOth2S+aoJAcA
   7T17paIRZnmZEwDor9XBOMAQy68UCe+I6w80eI+j3BYx2vwjjnigl6n+t
   wjdbLgV8MmMmvuPlk3Zcdfm62gFfQQtpmsoVLvdYvuuJ4+BJd2Oa+W82/
   tQ3X3VAeNzA7y1JBZaj0z2xmevJFxLM+BMpj24mqVLwocwMHF+IIgX1Gb
   msccX9wM0ViQfI4DScvfByoiAYVbxvbndq1agoDFiSdlgADcrMgDpzemc
   TzdXg2WfPpn75G52r17UpqXmw6fdX7TqUZ/h+VwvrMafgjvkEEvZlzu46
   Q==;
X-CSE-ConnectionGUID: zYi9bniRQrCGIJE6lxDdBg==
X-CSE-MsgGUID: YlKVTHTvQzm17rxTtqS5hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19730221"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19730221"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 23:38:54 -0700
X-CSE-ConnectionGUID: GdkYTEu9TJG1V/mfIZWUHg==
X-CSE-MsgGUID: Qn31EqdVSHqk5IXK1ah2VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="57124791"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jul 2024 23:38:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWs7m-000nqR-0s;
	Thu, 25 Jul 2024 06:38:50 +0000
Date: Thu, 25 Jul 2024 14:38:06 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 77/80]
 arch/x86/um/syscalls_64.c:56:1: error: use of undeclared identifier
 'sys_mmap'
Message-ID: <202407251452.Dcas8eTI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   ece1b5ebc0b7064a8a130f64e85a81ec76381c3f
commit: ce67487a0460367a60a68fa3de3e66b8caaa3b7c [77/80] syscalls: check syscall prototypes
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240725/202407251452.Dcas8eTI-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407251452.Dcas8eTI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407251452.Dcas8eTI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/syscalls_64.c:10:
   In file included from include/linux/syscalls.h:86:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2221:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from arch/x86/um/syscalls_64.c:10:
   In file included from include/linux/syscalls.h:86:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from arch/x86/um/syscalls_64.c:10:
   In file included from include/linux/syscalls.h:86:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from arch/x86/um/syscalls_64.c:10:
   In file included from include/linux/syscalls.h:86:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> arch/x86/um/syscalls_64.c:56:1: error: use of undeclared identifier 'sys_mmap'
      56 | SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
         | ^
   include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE6'
     221 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:229:2: note: expanded from macro 'SYSCALL_DEFINEx'
     229 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:247:28: note: expanded from macro '__SYSCALL_DEFINEx'
     247 |                 (void)(__do_sys##name == sys##name);                    \
         |                                          ^
   <scratch space>:190:1: note: expanded from here
     190 | sys_mmap
         | ^
   13 warnings and 1 error generated.


vim +/sys_mmap +56 arch/x86/um/syscalls_64.c

577ade59b99e34 Al Viro 2021-09-20  55  
577ade59b99e34 Al Viro 2021-09-20 @56  SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,

:::::: The code at line 56 was first introduced by commit
:::::: 577ade59b99e3473b2f1342b1eb9e496eed39b68 um: move amd64 variant of mmap(2) to arch/x86/um/syscalls_64.c

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Richard Weinberger <richard@nod.at>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

