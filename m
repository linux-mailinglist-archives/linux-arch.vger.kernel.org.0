Return-Path: <linux-arch+bounces-5487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E21934792
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 07:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BCAB20A4D
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 05:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5435942058;
	Thu, 18 Jul 2024 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYsuIPzW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BC41746
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280143; cv=none; b=O0RtZTJlIdeVs1Z6gBzlD+l2uasYdbFMRzftmxE71+K4NmVjwg/XPFDIKnhvvIClgwERg7kzNKJpsepZaALs34/4F8CCxmPSw6QJYoNfBwZLYUWRQ2xvf6XNhzAc2iI3XP0KP+egheDjOPvAiKL+EJTVKkkPBnUKeoZiRV3PaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280143; c=relaxed/simple;
	bh=8siB5v3thPqXxTEbFEikz0Xv3O5gAFTl73wyXelZGvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pjC3LydX7MSn8JlkYKcFhCkQXz0nux/+R2uMFRJQXpiYzszsJ7TbsgsZj8SMzBy2veA4mvr4Mo1hLtlfCKvS6u2jN0Vai/McGZ4H7l7kjnOJuCa3NPSkbZzBtCBuwIxxEBioe9hqBUOpy+U0gKobr/AVv0QzLhKEolwKuqAopNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYsuIPzW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721280141; x=1752816141;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8siB5v3thPqXxTEbFEikz0Xv3O5gAFTl73wyXelZGvw=;
  b=kYsuIPzWr4fQ2iYAVo6OrW2b3izNkXSchrZdaK4cA8iZHUG77CHmflGl
   w0dlJa7Z2lRiexWnPhreoXv57LBN3g9144x3Ca3CufOnNekS7BDNNni8H
   pUugoZ3GMmHmxQSZRlB7e4EEWTDwoVQL8A1UQ3RKl+pPSJgFUMSgHbXE5
   +OG2Vos5qsPSGUvb0c++eKgjn2ZQ5/LRlAbQ1IFEJFrs0fFA+YRvPwM3U
   imqj9lMow87w8aW6n7HkC/JK+OlmgPEQklNlNaRoBO1srg1rRkdhVt5+W
   CdU3h98bTsyRmAj6mItpqZnQeVzDTBCYbwuCK6efElrfvn2lomTjeTvqj
   A==;
X-CSE-ConnectionGUID: /8KAY3CCQLinWE9W5WnDUQ==
X-CSE-MsgGUID: urj9q1UdRmGiefKxyYUysg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29977533"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="29977533"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 22:22:21 -0700
X-CSE-ConnectionGUID: lZ08pvL6Soa9YiT35wF2RA==
X-CSE-MsgGUID: FHS3BpawTKedvO3OBCbndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="55145822"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Jul 2024 22:22:20 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUJar-000gyg-1b;
	Thu, 18 Jul 2024 05:22:17 +0000
Date: Thu, 18 Jul 2024 13:21:47 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 32/98]
 arch/x86/um/sys_call_table_32.c:27:10: fatal error: asm/syscalls_32.h: No
 such file or directory
Message-ID: <202407181359.v2PMzxXm-lkp@intel.com>
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
commit: 824c915b5b0011418f9000ee1c2b4299b842595a [32/98] x86: rename some syscall table generation identifiers
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20240718/202407181359.v2PMzxXm-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407181359.v2PMzxXm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407181359.v2PMzxXm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/um/sys_call_table_32.c:27:10: fatal error: asm/syscalls_32.h: No such file or directory
      27 | #include <asm/syscalls_32.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +27 arch/x86/um/sys_call_table_32.c

6218d0f6b8dece Masahiro Yamada 2021-05-17  25  
6218d0f6b8dece Masahiro Yamada 2021-05-17  26  #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
45db1c6176c817 H. Peter Anvin  2011-12-05 @27  #include <asm/syscalls_32.h>
45db1c6176c817 H. Peter Anvin  2011-12-05  28  

:::::: The code at line 27 was first introduced by commit
:::::: 45db1c6176c8171d9ae6fa6d82e07d115a5950ca x86, um: Use the same style generated syscall tables as native

:::::: TO: H. Peter Anvin <hpa@linux.intel.com>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

