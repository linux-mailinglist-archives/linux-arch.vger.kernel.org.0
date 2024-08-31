Return-Path: <linux-arch+bounces-6884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B4D966EB0
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 03:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2D41C220D1
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AF12C6B6;
	Sat, 31 Aug 2024 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCmY11w4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB418C31;
	Sat, 31 Aug 2024 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725069469; cv=none; b=fHiZ4g2uPKChy8/uEZEaa7IAGJT8LUaXp4yWL8+i8Oxxnw7pyICSyZG3talCIuL/Y9K0cGooCWCjo7fSJ1JfGROAIIvE8jed3TM5tMNYC1zlkHJlhzzLpAFSmrDetY3eLvLxvEKLzTD3JKFZo/tfKcMzkbMOkdf0uZVw8m6vIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725069469; c=relaxed/simple;
	bh=Or8HdMw0jQmW5OAewy5sc08VXT/MO4lE6accWkZyWGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miuV4hZaVMs1YPdYI6Nqrm6lSlwGnrDJ9o572MdYMdU41MaKl+Rw6bSNW7P5crGqW7LbbNN4h9k+4yk09czv/2oNtEjtZrwZLr0Oeu8/eRPO7PAVql7ke76pShuXyPHn/XMowrNw5mymuU4wpxdUn5mG5/cR5ZcK45Rawz53vZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCmY11w4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725069468; x=1756605468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Or8HdMw0jQmW5OAewy5sc08VXT/MO4lE6accWkZyWGQ=;
  b=dCmY11w4PxILmTF8qrTk4ywUI4fBq2dCuUisat4v1lJkM7gr1aBVM4rU
   MzhqOHjCEfj0KLEbSjnOO4H0elJQq6oF3IPAhbvvkPPhZtYY7HE8n/qzs
   Om3wRaH9JWYSMXF96E5s0rz7riK31T2P8ZTY1ij/xFi4ZmCPvxu/QQlgm
   o25zlg65f72SQZ15R1gwkRB7RBmWgn1QaCvhiH2bZb8yYtJiuOt0u8vVs
   AcRCfJSwBsNdACExdUetotByv1Da08MfwFwE35WfPGzhrEq7VD0zQ40bq
   bA1OcqbSiRQNnFuLAwCDoKQArfIswUZvBkSAGfAbFp8A2ySCpKsd6ZE36
   A==;
X-CSE-ConnectionGUID: JNPXZGnOQnOMyK8IlO2s4g==
X-CSE-MsgGUID: K5LMsmimT0ClpomNkaByww==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34297814"
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="34297814"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 18:57:47 -0700
X-CSE-ConnectionGUID: Pcv5OCCbTwi8LpYKrNzcoA==
X-CSE-MsgGUID: AbF7xuwuTPG6xNW2MXEm0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="94795001"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Aug 2024 18:57:44 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skDMz-0002HK-2v;
	Sat, 31 Aug 2024 01:57:41 +0000
Date: Sat, 31 Aug 2024 09:56:52 +0800
From: kernel test robot <lkp@intel.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <202408310834.qh5oO1N6-lkp@intel.com>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829201728.2825-1-adhemerval.zanella@linaro.org>

Hi Adhemerval,

kernel test robot noticed the following build errors:

[auto build test ERROR on crng-random/master]
[also build test ERROR on next-20240830]
[cannot apply to arm64/for-next/core shuah-kselftest/next shuah-kselftest/fixes linus/master v6.11-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adhemerval-Zanella/aarch64-vdso-Wire-up-getrandom-vDSO-implementation/20240830-041912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
patch link:    https://lore.kernel.org/r/20240829201728.2825-1-adhemerval.zanella%40linaro.org
patch subject: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240831/202408310834.qh5oO1N6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310834.qh5oO1N6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310834.qh5oO1N6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/vdso/getrandom.h:8,
                    from lib/vdso/getrandom.c:12,
                    from <command-line>:
>> arch/arm64/include/asm/vdso.h:25:10: fatal error: generated/vdso-offsets.h: No such file or directory
      25 | #include <generated/vdso-offsets.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.build:244: arch/arm64/kernel/vdso/vgetrandom.o] Error 1
   make[3]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[3]: Target 'arch/arm64/kernel/vdso/vdso.so' not remade because of errors.
   make[2]: *** [arch/arm64/Makefile:217: vdso_prepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +25 arch/arm64/include/asm/vdso.h

0a7927d2b89e55 Adhemerval Zanella 2024-08-29  24  
9031fefde6f2ac Will Deacon        2012-03-05 @25  #include <generated/vdso-offsets.h>
9031fefde6f2ac Will Deacon        2012-03-05  26  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

