Return-Path: <linux-arch+bounces-5486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE92934736
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 06:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEB928203A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508FD3A1BF;
	Thu, 18 Jul 2024 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncj7+f1b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF61B86FB
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277616; cv=none; b=jFbNglnylaaEduNvCOnakSa1YCBwCoUZD4L/kBDFu3i4HITfrR7qqAs7j4r0IedM5ddqCPvY4L8SdX2/RqF4Yu3J0M4fjm+MKqNh0v18TsbOBBo68p9pJbb3QdzFZILmI9uE/I1bvpIFtT04KP2ZzIMaeleXeTEPjbKChHHUHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277616; c=relaxed/simple;
	bh=wOVn7eytpWtUpVeeLrxDd5k5kb0E2KLdKl4b4CCs/BE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jCjuTynL+n8tnFScuIOMbBRxV1p+LwZhbXWgF/cv6nUo6BoSeuC/OMPtSF3tujj4xZGKiX6ArqfkyRVOPM5BWwq0XBHq61Ry2fvFiEIGniZ4p9mUKMq4UoowOfoA6wnUAv6F5LbrV0oBy52kunMQkPKFqX+zb7hUN2OjW8+x1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncj7+f1b; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721277613; x=1752813613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wOVn7eytpWtUpVeeLrxDd5k5kb0E2KLdKl4b4CCs/BE=;
  b=ncj7+f1bzZ6hKIOzhqpMqAkf/sWTwAs9XVYSTICC3eI4Rkn9nxLbM/VO
   3R5pmTYkxSxMPNc0xxkeLfpCoUoRoCdrmiCPxcOVkdYKhwEeM95OLdTv9
   DNm/eDVrszabZBHD897ussVMIxajNeQHTZY2EAeBCikSGeh+Qd5JVdvMd
   vvUezhaXgxlOTsN78Xs/Irja6Og0f2ujkEc1407++tIPcdq+NzUxLfZ8g
   MkR/6gsOk6tSSdSFDiYELyf94Yh/6+hcWCJHC8xCz07j/FL0/3yWC6lGP
   GgzZ3Z658q7IVCBwTnlh822/RtKdWVQTHC+8/9F4mDiS8boC8oWwB4OAS
   w==;
X-CSE-ConnectionGUID: riooCzyTSgKI6/x9hJLY0g==
X-CSE-MsgGUID: FuCxQtGsTD29ERMEO38gNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18515304"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="18515304"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 21:40:13 -0700
X-CSE-ConnectionGUID: YIeuJugyRxiouqyCbn1ePA==
X-CSE-MsgGUID: IUyvH0chSHmYXSG5loqBOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="73871649"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Jul 2024 21:40:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUIw5-000gxS-1v;
	Thu, 18 Jul 2024 04:40:09 +0000
Date: Thu, 18 Jul 2024 12:40:05 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 43/98] ld.lld: error: undefined
 symbol: __ia32_sys_fadvise64_64_6
Message-ID: <202407181209.jFiC5Wi2-lkp@intel.com>
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
commit: 65d061c10d574e0e8d31fbdf4014e008fbad1fe3 [43/98] syscalls: cleanup fadvise64_64()
config: i386-randconfig-005-20240718 (https://download.01.org/0day-ci/archive/20240718/202407181209.jFiC5Wi2-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407181209.jFiC5Wi2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407181209.jFiC5Wi2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __ia32_sys_fadvise64_64_6
   >>> referenced by syscall_table_32.h:273 (./arch/x86/include/generated/asm/syscall_table_32.h:273)
   >>>               arch/x86/entry/syscall_32.o:(ia32_sys_call) in archive vmlinux.a
   >>> referenced by syscall_32.c:28 (arch/x86/entry/syscall_32.c:28)
   >>>               arch/x86/entry/syscall_32.o:(sys_call_table) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

