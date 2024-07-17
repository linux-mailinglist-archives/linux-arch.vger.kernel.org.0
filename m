Return-Path: <linux-arch+bounces-5477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A49343C4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 23:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB141F21F1E
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88032033A;
	Wed, 17 Jul 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5zO2m/2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DD1CD26
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251415; cv=none; b=H3P5ZsPjsxauwq6MBbtVxHNFq/iztLoNUFsUSXwzoX80J00FKV0P5CgAWMk1DiBs5zHf4DqyBwgMDULKMbmOwd8WFpTlwzaWGadubv+85Sd8LB9FbXTn5wLfnYfvZJKZ2xv/YcUTTDZP5fTkO815a/QAoo/v5sn/cTTHmaiEAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251415; c=relaxed/simple;
	bh=ES6YUwPVcPVKql9jDKofl0nY+TmjCAK8ZbKslSmMH5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NmnkqGX3SRxyn/IG3iXtsLMXeJZ4FPzELDruv3xA0ANk8KhN7yBQ+FJJafzKJXKpM4MKZ0DBJ+yPBZJcWUR8rdxp1cNdahDosyJjOVULkKrXT1zwZo8LDT7oPgSlSrlby1V2MN2CYZuvHHtNvnTvLcYcxT+bFsjAF9BLgy8XH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5zO2m/2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721251409; x=1752787409;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ES6YUwPVcPVKql9jDKofl0nY+TmjCAK8ZbKslSmMH5Y=;
  b=Q5zO2m/2z2Gyb3xT+8HQuY2nmITUuXpxDEk3vahZgRmg+cufJNd9wuI4
   luoJAljsqi8kD0XJxKUE7VJ6fR9awMtZ4BHyKScip4BlMU6ueADtJQsCx
   IdBWgITSXkKkkiZjr4aiMjMKnSQ/zdaxq45P73reREknxE/IKjAxhmg04
   3hvPV2Y9tKK2LMs1fAhQXJwk/dNV+XVpnIrlfzDcIWK7Avfu31ZeF5o3i
   YMUYEd5AoHnE51z3XY6YdN8wuykv2gablx6ZWijJZa0KjUDFID7KGSMZF
   UxGUrn/Izj77UKOoh2P/v2G1H1vT/uDBDHvfPLhyu7Ki7PWLt52q22dFp
   A==;
X-CSE-ConnectionGUID: +kvimmFWQtGYkTX3dtVNow==
X-CSE-MsgGUID: gUGty79IRkeSisBGhXzqvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18926743"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="18926743"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 14:21:42 -0700
X-CSE-ConnectionGUID: 4hH3740uSiCuxsGlyaLAfQ==
X-CSE-MsgGUID: jQXPK2YXT1SAnd8bPSfOFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="55368865"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Jul 2024 14:21:40 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUC5h-000gg9-2k;
	Wed, 17 Jul 2024 21:21:37 +0000
