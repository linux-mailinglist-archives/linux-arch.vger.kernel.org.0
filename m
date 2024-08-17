Return-Path: <linux-arch+bounces-6280-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C479295580A
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 15:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0324C1C20D64
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0D114D28A;
	Sat, 17 Aug 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHtBnTLx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2083A17;
	Sat, 17 Aug 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900786; cv=none; b=JsZYHMGVTewbUE4OWg1FnKh19CuiGuk8AR33tL+2C+8PW5mqoultFIhp+u9uhA2orPbOcerzTQi0PqU3cKHbNuwG5c/RVmJIwWtjz+O5jRZIGoUQGb/Zktrmnd/etiNDJSGL13ZazCgNGoMHrsBNy9n8jnn8rGpF2qp1ihrQQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900786; c=relaxed/simple;
	bh=nJzxrGQzgx8+7tzW6h73YT6rIUTVlyKyjuP8CLvWGaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck7FvqOdKbt16A44Gy1VcJYfV4nnIp6pNiwCzjBuqpW50QutbSpXozQy05D7yKrFiYdDur/lyvlh/DecOdbLEhM642QZHIwdnzU8A46TSBewdIoL1jz1paj2maWiZYf4/d/QJnL3ZGI1GGscLl31A+mMN9ieKOdo6v40NKzriWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHtBnTLx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723900784; x=1755436784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJzxrGQzgx8+7tzW6h73YT6rIUTVlyKyjuP8CLvWGaU=;
  b=mHtBnTLxVdcle8K92Bi9IQsOanHG4Z91W0iqJ2MDHNlqnQDFLJfO27bN
   QNbqQ5/XAB9JHu5Sc5W3A9Xi7hiLnSefTFPC3Rial4PoM0vm4dSIiIfBf
   o5eXw1TENcuF76s9pZBsx/WSBe6xMGZzOp4J7q43yp01mfTT46pCAlJfG
   +MjJRQjag/jpOaaXMILRxBg4S1ILxuY1A9kFuQDiisWXWGypJYjeHObrV
   QaJF9eEwILY9B+eewmH5Yu1ivp6M+gSFRrh1C4hC6viHNeeL5bcdOhRTG
   YqxKgQ4v7F6y6hVmxZl02zcEgW3YA7pDWMe8VejotGkush2VYxCwmIRcI
   A==;
X-CSE-ConnectionGUID: n+9wSFljSwqXO9m2U/nt8w==
X-CSE-MsgGUID: 26vGKjI/TfSP1B+cvo4hfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="39638877"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="39638877"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 06:19:44 -0700
X-CSE-ConnectionGUID: CtgaLvO1QjyUO4EkidZGfg==
X-CSE-MsgGUID: ehiIDzGkR3aKz9upug7Kjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="64889849"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Aug 2024 06:19:39 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfJLE-0007UW-2W;
	Sat, 17 Aug 2024 13:19:36 +0000
Date: Sat, 17 Aug 2024 21:19:17 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/9] vdso: Add __arch_get_k_vdso_rng_data()
Message-ID: <202408172143.g3Qxmakr-lkp@intel.com>
References: <a7bdbbb14d8635c1e33ada7982cf2cd1a8321e5c.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7bdbbb14d8635c1e33ada7982cf2cd1a8321e5c.1723817900.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes crng-random/master shuah-kselftest/next shuah-kselftest/fixes linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/powerpc-vdso-Don-t-discard-rela-sections/20240816-223917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/a7bdbbb14d8635c1e33ada7982cf2cd1a8321e5c.1723817900.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH 3/9] vdso: Add __arch_get_k_vdso_rng_data()
config: x86_64-buildonly-randconfig-002-20240817 (https://download.01.org/0day-ci/archive/20240817/202408172143.g3Qxmakr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408172143.g3Qxmakr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408172143.g3Qxmakr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: drivers/char/random.o:(.vvar__vdso_rng_data+0x0): multiple definition of `_vdso_rng_data'; kernel/time/vsyscall.o:(.vvar__vdso_rng_data+0x0): first defined here
>> ld: drivers/char/random.o:(.vvar__vdso_data+0x0): multiple definition of `_vdso_data'; kernel/time/vsyscall.o:(.vvar__vdso_data+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

