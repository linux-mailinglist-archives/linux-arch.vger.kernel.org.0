Return-Path: <linux-arch+bounces-8004-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25BA9995CA
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 01:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F901F246C1
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 23:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49C1E7658;
	Thu, 10 Oct 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrMGFW+b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC91E3DE0;
	Thu, 10 Oct 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603648; cv=none; b=EtkS/iCz+Urd3FjmyojymBnNE5x42vB01sJ056o8GndXY8eeaqY33dbdCl527eMasWHEzvnJIeAqt/zvrvbmbbVtYQmSw5kuwWbm5leytsDcij9UjuI6pnSEZ34Q8ublDNRQ/jlyzGPM2L/TE2MLZLEybW7MhzIIv8WC8IZUqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603648; c=relaxed/simple;
	bh=iGGlFY2rrvyG4+iAA/qO6ZG9WmpdD1GQIKwf3ap0s6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PenpxCQ6akFsRUAXSIBKyt4e/RAL4cEnF6j4MGidoNz8V3F/sMMgJoplsowrJ12jUjXufp5B61nanPOMHjDdo8DKV2B6lMmzJDYs/HhVWdFR439Ls5Pa+oSPMrpIIwOr3wUfHxBjhPbG+MTdsbZkSNxYXM8Cbu0aNqD7WGyyxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrMGFW+b; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728603647; x=1760139647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iGGlFY2rrvyG4+iAA/qO6ZG9WmpdD1GQIKwf3ap0s6M=;
  b=KrMGFW+bHOnVGqmGM4p8QhtcNx/wLAX/jantSx0cII/BMUXZnR0HouFl
   vZ8OmT+NedOIxopQNmW5UCe7X7DYCCdZPnDTLhTU7P5d2eeqFbTreY97Q
   TgePki+GDPmOroOzQdvkJgzTxhNbIROYB5GtfLpA+Y7UEh+ypSJGxdvYN
   etLQJWuPfwUwb0XOoNWBd43AwG60TwptDDaMjcDTU/OeljgqzEi7JbQfQ
   JTdP0j9M2ogikUgJpntoJ+l8lyigeD0krLiRNEj7Fl/XBkd0e1Tz6lurs
   kFvu0S596Yg1pQzwROyIzgesbjD7yNMAbPwk7oXd8Wc2TTiFb7yz4ImvF
   A==;
X-CSE-ConnectionGUID: cMz3OFk7SVmErx/UvdXKaA==
X-CSE-MsgGUID: aka81XBSSEq1A/yHq6P9+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28081158"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28081158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 16:40:46 -0700
X-CSE-ConnectionGUID: HszBBIMRTr6Xau5a/ruJOA==
X-CSE-MsgGUID: yugHOdlDQkiylavkANyiSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81347586"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 16:40:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sz2lp-000BPx-04;
	Thu, 10 Oct 2024 23:40:37 +0000
Date: Fri, 11 Oct 2024 07:39:57 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-ID: <202410110707.OaEI6wYh-lkp@intel.com>
References: <20241007204743.41314f1d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007204743.41314f1d@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20241004]
[cannot apply to s390/features arm64/for-next/core powerpc/next powerpc/fixes linus/master v6.12-rc2 v6.12-rc1 v6.11 v6.12-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ftrace-Make-ftrace_regs-abstract-from-direct-use/20241008-084930
base:   next-20241004
patch link:    https://lore.kernel.org/r/20241007204743.41314f1d%40gandalf.local.home
patch subject: [PATCH] ftrace: Make ftrace_regs abstract from direct use
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20241011/202410110707.OaEI6wYh-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410110707.OaEI6wYh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410110707.OaEI6wYh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/openrisc/include/generated/asm/ftrace.h:1,
                    from include/linux/ftrace.h:23,
                    from include/linux/perf_event.h:52,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:93,
                    from init/main.c:21:
>> include/asm-generic/ftrace.h:5: error: unterminated #ifndef
       5 | #ifndef __ASM_GENERIC_FTRACE_H__


vim +5 include/asm-generic/ftrace.h

38f5bf84bd588a GuanXuetao 2011-01-15 @5  #ifndef __ASM_GENERIC_FTRACE_H__
38f5bf84bd588a GuanXuetao 2011-01-15  6  #define __ASM_GENERIC_FTRACE_H__
38f5bf84bd588a GuanXuetao 2011-01-15  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

