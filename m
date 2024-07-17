Return-Path: <linux-arch+bounces-5481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679B5934531
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 01:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046C3B21E1A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E96BFB5;
	Wed, 17 Jul 2024 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdTBQvFf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CA6F2E2
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260745; cv=none; b=jyHVGfKlHRBV0gc9tVOZail+0YyQRrGeJypwJ8R6CJzoPmbu7+r6QtZSufdlebwS18ePlGGWQJbkpVzFpVrrV5LdznYJLzkxfRld8/ylmdhdbqmzBjJB4rPXMMWZS8GdYfjAlLckDUlDzvZ6bP3OK8LbhSTVrQmUJsjTTMmjx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260745; c=relaxed/simple;
	bh=5a3HfBAENG9pyJGCiy81RBYBle1GBgu9xnR1NecS2L8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XgNx4q1EmW5LdRFGV2rk8OygYoAkchqYwWhyubTXGiAMEgyYdqIrYkm1sfI4co0dUNZ6GrlmxBHDo56pcduts7KUB1JI7m3x6ZseAm1zfDpXBQvG5hJDObtwABos3nGcZxSyMhLVVbag8tAvtJ2yebpiyZY0FflXqH/GvRdNiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdTBQvFf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721260743; x=1752796743;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5a3HfBAENG9pyJGCiy81RBYBle1GBgu9xnR1NecS2L8=;
  b=mdTBQvFfV034DcVvxfZKKv5AohSoiDgBRx5h1/CBimK77R0xGp+RdL0m
   UgPXk9X0qbRFoN/6/zwPqO5692c5KRJxD69IC7OFtzAnZ/5PLXH+frsrV
   PbZ7s3Roq6v83e/PNnHw8y2dI1+2DeXkSPwYEcrc30xQrvjk6OTcviZ2Y
   nGMoP1wsaY9GNrcojquteVnu/z5mnUzqDLLqsE4+7KiUzujKcf2hmxTGw
   ChTc0XyP8eOskxHl9KXeXbLBjgT+9/li9TL00Q1xeUIx8g9CsIugOhd37
   q/mmxRuqJ6r/KST4QHeb9hxjH/MUwGpLSmnGB0nrZ3WCft8a3HAIvoirM
   g==;
X-CSE-ConnectionGUID: ho7mvPOKRBOZKhC0YWThUQ==
X-CSE-MsgGUID: 9e4DJfaQSyy7zq49KU09sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18937386"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="18937386"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 16:59:02 -0700
X-CSE-ConnectionGUID: egxL4XWDQ+SnV9Sv6gDt9g==
X-CSE-MsgGUID: K3X8QGe/TVilxfq2PRQuDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="55413100"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Jul 2024 16:59:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUEXy-000gly-1T;
	Wed, 17 Jul 2024 23:58:58 +0000
Date: Thu, 18 Jul 2024 07:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 80/98]
 arch/x86/include/asm/syscalls.h:27:76: warning: declaration of 'struct
 stat64' will not be visible outside of this function
Message-ID: <202407180723.rk3cGZ41-lkp@intel.com>
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
commit: 57f3cf21bbe2d779a7d7a23fb863b4b51d865fdd [80/98] x86: add missing syscall prototypes
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240718/202407180723.rk3cGZ41-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180723.rk3cGZ41-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180723.rk3cGZ41-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/vt/vt_ioctl.c:83:
>> arch/x86/include/asm/syscalls.h:27:76: warning: declaration of 'struct stat64' will not be visible outside of this function [-Wvisibility]
      27 | asmlinkage long compat_sys_ia32_stat64(const char __user *filename, struct stat64 __user *statbuf);
         |                                                                            ^
   arch/x86/include/asm/syscalls.h:28:77: warning: declaration of 'struct stat64' will not be visible outside of this function [-Wvisibility]
      28 | asmlinkage long compat_sys_ia32_lstat64(const char __user *filename, struct stat64 __user *statbuf);
         |                                                                             ^
   arch/x86/include/asm/syscalls.h:29:65: warning: declaration of 'struct stat64' will not be visible outside of this function [-Wvisibility]
      29 | asmlinkage long compat_sys_ia32_fstat64(unsigned int fd, struct stat64 __user *statbuf);
         |                                                                 ^
   arch/x86/include/asm/syscalls.h:30:97: warning: declaration of 'struct stat64' will not be visible outside of this function [-Wvisibility]
      30 | asmlinkage long compat_sys_ia32_fstatat64(unsigned int dfd, const char __user *filename, struct stat64 __user *statbuf, int flag);
         |                                                                                                 ^
   4 warnings generated.


vim +27 arch/x86/include/asm/syscalls.h

    24	
    25	asmlinkage long compat_sys_arch_prctl(int option, unsigned long arg2);
    26	struct mmap_arg_struct32;
  > 27	asmlinkage long compat_sys_ia32_stat64(const char __user *filename, struct stat64 __user *statbuf);
    28	asmlinkage long compat_sys_ia32_lstat64(const char __user *filename, struct stat64 __user *statbuf);
    29	asmlinkage long compat_sys_ia32_fstat64(unsigned int fd, struct stat64 __user *statbuf);
    30	asmlinkage long compat_sys_ia32_fstatat64(unsigned int dfd, const char __user *filename, struct stat64 __user *statbuf, int flag);
    31	asmlinkage long compat_sys_ia32_mmap(struct mmap_arg_struct32 __user *arg);
    32	asmlinkage long compat_sys_ia32_clone(unsigned long clone_flags, unsigned long newsp, int __user *parent_tidptr, unsigned long tls_val, int __user *child_tidptr);
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

