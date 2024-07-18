Return-Path: <linux-arch+bounces-5485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25439346AE
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 05:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C9128292F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D181D543;
	Thu, 18 Jul 2024 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXNJE1nM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB81BDDB
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721273139; cv=none; b=D7LSq7cQDCEU8n26l/VaqWp0mQjGNHcJkdvumndfPkrHz6IT7M0kPYNR5t0uRY/obpGbef/k2iTKNR7BwdDsZOSywHtOZBTkd47NWtFTLnWeQr4yN6KWIpVzr60FOLef+uemruAfVSQkOc3nFDt0aDIdEE8ohoVypQCIu2U4GeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721273139; c=relaxed/simple;
	bh=9i1tGchZj5H+MDUUoggws96Ya7msMkMQRetPDtrXFE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WXkRQ2ATbIQp2zzPcH1SX0DTEZQLmkjLXLSSypD3/W/rpZ3XrCCWnnM45ujuxoEaxL/koNiuHipAZ654RVurqmmAINXr6RyH7+UaJxpQHldkc0+fMTtlh7Z8VX3YvmGI+C++JsDKSIOITl3rsGB7oJd110g3tbYbOQgtikq/x1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXNJE1nM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721273138; x=1752809138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9i1tGchZj5H+MDUUoggws96Ya7msMkMQRetPDtrXFE8=;
  b=gXNJE1nMt7YwCVMBSfFgQZ3U15Ohs3LLXMuAA1lbersv77vhfIIxozT5
   Yexx8XVjhX2dI7ia4eDP7oRw7dGX0kY4Zj0iHJiEltk/JQ/gp4PERXRFC
   aFxGMwQ+VFwWdFOD++Y09H9Q+PvIBRDs26nKskNgP6cZqBpnIzNiAqs5M
   ptkELNz7tmRqdHARFogweNukJgbeFrm4cFCH48ndCGrvsHMAKgHlsOChb
   21vnqNc/lyDLz32XiaDNgxLOAyc1CtbsYMq2D22TCF4fq+1/6GRaKS9Xp
   mMBbUvMAQLJoWoRXUt4u4vbLV/Xi06juuPkMsWxpXWKEO8xqmna1VrC0F
   A==;
X-CSE-ConnectionGUID: TFLziUiyR1ej9F/z94IodA==
X-CSE-MsgGUID: XlVYNzXbSyi9OIpK7KvuvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="30227921"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="30227921"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 20:25:12 -0700
X-CSE-ConnectionGUID: zVt3Bq8ZSymU2yk5SHWPVw==
X-CSE-MsgGUID: r0fJCLCYQIWOht9h+UzzpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="50671877"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Jul 2024 20:25:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUHlT-000gui-2p;
	Thu, 18 Jul 2024 03:25:07 +0000
Date: Thu, 18 Jul 2024 11:24:40 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 80/98]
 arch/x86/include/asm/syscalls.h:27:76: warning: 'struct stat64' declared
 inside parameter list will not be visible outside of this definition or
 declaration
Message-ID: <202407181157.lIOH6oLx-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20240718 (https://download.01.org/0day-ci/archive/20240718/202407181157.lIOH6oLx-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407181157.lIOH6oLx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407181157.lIOH6oLx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/vt/vt_ioctl.c:83:
>> arch/x86/include/asm/syscalls.h:27:76: warning: 'struct stat64' declared inside parameter list will not be visible outside of this definition or declaration
      27 | asmlinkage long compat_sys_ia32_stat64(const char __user *filename, struct stat64 __user *statbuf);
         |                                                                            ^~~~~~
   arch/x86/include/asm/syscalls.h:28:77: warning: 'struct stat64' declared inside parameter list will not be visible outside of this definition or declaration
      28 | asmlinkage long compat_sys_ia32_lstat64(const char __user *filename, struct stat64 __user *statbuf);
         |                                                                             ^~~~~~
   arch/x86/include/asm/syscalls.h:29:65: warning: 'struct stat64' declared inside parameter list will not be visible outside of this definition or declaration
      29 | asmlinkage long compat_sys_ia32_fstat64(unsigned int fd, struct stat64 __user *statbuf);
         |                                                                 ^~~~~~
   arch/x86/include/asm/syscalls.h:30:97: warning: 'struct stat64' declared inside parameter list will not be visible outside of this definition or declaration
      30 | asmlinkage long compat_sys_ia32_fstatat64(unsigned int dfd, const char __user *filename, struct stat64 __user *statbuf, int flag);
         |                                                                                                 ^~~~~~


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

