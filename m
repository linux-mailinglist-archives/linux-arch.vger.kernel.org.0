Return-Path: <linux-arch+bounces-5484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A11C9345B2
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 03:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4333CB21DE3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858E620;
	Thu, 18 Jul 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fieVhwuP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BF849C
	for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2024 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265730; cv=none; b=XfwmXc6+0cHEEQ0Ps5waY7FiZkXL++5Cts0rYuzrfI21aXWQN/OWC0ZHo0oe3D3wKbLbZ6ikPa1XoZTvoHsULQ1S9ABBc2jheok1wKXmiYE977T17JZEfeXYl86fo7ofjsV2vnKWI3RvYziRAs8+aU9qbBal/Ex0TrYWHq0uJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265730; c=relaxed/simple;
	bh=eMlCwdesxh8RecmQaRvq5Om/BbL3wBTGKDBYT+vYKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EOSDLltL8tK6tj7Wyl4ThiYkogVG8DmXNdWJmtAGC+kKS4UD6KJAjr1vxMBUgh4iGhPyEcUa8vtxNBPjeSYripQa68L8i//RI33p7iYcwxFjfPwi9QFtT2tz2Nv3m4IlZUPt1Eca0uYjlewxG8PapY7Rm8HUuvhJ/0HTBCdRfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fieVhwuP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721265729; x=1752801729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eMlCwdesxh8RecmQaRvq5Om/BbL3wBTGKDBYT+vYKLQ=;
  b=fieVhwuPvsnYHCA/O9F7qHhNYLyY3M8S+YCAgwlgXcjfxi4RmFg1nZqD
   +g/H0c+y2Sv1C6V2gN0gGi9OSZwkFdOgW51QfwubiXpAMWqAVVn4XMv7L
   cUhIyGI5BlSo0E8lcBf29dR8cF9LWei/fIRHbDJ8e8IODdUVYLwBU9LCL
   +1IfbS5eArEPbg8yMpegW+IMShax04/ZYFiK2dONTupvbKH11U43o2rhy
   e9wSlRF1w0eQBYYXuM60ftgmRO3ZUpX73O2wictsouN9nY3SJ2eeplI4D
   mHoft/2Ugc6aWQJnC/xE399Vjj26x1XKE1L8VPCaZoDgS8Z4bTZ9SwxiS
   g==;
X-CSE-ConnectionGUID: oSjJSWQnQL6Jp77VgSlC7g==
X-CSE-MsgGUID: /8//dr5dRwCPTF5+szU6YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="22667118"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="22667118"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 18:22:08 -0700
X-CSE-ConnectionGUID: 7IPPSn5gQISAmTKDzv6Eew==
X-CSE-MsgGUID: R45B/P+qQNCzg7ZJ8IUhIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="51210672"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Jul 2024 18:22:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUFqP-000gq2-0L;
	Thu, 18 Jul 2024 01:22:05 +0000
Date: Thu, 18 Jul 2024 09:21:59 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 43/98] syscall_32.c:undefined
 reference to `__ia32_sys_fadvise64_64_6'
Message-ID: <202407180947.jfaAP6M1-lkp@intel.com>
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
config: i386-buildonly-randconfig-002-20240718 (https://download.01.org/0day-ci/archive/20240718/202407180947.jfaAP6M1-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180947.jfaAP6M1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180947.jfaAP6M1-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/entry/syscall_32.o: in function `ia32_sys_call':
>> syscall_32.c:(.text+0x6c2): undefined reference to `__ia32_sys_fadvise64_64_6'
>> ld: arch/x86/entry/syscall_32.o:(.rodata+0xb80): undefined reference to `__ia32_sys_fadvise64_64_6'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

