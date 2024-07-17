Return-Path: <linux-arch+bounces-5475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFE2934393
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B312B207A4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82055188CAC;
	Wed, 17 Jul 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iuv/IOzm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F128187327
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249921; cv=none; b=ZbaVrXbwO+JlaI/+KrQBQnypuYKpS0Ukf3ZhYYaN+t7pucN8AC1u3EcA7IqM4RZjAkXqtqGDsP9fjpuah7b5vBL7p8hu/2FcutMANyui+DaTsEY7ocpV70pe3b8FciiOPiEBc1s/yKg/e/Vef1ZAFQcdJboJX2FooSzetX3nIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249921; c=relaxed/simple;
	bh=cOxQQ+7h/IOFq4lB6h8X6gbC2NTQ0S0/J79ADcivCYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a50OGxWrD4DTeRjor+nQAaObtzHPoe9CXufbLmdb8qDJ1wV8wPDy+vHrfCgEowad+/JK3KbkyaFGH57ROZlD1wBL4S1zkjwevvyha9HDUI4ilhBfQ/CLuQ1oPphfjn+sUQ8YrhkpSSsmN41BhczxFZDsY2Bii9rp/vvnUxCSS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iuv/IOzm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721249919; x=1752785919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cOxQQ+7h/IOFq4lB6h8X6gbC2NTQ0S0/J79ADcivCYs=;
  b=Iuv/IOzm14tJ44/7gqSJvpxiGnF96Y8Bf9HBY60BavCapWnWhoEeQMA5
   913oNUuEGiBUz6Gz+rpwyrj7Mh4mwRXuWuf/jcMTjR+SrDB0SKRqX0xTH
   t93/7PZ10JiOUyZfR3zjOGqGdHBKCz6S0TOtPeKf/BaJZz06u121HEXvm
   Kt2NpvJnUYD2YPdZDL3n863ZViiPneoQ+lwRIOGUT7smOJN0JVu/7wLcz
   7NA2FHKl+TMVXTe7PA8OAUvTXVAjY+OJVm0KNXBm6pDlFj3GMk2mJhz6y
   RRvMt/sOEwkkvTaPBd77hs3F0slBs/Zuh17YiEBdWI1M4DTnH+I0Ks8FH
   Q==;
X-CSE-ConnectionGUID: fedqc9DDR+qIMD/ERubK7g==
X-CSE-MsgGUID: kqTF7f2FQCmcnzItAZZWBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18921760"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="18921760"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 13:58:39 -0700
X-CSE-ConnectionGUID: 93vqCfVkTkmbNqoPtnxtgQ==
X-CSE-MsgGUID: Z6ntuhUcReOA1kTlHMiLWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="55653810"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Jul 2024 13:58:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUBjP-000gfS-0r;
	Wed, 17 Jul 2024 20:58:35 +0000
Date: Thu, 18 Jul 2024 04:57:55 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 97/98]
 ./arch/openrisc/include/generated/asm/syscall_table_32.h:464:16: error:
 'sys_setxattrat' undeclared here (not in a function); did you mean
 'sys_setxattr'?
Message-ID: <202407180428.tHFOgti0-lkp@intel.com>
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
commit: ba754a0c3990ba735ee924a005c9e7f11894ad30 [97/98] fixup syscall.tbl
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240718/202407180428.tHFOgti0-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180428.tHFOgti0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180428.tHFOgti0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ./arch/openrisc/include/generated/asm/syscall_table_32.h:464:16: error: 'sys_setxattrat' undeclared here (not in a function); did you mean 'sys_setxattr'?
     464 | __SYSCALL(463, sys_setxattrat)
         |                ^~~~~~~~~~~~~~
   arch/openrisc/kernel/sys_call_table.c:19:37: note: in definition of macro '__SYSCALL'
      19 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                     ^~~~
>> ./arch/openrisc/include/generated/asm/syscall_table_32.h:465:16: error: 'sys_getxattrat' undeclared here (not in a function); did you mean 'sys_getxattr'?
     465 | __SYSCALL(464, sys_getxattrat)
         |                ^~~~~~~~~~~~~~
   arch/openrisc/kernel/sys_call_table.c:19:37: note: in definition of macro '__SYSCALL'
      19 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                     ^~~~
>> ./arch/openrisc/include/generated/asm/syscall_table_32.h:466:16: error: 'sys_listxattrat' undeclared here (not in a function); did you mean 'sys_listxattr'?
     466 | __SYSCALL(465, sys_listxattrat)
         |                ^~~~~~~~~~~~~~~
   arch/openrisc/kernel/sys_call_table.c:19:37: note: in definition of macro '__SYSCALL'
      19 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                     ^~~~
>> ./arch/openrisc/include/generated/asm/syscall_table_32.h:467:16: error: 'sys_removexattrat' undeclared here (not in a function); did you mean 'sys_removexattr'?
     467 | __SYSCALL(466, sys_removexattrat)
         |                ^~~~~~~~~~~~~~~~~
   arch/openrisc/kernel/sys_call_table.c:19:37: note: in definition of macro '__SYSCALL'
      19 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                     ^~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

