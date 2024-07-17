Return-Path: <linux-arch+bounces-5479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9093451F
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 01:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA641F21EC1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEFF5674E;
	Wed, 17 Jul 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8ny+34H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7E947E
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260087; cv=none; b=TTDFm8AdRnTsBGmvQ/b5QcSlhnEjH7GR+e7zFe9I2oige6Uv8TEyvFOTVBqkNbZRsTL1wXTWDUVA9mMDMLu5pb8SEa0Wtw7dcPN2Q0qRV3B4hq6npSmk6t0LJKKrq/xlwv9t/ZhuvgTZJ5L+PcU8UpCQa07DZNUyu35O7qBgBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260087; c=relaxed/simple;
	bh=RfgdTahFzJOLMxihc3tDx/kvv0mu3XxiwfOCEfDUNnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e5Q7u2JniF/R+TlALNMtNU8D3zp7hMm51CNlyhOEZHO6QipBVABTMFNvG77hbQzvs9xKfA6xeKmykaZ4j8UQvvyE+QGYyXiNYFlaWSkkiJv/SylU1eKXvskaW7OdJwqSMAyzxVy9m6nkdIXFree92ffic3rEoXdHxFnq1w9/z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8ny+34H; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721260081; x=1752796081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RfgdTahFzJOLMxihc3tDx/kvv0mu3XxiwfOCEfDUNnM=;
  b=O8ny+34Hb9sCxXZ7jFMxbd4OKekzQhr2UR8nv+wpl4NPEomP+ocNO6v0
   jOARtIa77wINXeysLh7Milwecbcx7+CBik42Hqt/RuXuSY6MswS3QBZz3
   AQAGSMH91Fz66cbPjwD4481QR42OmRNAnV51m8gdsG1E6RXPhPkstG9WH
   KCM7tbzpSQlStw/U/ChsJw2Vfl0oBvAZQVIlHdwsz9tM++ai180sqQZvy
   0dA4PQ3LDc9atX8tn7Xn+F2A0Os7OIH3XGS43lbNwednNJ2kCoVaD77qW
   vqNHsKcMQasCzFAqbsyU4NUmBP9xiskG6HaQN65ioBjMQtwd3umH/0Q5h
   A==;
X-CSE-ConnectionGUID: PvilXq4FRkm4cxu/P/NqYA==
X-CSE-MsgGUID: RAbOWsCARjyvrTjboYUw0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="41321433"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="41321433"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 16:48:01 -0700
X-CSE-ConnectionGUID: Ri/dbCqdRiOnrZ5k4CMd3w==
X-CSE-MsgGUID: Id0MVNXUTEqhv37Ny/RJTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="54892848"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2024 16:48:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUENJ-000glQ-3A;
	Wed, 17 Jul 2024 23:47:57 +0000
Date: Thu, 18 Jul 2024 07:46:59 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 95/98]
 include/linux/syscalls.h:210:25: error: conflicting types for
 'sys_mips_pipe'; have 'long int(void)'
Message-ID: <202407180721.r42zYOeD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.11
head:   9a99991d90521113a738c2a4761a4147fe4b31ca
commit: baef720c972546254f0900c4e7e83916cab2ba61 [95/98] mips sysm_pipe
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20240718/202407180721.r42zYOeD-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180721.r42zYOeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180721.r42zYOeD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/syscall.c:17:
>> include/linux/syscalls.h:210:25: error: conflicting types for 'sys_mips_pipe'; have 'long int(void)'
     210 |         asmlinkage long sys_##sname(void);                      \
         |                         ^~~~
   arch/mips/kernel/syscall.c:52:1: note: in expansion of macro 'SYSCALL_DEFINE0'
      52 | SYSCALL_DEFINE0(mips_pipe)
         | ^~~~~~~~~~~~~~~
   In file included from include/linux/syscalls.h:84:
   arch/mips/include/asm/syscalls.h:24:16: note: previous declaration of 'sys_mips_pipe' with type 'int(void)'
      24 | asmlinkage int sys_mips_pipe(void);
         |                ^~~~~~~~~~~~~
   include/linux/syscalls.h:212:25: error: conflicting types for 'sys_mips_pipe'; have 'long int(void)'
     212 |         asmlinkage long sys_##sname(void)
         |                         ^~~~
   arch/mips/kernel/syscall.c:52:1: note: in expansion of macro 'SYSCALL_DEFINE0'
      52 | SYSCALL_DEFINE0(mips_pipe)
         | ^~~~~~~~~~~~~~~
   arch/mips/include/asm/syscalls.h:24:16: note: previous declaration of 'sys_mips_pipe' with type 'int(void)'
      24 | asmlinkage int sys_mips_pipe(void);
         |                ^~~~~~~~~~~~~


vim +210 include/linux/syscalls.h

bed1ffca022cc8 Frederic Weisbecker 2009-03-13  206  
1bd21c6c21e848 Dominik Brodowski   2018-04-05  207  #ifndef SYSCALL_DEFINE0
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  208  #define SYSCALL_DEFINE0(sname)					\
99e621f796d7f0 Al Viro             2013-03-05  209  	SYSCALL_METADATA(_##sname, 0);				\
c9a211951c7c79 Howard McLauchlan   2018-03-21 @210  	asmlinkage long sys_##sname(void);			\
c9a211951c7c79 Howard McLauchlan   2018-03-21  211  	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  212  	asmlinkage long sys_##sname(void)
1bd21c6c21e848 Dominik Brodowski   2018-04-05  213  #endif /* SYSCALL_DEFINE0 */
bed1ffca022cc8 Frederic Weisbecker 2009-03-13  214  

:::::: The code at line 210 was first introduced by commit
:::::: c9a211951c7c79cfb5de888d7d9550872868b086 bpf: whitelist all syscalls for error injection

:::::: TO: Howard McLauchlan <hmclauchlan@fb.com>
:::::: CC: Dominik Brodowski <linux@dominikbrodowski.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

