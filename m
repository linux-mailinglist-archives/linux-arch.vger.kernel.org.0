Return-Path: <linux-arch+bounces-6279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C789557E8
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 14:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904FE1F22448
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8009150994;
	Sat, 17 Aug 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3RTQsh+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E11854;
	Sat, 17 Aug 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898923; cv=none; b=ILyqCwCdBe4QzVvLoNtZ8Bte59Bpw6APfsAtyUaShdZH5RrpxDkS+/xO2mD+30oAjufTSfNkLarNcLTXTDHSZVNoGZkqbzszUwspf8kdY3LPYX2Ax2aG3z0tnemqdPEEcZX3YRy7gFAO9z+5lL0Y5qD/ereGIeYbIBkbUaNyfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898923; c=relaxed/simple;
	bh=3AlbDRi86u9EhNaNflWrcwKVKeWeCwuXaFv/Oj7Z604=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe4TyaTSZ4ETHasK89u7PphQT0cqKmBCIQF9SIdUHwqQPSCuprf/SbJ08G0IwGNNXlEiaFkuRmYi4LAFw/0qD3Dlz+UWZ1T0vPvGe0iVATmFrJo5HhugRrfMPG3f1zgAHRwPSgMGu2kTldE8QVjm0OwBtwzhjwg59YcKrdBKV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3RTQsh+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723898922; x=1755434922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3AlbDRi86u9EhNaNflWrcwKVKeWeCwuXaFv/Oj7Z604=;
  b=A3RTQsh+0WHvwtFA18DoIk3eeeX1/9mkTOFbCqpQO6PwownezlDDIf9E
   rJpNvKVWa0a1xLk42O1fsVWnLsyrVj3GkN0UaGMuzRGTU64PcrxM+DSrE
   FAkUaz+PdFMfJU/S/CFe/bu58T+ZNoTFZeGg0lDAcM9HJzrsf6cbYGUOK
   VxI8PI+sTVd+BWogzDsbduYrQb0WEDyusCC2hJFQorYZm0E+p8LocLgHT
   +9KO5eq9K8u3n52vlw0KXOtSd1biJh778pd4oPbj8EBM52Hn+RYAL/z2l
   8W+3UgNBGiPfUBOslj0EKcAfC10H+rn8rK9stEZUaNY+U6CH4b7DAxZOd
   w==;
X-CSE-ConnectionGUID: IjYb4DbzQvORi1NsSOrioA==
X-CSE-MsgGUID: GZ0h+txWTGm2EhRRkxpHpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="33568594"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="33568594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 05:48:42 -0700
X-CSE-ConnectionGUID: M2214yHERHSVfojmdFc6jw==
X-CSE-MsgGUID: ra6VrFjoQ+6mTaOAaVmbEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="90672395"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Aug 2024 05:48:37 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfIrC-0007Sg-1D;
	Sat, 17 Aug 2024 12:48:34 +0000
Date: Sat, 17 Aug 2024 20:48:27 +0800
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
Message-ID: <202408172056.OAokF1z5-lkp@intel.com>
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
config: x86_64-randconfig-003-20240817 (https://download.01.org/0day-ci/archive/20240817/202408172056.OAokF1z5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408172056.OAokF1z5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408172056.OAokF1z5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: drivers/char/random.o:arch/x86/include/asm/vdso/vsyscall.h:13: multiple definition of `_vdso_rng_data'; kernel/time/vsyscall.o:arch/x86/include/asm/vdso/vsyscall.h:13: first defined here
>> ld: drivers/char/random.o:arch/x86/include/asm/vdso/vsyscall.h:12: multiple definition of `_vdso_data'; kernel/time/vsyscall.o:arch/x86/include/asm/vdso/vsyscall.h:12: first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

