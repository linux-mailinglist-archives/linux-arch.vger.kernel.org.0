Return-Path: <linux-arch+bounces-5478-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 663AA9344D9
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 00:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF07B20D79
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D8D376E9;
	Wed, 17 Jul 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/K3hDdB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E351B974
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255696; cv=none; b=TfTa1XyuQN6Crb3lrYtZOIgD+825ofW5SFzg+OjTib4ANGE511hs/Dw5Z9IAZFulNHw9Agtdp8LjeMryOCayWe3XkAOSxfHM2k4vHGOJo8p5ftWvP+eyYuCOUn9Q45ZfJNGmi7vrfUL+0ZAgHxSkZbiWrzaTJVWW7clQsXtQVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255696; c=relaxed/simple;
	bh=LkVgTT4X+NHgfabFc4N6LCxrN+0BvoAGIX3YwKJbeWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KF3CltoUgSU3peO9VFe74TZE/piNFq3XdFY2OLVZ5ylebkTEBnixI/7WL0D9XgV/Pka3NkJTd+ua/X82CuWBW0Cl10Ar36gP9XISQWbqpB6d3Cv9V+babhalZRphdIhYXNa7B3sfhh92t3GAjyNi9OB0Xx/yoPUmxJbGezgqCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/K3hDdB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721255695; x=1752791695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LkVgTT4X+NHgfabFc4N6LCxrN+0BvoAGIX3YwKJbeWc=;
  b=A/K3hDdB1NRc+1vplGqs7whdhT9M4cUeHyAeDGMSZdYp67AqFXBJpSnq
   0dOH6UrdmzLfbHBraDesXlGtDxsKfDh/YQci681/oTdIqI96LWVR/Ejfm
   dqcFI0PTSfYQTPQDzw+XkQhn2rzU1cy3M03R/SOUWRi5WyLY5NE32boP0
   jEHTMIRdPFPhKvM8qpAMzH8l88Cno0zh8nwnoQJI+KngEt1CKaz2g6TJa
   VJQeEKw3VS9M1QEc7kZegqiAArf041mlNm98cCLJ615+Pl9lUKmzq6C/+
   UF3zN4sT7j/VXfF1KZva2cIFex0i6zoIB70cayjSxa4fs63ViIror0eee
   g==;
X-CSE-ConnectionGUID: kz2D4KbzTsaUNKyhnQooWw==
X-CSE-MsgGUID: 4/7aouwRTziUDgkutXiEaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29403802"
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="29403802"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 15:34:55 -0700
X-CSE-ConnectionGUID: oK+ljtPhTYuFEXNwLXcRPA==
X-CSE-MsgGUID: 5d82JamESxGT13J2CwDT4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,215,1716274800"; 
   d="scan'208";a="54733129"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jul 2024 15:34:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sUDEZ-000gjO-08;
	Wed, 17 Jul 2024 22:34:51 +0000
Date: Thu, 18 Jul 2024 06:34:21 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.11 32/98]
 arch/x86/um/sys_call_table_32.c:27:10: fatal error: 'asm/syscalls_32.h' file
 not found
Message-ID: <202407180608.OqFajxwV-lkp@intel.com>
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
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240718/202407180608.OqFajxwV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240718/202407180608.OqFajxwV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407180608.OqFajxwV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/um/sys_call_table_32.c:27:10: fatal error: 'asm/syscalls_32.h' file not found
      27 | #include <asm/syscalls_32.h>
         |          ^~~~~~~~~~~~~~~~~~~
   1 error generated.


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