Date: Thu, 18 Jul 2024 05:21:03 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 92/98] fs/open.c:1443:1: warning:
 comparison of distinct pointer types ('long (*)(int, const char *, struct
 open_how *, size_t)' (aka 'long (*)(int, const char *, struct open_how *,
 unsigned int)') and 'long (*)(int, const char *, struct open_how *, size_t)'
 (ak...
Message-ID: <202407180559.Fx7UMDJy-lkp@intel.com>
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
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240718/202407180559.Fx7UMDJy-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180559.Fx7UMDJy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180559.Fx7UMDJy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from block/ioprio.c:27:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from block/ioprio.c:27:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from block/ioprio.c:27:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
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
>> block/ioprio.c:69:1: warning: comparison of distinct pointer types ('long (*)(int, int, int)' and 'long (*)(int, int, int)') [-Wcompare-distinct-pointer-types]
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> block/ioprio.c:184:1: warning: comparison of distinct pointer types ('long (*)(int, int)' and 'long (*)(int, int)') [-Wcompare-distinct-pointer-types]
     184 | SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: expanded from macro 'SYSCALL_DEFINE2'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   14 warnings generated.
--
   In file included from fs/open.c:14:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from fs/open.c:14:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/open.c:14:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
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
>> fs/open.c:144:1: warning: comparison of distinct pointer types ('long (*)(const char *, long)' and 'long (*)(const char *, long)') [-Wcompare-distinct-pointer-types]
     144 | SYSCALL_DEFINE2(truncate, const char __user *, path, long, length)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: expanded from macro 'SYSCALL_DEFINE2'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:205:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, off_t)' (aka 'long (*)(unsigned int, long)') and 'long (*)(unsigned int, off_t)' (aka 'long (*)(unsigned int, long)')) [-Wcompare-distinct-pointer-types]
     205 | SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: expanded from macro 'SYSCALL_DEFINE2'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:220:1: warning: comparison of distinct pointer types ('long (*)(const char *, u32, u32)' (aka 'long (*)(const char *, unsigned int, unsigned int)') and 'long (*)(const char *, u32, u32)' (aka 'long (*)(const char *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
     220 | SYSCALL_DEFINE3(truncate3, const char __user *, pathname, SC_ARG64(length))
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:234:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, u32, u32)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)') and 'long (*)(unsigned int, u32, u32)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
     234 | SYSCALL_DEFINE3(ftruncate3, unsigned int, fd, SC_ARG64(length))
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:369:1: warning: comparison of distinct pointer types ('long (*)(int, int, u32, u32, u32, u32)' (aka 'long (*)(int, int, unsigned int, unsigned int, unsigned int, unsigned int)') and 'long (*)(int, int, u32, u32, u32, u32)' (aka 'long (*)(int, int, unsigned int, unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
     369 | SYSCALL_DEFINE6(fallocate6, int, fd, int, mode, SC_ARG64(offset),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     370 |                 SC_ARG64(len))
         |                 ~~~~~~~~~~~~~~
   include/linux/syscalls.h:220:36: note: expanded from macro 'SYSCALL_DEFINE6'
     220 | #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:540:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int)' and 'long (*)(int, const char *, int)') [-Wcompare-distinct-pointer-types]
     540 | SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:545:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, int)' and 'long (*)(int, const char *, int, int)') [-Wcompare-distinct-pointer-types]
     545 | SYSCALL_DEFINE4(faccessat2, int, dfd, const char __user *, filename, int, mode,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     546 |                 int, flags)
         |                 ~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: expanded from macro 'SYSCALL_DEFINE4'
     218 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:551:1: warning: comparison of distinct pointer types ('long (*)(const char *, int)' and 'long (*)(const char *, int)') [-Wcompare-distinct-pointer-types]
     551 | SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: expanded from macro 'SYSCALL_DEFINE2'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:556:1: warning: comparison of distinct pointer types ('long (*)(const char *)' and 'long (*)(const char *)') [-Wcompare-distinct-pointer-types]
     556 | SYSCALL_DEFINE1(chdir, const char __user *, filename)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:36: note: expanded from macro 'SYSCALL_DEFINE1'
     215 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:582:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
     582 | SYSCALL_DEFINE1(fchdir, unsigned int, fd)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:36: note: expanded from macro 'SYSCALL_DEFINE1'
     215 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   fs/open.c:604:1: warning: comparison of distinct pointer types ('long (*)(const char *)' and 'long (*)(const char *)') [-Wcompare-distinct-pointer-types]
     604 | SYSCALL_DEFINE1(chroot, const char __user *, filename)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:36: note: expanded from macro 'SYSCALL_DEFINE1'
     215 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:673:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, umode_t)' (aka 'long (*)(unsigned int, unsigned short)') and 'long (*)(unsigned int, umode_t)' (aka 'long (*)(unsigned int, unsigned short)')) [-Wcompare-distinct-pointer-types]
     673 | SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: expanded from macro 'SYSCALL_DEFINE2'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:712:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, umode_t, unsigned int)' (aka 'long (*)(int, const char *, unsigned short, unsigned int)') and 'long (*)(int, const char *, umode_t, unsigned int)' (aka 'long (*)(int, const char *, unsigned short, unsigned int)')) [-Wcompare-distinct-pointer-types]
     712 | SYSCALL_DEFINE4(fchmodat2, int, dfd, const char __user *, filename,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     713 |                 umode_t, mode, unsigned int, flags)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: expanded from macro 'SYSCALL_DEFINE4'
     218 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:718:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, umode_t)' (aka 'long (*)(int, const char *, unsigned short)') and 'long (*)(int, const char *, umode_t)' (aka 'long (*)(int, const char *, unsigned short)')) [-Wcompare-distinct-pointer-types]
     718 | SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     719 |                 umode_t, mode)
         |                 ~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:724:1: warning: comparison of distinct pointer types ('long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)') and 'long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)')) [-Wcompare-distinct-pointer-types]
     724 | SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: expanded from macro 'SYSCALL_DEFINE2'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:837:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, uid_t, gid_t, int)' (aka 'long (*)(int, const char *, unsigned int, unsigned int, int)') and 'long (*)(int, const char *, uid_t, gid_t, int)' (aka 'long (*)(int, const char *, unsigned int, unsigned int, int)')) [-Wcompare-distinct-pointer-types]
     837 | SYSCALL_DEFINE5(fchownat, int, dfd, const char __user *, filename, uid_t, user,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     838 |                 gid_t, group, int, flag)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE5'
     219 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:843:1: warning: comparison of distinct pointer types ('long (*)(const char *, uid_t, gid_t)' (aka 'long (*)(const char *, unsigned int, unsigned int)') and 'long (*)(const char *, uid_t, gid_t)' (aka 'long (*)(const char *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
     843 | SYSCALL_DEFINE3(chown, const char __user *, filename, uid_t, user, gid_t, group)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   fs/open.c:848:1: warning: comparison of distinct pointer types ('long (*)(const char *, uid_t, gid_t)' (aka 'long (*)(const char *, unsigned int, unsigned int)') and 'long (*)(const char *, uid_t, gid_t)' (aka 'long (*)(const char *, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
     848 | SYSCALL_DEFINE3(lchown, const char __user *, filename, uid_t, user, gid_t, group)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:879:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, uid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)') and 'long (*)(unsigned int, uid_t, gid_t)' (aka 'long (*)(unsigned int, unsigned int, unsigned int)')) [-Wcompare-distinct-pointer-types]
     879 | SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:1428:1: warning: comparison of distinct pointer types ('long (*)(const char *, int, umode_t)' (aka 'long (*)(const char *, int, unsigned short)') and 'long (*)(const char *, int, umode_t)' (aka 'long (*)(const char *, int, unsigned short)')) [-Wcompare-distinct-pointer-types]
    1428 | SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:1435:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, int, umode_t)' (aka 'long (*)(int, const char *, int, unsigned short)') and 'long (*)(int, const char *, int, umode_t)' (aka 'long (*)(int, const char *, int, unsigned short)')) [-Wcompare-distinct-pointer-types]
    1435 | SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1436 |                 umode_t, mode)
         |                 ~~~~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: expanded from macro 'SYSCALL_DEFINE4'
     218 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
>> fs/open.c:1443:1: warning: comparison of distinct pointer types ('long (*)(int, const char *, struct open_how *, size_t)' (aka 'long (*)(int, const char *, struct open_how *, unsigned int)') and 'long (*)(int, const char *, struct open_how *, size_t)' (aka 'long (*)(int, const char *, struct open_how *, unsigned int)')) [-Wcompare-distinct-pointer-types]
    1443 | SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1444 |                 struct open_how __user *, how, size_t, usize)
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:218:36: note: expanded from macro 'SYSCALL_DEFINE4'
     218 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   fs/open.c:1494:1: warning: comparison of distinct pointer types ('long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)') and 'long (*)(const char *, umode_t)' (aka 'long (*)(const char *, unsigned short)')) [-Wcompare-distinct-pointer-types]
    1494 | SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:216:36: note: expanded from macro 'SYSCALL_DEFINE2'
     216 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   fs/open.c:1544:1: warning: comparison of distinct pointer types ('long (*)(unsigned int)' and 'long (*)(unsigned int)') [-Wcompare-distinct-pointer-types]
    1544 | SYSCALL_DEFINE1(close, unsigned int, fd)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:215:36: note: expanded from macro 'SYSCALL_DEFINE1'
     215 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   fs/open.c:1582:1: warning: comparison of distinct pointer types ('long (*)(unsigned int, unsigned int, unsigned int)' and 'long (*)(unsigned int, unsigned int, unsigned int)') [-Wcompare-distinct-pointer-types]
    1582 | SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1583 |                 unsigned int, flags)
         |                 ~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:217:36: note: expanded from macro 'SYSCALL_DEFINE3'
     217 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
     228 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:245:25: note: expanded from macro '__SYSCALL_DEFINEx'
     245 |                 (void)(__do_sys##name == sys##name);                    \
         |                        ~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   37 warnings generated.
..


vim +1443 fs/open.c

e922efc342d565 Miklos Szeredi          2005-09-06  1426  
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1427  
fddb5d430ad9fa Aleksa Sarai            2020-01-18 @1428  SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1429  {
166e07c37c6417 Christoph Hellwig       2020-06-06  1430  	if (force_o_largefile())
166e07c37c6417 Christoph Hellwig       2020-06-06  1431  		flags |= O_LARGEFILE;
166e07c37c6417 Christoph Hellwig       2020-06-06  1432  	return do_sys_open(AT_FDCWD, filename, flags, mode);
e922efc342d565 Miklos Szeredi          2005-09-06  1433  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1434  
6559eed8ca7db0 Heiko Carstens          2009-01-14 @1435  SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags,
a218d0fdc5f900 Al Viro                 2011-11-21  1436  		umode_t, mode)
5590ff0d5528b6 Ulrich Drepper          2006-01-18  1437  {
5590ff0d5528b6 Ulrich Drepper          2006-01-18  1438  	if (force_o_largefile())
5590ff0d5528b6 Ulrich Drepper          2006-01-18  1439  		flags |= O_LARGEFILE;
2cf0966683430b Al Viro                 2013-01-21  1440  	return do_sys_open(dfd, filename, flags, mode);
5590ff0d5528b6 Ulrich Drepper          2006-01-18  1441  }
5590ff0d5528b6 Ulrich Drepper          2006-01-18  1442  
fddb5d430ad9fa Aleksa Sarai            2020-01-18 @1443  SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1444  		struct open_how __user *, how, size_t, usize)
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1445  {
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1446  	int err;
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1447  	struct open_how tmp;
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1448  
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1449  	BUILD_BUG_ON(sizeof(struct open_how) < OPEN_HOW_SIZE_VER0);
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1450  	BUILD_BUG_ON(sizeof(struct open_how) != OPEN_HOW_SIZE_LATEST);
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1451  
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1452  	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1453  		return -EINVAL;
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1454  
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1455  	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1456  	if (err)
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1457  		return err;
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1458  
571e5c0efcb29c Richard Guy Briggs      2021-05-19  1459  	audit_openat2_how(&tmp);
571e5c0efcb29c Richard Guy Briggs      2021-05-19  1460  
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1461  	/* O_LARGEFILE is only allowed for non-O_PATH. */
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1462  	if (!(tmp.flags & O_PATH) && force_o_largefile())
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1463  		tmp.flags |= O_LARGEFILE;
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1464  
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1465  	return do_sys_openat2(dfd, filename, &tmp);
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1466  }
fddb5d430ad9fa Aleksa Sarai            2020-01-18  1467  
e35d49f637d5ce Al Viro                 2017-04-08  1468  #ifdef CONFIG_COMPAT
e35d49f637d5ce Al Viro                 2017-04-08  1469  /*
e35d49f637d5ce Al Viro                 2017-04-08  1470   * Exactly like sys_open(), except that it doesn't set the
e35d49f637d5ce Al Viro                 2017-04-08  1471   * O_LARGEFILE flag.
e35d49f637d5ce Al Viro                 2017-04-08  1472   */
e35d49f637d5ce Al Viro                 2017-04-08  1473  COMPAT_SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
e35d49f637d5ce Al Viro                 2017-04-08  1474  {
e35d49f637d5ce Al Viro                 2017-04-08  1475  	return do_sys_open(AT_FDCWD, filename, flags, mode);
e35d49f637d5ce Al Viro                 2017-04-08  1476  }
e35d49f637d5ce Al Viro                 2017-04-08  1477  
e35d49f637d5ce Al Viro                 2017-04-08  1478  /*
e35d49f637d5ce Al Viro                 2017-04-08  1479   * Exactly like sys_openat(), except that it doesn't set the
e35d49f637d5ce Al Viro                 2017-04-08  1480   * O_LARGEFILE flag.
e35d49f637d5ce Al Viro                 2017-04-08  1481   */
e35d49f637d5ce Al Viro                 2017-04-08  1482  COMPAT_SYSCALL_DEFINE4(openat, int, dfd, const char __user *, filename, int, flags, umode_t, mode)
e35d49f637d5ce Al Viro                 2017-04-08  1483  {
e35d49f637d5ce Al Viro                 2017-04-08  1484  	return do_sys_open(dfd, filename, flags, mode);
e35d49f637d5ce Al Viro                 2017-04-08  1485  }
e35d49f637d5ce Al Viro                 2017-04-08  1486  #endif
e35d49f637d5ce Al Viro                 2017-04-08  1487  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1488  #ifndef __alpha__
^1da177e4c3f41 Linus Torvalds          2005-04-16  1489  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1490  /*
^1da177e4c3f41 Linus Torvalds          2005-04-16  1491   * For backward compatibility?  Maybe this should be moved
^1da177e4c3f41 Linus Torvalds          2005-04-16  1492   * into arch/i386 instead?
^1da177e4c3f41 Linus Torvalds          2005-04-16  1493   */
a218d0fdc5f900 Al Viro                 2011-11-21  1494  SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1495  {
166e07c37c6417 Christoph Hellwig       2020-06-06  1496  	int flags = O_CREAT | O_WRONLY | O_TRUNC;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1497  
166e07c37c6417 Christoph Hellwig       2020-06-06  1498  	if (force_o_largefile())
166e07c37c6417 Christoph Hellwig       2020-06-06  1499  		flags |= O_LARGEFILE;
166e07c37c6417 Christoph Hellwig       2020-06-06  1500  	return do_sys_open(AT_FDCWD, pathname, flags, mode);
166e07c37c6417 Christoph Hellwig       2020-06-06  1501  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1502  #endif
^1da177e4c3f41 Linus Torvalds          2005-04-16  1503  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1504  /*
^1da177e4c3f41 Linus Torvalds          2005-04-16  1505   * "id" is the POSIX thread ID. We use the
^1da177e4c3f41 Linus Torvalds          2005-04-16  1506   * files pointer for this..
^1da177e4c3f41 Linus Torvalds          2005-04-16  1507   */
021a160abf62c1 Linus Torvalds          2023-08-08  1508  static int filp_flush(struct file *filp, fl_owner_t id)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1509  {
45778ca819acca Christoph Lameter       2005-06-23  1510  	int retval = 0;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1511  
47d586913f2abe Jann Horn               2023-01-16  1512  	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0,
47d586913f2abe Jann Horn               2023-01-16  1513  			"VFS: Close: file count is 0 (f_op=%ps)",
47d586913f2abe Jann Horn               2023-01-16  1514  			filp->f_op)) {
45778ca819acca Christoph Lameter       2005-06-23  1515  		return 0;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1516  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1517  
72c2d531920048 Al Viro                 2013-09-22  1518  	if (filp->f_op->flush)
75e1fcc0b18df0 Miklos Szeredi          2006-06-23  1519  		retval = filp->f_op->flush(filp, id);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1520  
1abf0c718f15a5 Al Viro                 2011-03-13  1521  	if (likely(!(filp->f_mode & FMODE_PATH))) {
^1da177e4c3f41 Linus Torvalds          2005-04-16  1522  		dnotify_flush(filp, id);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1523  		locks_remove_posix(filp, id);
1abf0c718f15a5 Al Viro                 2011-03-13  1524  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  1525  	return retval;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1526  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1527  
021a160abf62c1 Linus Torvalds          2023-08-08  1528  int filp_close(struct file *filp, fl_owner_t id)
021a160abf62c1 Linus Torvalds          2023-08-08  1529  {
021a160abf62c1 Linus Torvalds          2023-08-08  1530  	int retval;
021a160abf62c1 Linus Torvalds          2023-08-08  1531  
021a160abf62c1 Linus Torvalds          2023-08-08  1532  	retval = filp_flush(filp, id);
021a160abf62c1 Linus Torvalds          2023-08-08  1533  	fput(filp);
021a160abf62c1 Linus Torvalds          2023-08-08  1534  
021a160abf62c1 Linus Torvalds          2023-08-08  1535  	return retval;
021a160abf62c1 Linus Torvalds          2023-08-08  1536  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1537  EXPORT_SYMBOL(filp_close);
^1da177e4c3f41 Linus Torvalds          2005-04-16  1538  
^1da177e4c3f41 Linus Torvalds          2005-04-16  1539  /*
^1da177e4c3f41 Linus Torvalds          2005-04-16  1540   * Careful here! We test whether the file pointer is NULL before
^1da177e4c3f41 Linus Torvalds          2005-04-16  1541   * releasing the fd. This ensures that one clone task can't release
^1da177e4c3f41 Linus Torvalds          2005-04-16  1542   * an fd while another clone is opening it.
^1da177e4c3f41 Linus Torvalds          2005-04-16  1543   */
ca013e945b1ba5 Heiko Carstens          2009-01-14  1544  SYSCALL_DEFINE1(close, unsigned int, fd)
^1da177e4c3f41 Linus Torvalds          2005-04-16  1545  {
021a160abf62c1 Linus Torvalds          2023-08-08  1546  	int retval;
021a160abf62c1 Linus Torvalds          2023-08-08  1547  	struct file *file;
021a160abf62c1 Linus Torvalds          2023-08-08  1548  
a88c955fcfb497 Christian Brauner       2023-11-30  1549  	file = file_close_fd(fd);
021a160abf62c1 Linus Torvalds          2023-08-08  1550  	if (!file)
021a160abf62c1 Linus Torvalds          2023-08-08  1551  		return -EBADF;
021a160abf62c1 Linus Torvalds          2023-08-08  1552  
021a160abf62c1 Linus Torvalds          2023-08-08  1553  	retval = filp_flush(file, current->files);
021a160abf62c1 Linus Torvalds          2023-08-08  1554  
021a160abf62c1 Linus Torvalds          2023-08-08  1555  	/*
021a160abf62c1 Linus Torvalds          2023-08-08  1556  	 * We're returning to user space. Don't bother
021a160abf62c1 Linus Torvalds          2023-08-08  1557  	 * with any delayed fput() cases.
021a160abf62c1 Linus Torvalds          2023-08-08  1558  	 */
021a160abf62c1 Linus Torvalds          2023-08-08  1559  	__fput_sync(file);
ee731f4f7880b0 Ernie Petrides          2006-09-29  1560  
ee731f4f7880b0 Ernie Petrides          2006-09-29  1561  	/* can't restart close syscall because file table entry was cleared */
ee731f4f7880b0 Ernie Petrides          2006-09-29  1562  	if (unlikely(retval == -ERESTARTSYS ||
ee731f4f7880b0 Ernie Petrides          2006-09-29  1563  		     retval == -ERESTARTNOINTR ||
ee731f4f7880b0 Ernie Petrides          2006-09-29  1564  		     retval == -ERESTARTNOHAND ||
ee731f4f7880b0 Ernie Petrides          2006-09-29  1565  		     retval == -ERESTART_RESTARTBLOCK))
ee731f4f7880b0 Ernie Petrides          2006-09-29  1566  		retval = -EINTR;
ee731f4f7880b0 Ernie Petrides          2006-09-29  1567  
ee731f4f7880b0 Ernie Petrides          2006-09-29  1568  	return retval;
^1da177e4c3f41 Linus Torvalds          2005-04-16  1569  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  1570  
278a5fbaed89da Christian Brauner       2019-05-24  1571  /**
35931eb3945b8d Matthew Wilcox (Oracle  2023-08-18  1572)  * sys_close_range() - Close all file descriptors in a given range.
278a5fbaed89da Christian Brauner       2019-05-24  1573   *
278a5fbaed89da Christian Brauner       2019-05-24  1574   * @fd:     starting file descriptor to close
278a5fbaed89da Christian Brauner       2019-05-24  1575   * @max_fd: last file descriptor to close
278a5fbaed89da Christian Brauner       2019-05-24  1576   * @flags:  reserved for future extensions
278a5fbaed89da Christian Brauner       2019-05-24  1577   *
278a5fbaed89da Christian Brauner       2019-05-24  1578   * This closes a range of file descriptors. All file descriptors
278a5fbaed89da Christian Brauner       2019-05-24  1579   * from @fd up to and including @max_fd are closed.
278a5fbaed89da Christian Brauner       2019-05-24  1580   * Currently, errors to close a given file descriptor are ignored.
278a5fbaed89da Christian Brauner       2019-05-24  1581   */
278a5fbaed89da Christian Brauner       2019-05-24 @1582  SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
278a5fbaed89da Christian Brauner       2019-05-24  1583  		unsigned int, flags)
278a5fbaed89da Christian Brauner       2019-05-24  1584  {
60997c3d45d9a6 Christian Brauner       2020-06-03  1585  	return __close_range(fd, max_fd, flags);
278a5fbaed89da Christian Brauner       2019-05-24  1586  }
278a5fbaed89da Christian Brauner       2019-05-24  1587  

:::::: The code at line 1443 was first introduced by commit
:::::: fddb5d430ad9fa91b49b1d34d0202ffe2fa0e179 open: introduce openat2(2) syscall

:::::: TO: Aleksa Sarai <cyphar@cyphar.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

