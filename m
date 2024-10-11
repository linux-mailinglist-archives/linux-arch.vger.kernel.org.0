Return-Path: <linux-arch+bounces-8032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6899A23E
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 13:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F361C2371E
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF5215034;
	Fri, 11 Oct 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igh7jvd6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79320CCC6;
	Fri, 11 Oct 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644658; cv=none; b=t90Dwh7ZLawZPNgkqd9Mrlt7w7jYRmD1TQTZeqIjZqNGPqlPJPJqhPk0xV0MCD0rr9U+EutUnHtmeQ6Sf+FZYuTYRIXqxNHJh+wAct+xYMZ14+pTqSnSLHeeTsIq2E2xfvYGja73F2t5Xka8AGNtSQqYrpmwP7NUbwZo6nqdr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644658; c=relaxed/simple;
	bh=bsHr9P9sn418fzmWs5e8FSsCYUJqwNAwWk9X37ZYTSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2rQdfBZ5t9JSwol1vfkB1ChDIX5XjprvB0c851W5k51244nM+FP5AIJ8dIXSlCxez2tNnyE6QgHYNAVuFXly6Q5quWPVfFzL7igzQ2V/DeRzZVAC94GSJ/4Ul8Z2Sicni2Yugpc68rJOjQ8aZLYc2Acx0v+am1dzJ0EurYaJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igh7jvd6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728644656; x=1760180656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bsHr9P9sn418fzmWs5e8FSsCYUJqwNAwWk9X37ZYTSU=;
  b=igh7jvd6KCUwlGdE8a2wKJIvkqqrGzix53339a3J91HzSWJWgliNg5cJ
   xLTMlokr8cakeh9+ePeRYyRZQiYNyOasszExOfJ/69A5ldUq/IoxyUB34
   10/4RTkvYnsLbi0RPJd5dH6TRhCQ8t/YieDuTLc1suNOz2i9iiG33eFq4
   Q1fdpBIl7eNLO5hD9avtRIMFdPgGHDCGkN4uJwZoWFm66tmE4UD7zhebx
   l86KrmNRoQVw2f1GHJqDETkdiBMTn9VNvoKBRDqVuW9hyieKjNKpnnpxd
   s/5FyYVIHObbkJnI23DdvOOolN9F4/KyF7sIjS1yEFvWyiIBKP5GIlOU8
   Q==;
X-CSE-ConnectionGUID: IvtbN3eBRI6oN5obWOhP5g==
X-CSE-MsgGUID: 9UqawQekRcqbcS8nC4zbtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27910862"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27910862"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 04:04:15 -0700
X-CSE-ConnectionGUID: UiIz4troTV+b5Eg7RWr4cg==
X-CSE-MsgGUID: 4LFB6g60QouKVazavHWv3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76987510"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Oct 2024 04:04:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szDRK-000CDG-0P;
	Fri, 11 Oct 2024 11:04:10 +0000
Date: Fri, 11 Oct 2024 19:03:55 +0800
From: kernel test robot <lkp@intel.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 2/2] vdso: Introduce vdso/page.h
Message-ID: <202410112106.mvc2U2p0-lkp@intel.com>
References: <20241010135146.181175-3-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010135146.181175-3-vincenzo.frascino@arm.com>

Hi Vincenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on vgupta-arc/for-curr]
[also build test ERROR on arm64/for-next/core geert-m68k/for-next geert-m68k/for-linus deller-parisc/for-next powerpc/next powerpc/fixes s390/features uml/next tip/x86/core linus/master v6.12-rc2 next-20241011]
[cannot apply to vgupta-arc/for-next uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincenzo-Frascino/drm-i915-Change-fault-type-to-unsigned-long/20241010-215325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git for-curr
patch link:    https://lore.kernel.org/r/20241010135146.181175-3-vincenzo.frascino%40arm.com
patch subject: [PATCH v4 2/2] vdso: Introduce vdso/page.h
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241011/202410112106.mvc2U2p0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410112106.mvc2U2p0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410112106.mvc2U2p0-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
>> arch/s390/include/asm/page.h:17:9: warning: 'PAGE_SHIFT' macro redefined [-Wmacro-redefined]
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |         ^
   include/vdso/page.h:13:9: note: previous definition is here
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
>> arch/s390/include/asm/page.h:18:9: warning: 'PAGE_SIZE' macro redefined [-Wmacro-redefined]
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |         ^
   include/vdso/page.h:15:9: note: previous definition is here
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
>> arch/s390/include/asm/page.h:19:9: warning: 'PAGE_MASK' macro redefined [-Wmacro-redefined]
      19 | #define PAGE_MASK       _PAGE_MASK
         |         ^
   include/vdso/page.h:27:9: note: previous definition is here
      27 | #define PAGE_MASK       (~(PAGE_SIZE - 1))
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
>> arch/s390/include/asm/page.h:253:14: error: use of undeclared identifier '_PAGE_SHIFT'
     253 |         return __va(pfn_to_phys(pfn));
         |                     ^
   arch/s390/include/asm/page.h:244:36: note: expanded from macro 'pfn_to_phys'
     244 | #define pfn_to_phys(pfn)        ((pfn) << PAGE_SHIFT)
         |                                           ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   arch/s390/include/asm/page.h:258:9: error: use of undeclared identifier '_PAGE_SHIFT'
     258 |         return phys_to_pfn(__pa(kaddr));
         |                ^
   arch/s390/include/asm/page.h:243:38: note: expanded from macro 'phys_to_pfn'
     243 | #define phys_to_pfn(phys)       ((phys) >> PAGE_SHIFT)
         |                                            ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
   In file included from arch/s390/include/asm/page.h:273:
>> include/asm-generic/getorder.h:33:27: error: use of undeclared identifier '_PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
   In file included from arch/s390/include/asm/page.h:273:
   include/asm-generic/getorder.h:35:22: error: use of undeclared identifier '_PAGE_SHIFT'
      35 |                 if (size < (1UL << PAGE_SHIFT))
         |                                    ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
   In file included from arch/s390/include/asm/page.h:273:
   include/asm-generic/getorder.h:38:30: error: use of undeclared identifier '_PAGE_SHIFT'
      38 |                 return ilog2((size) - 1) - PAGE_SHIFT + 1;
         |                                            ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from arch/s390/include/asm/preempt.h:6:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/s390/include/asm/thread_info.h:31:
   In file included from arch/s390/include/asm/page.h:273:
   include/asm-generic/getorder.h:42:11: error: use of undeclared identifier '_PAGE_SHIFT'
      42 |         size >>= PAGE_SHIFT;
         |                  ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:14:
   In file included from include/linux/smp.h:119:
   In file included from arch/s390/include/asm/smp.h:12:
>> arch/s390/include/asm/processor.h:287:45: error: use of undeclared identifier '_PAGE_SIZE'
     287 |         return !((ksp ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
         |                                                    ^
   arch/s390/include/asm/thread_info.h:25:22: note: expanded from macro 'THREAD_SIZE'
      25 | #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                      ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:12:
>> include/linux/sched.h:1890:22: error: use of undeclared identifier '_PAGE_SIZE'
    1890 |         unsigned long stack[THREAD_SIZE/sizeof(long)];
         |                             ^
   arch/s390/include/asm/thread_info.h:25:22: note: expanded from macro 'THREAD_SIZE'
      25 | #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                      ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:12:
   include/linux/sched.h:1897:33: error: use of undeclared identifier '_PAGE_SIZE'
    1897 | extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
         |                                 ^
   arch/s390/include/asm/thread_info.h:25:22: note: expanded from macro 'THREAD_SIZE'
      25 | #define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                      ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:116:5: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     116 |                         (set1->sig[1] == set2->sig[1]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:116:21: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     116 |                         (set1->sig[1] == set2->sig[1]) &&
         |                                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
--
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:187:1: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:10: note: expanded from macro '_SIG_SET_OP'
     174 |         case 4: set->sig[3] = op(set->sig[3]);                          \
         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:187:1: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:175:20: note: expanded from macro '_SIG_SET_OP'
     175 |                 set->sig[2] = op(set->sig[2]);                          \
         |                                  ^        ~
   include/linux/signal.h:186:24: note: expanded from macro '_sig_not'
     186 | #define _sig_not(x)     (~(x))
         |                            ^
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:187:1: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:175:3: note: expanded from macro '_SIG_SET_OP'
     175 |                 set->sig[2] = op(set->sig[2]);                          \
         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:187:1: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:177:27: note: expanded from macro '_SIG_SET_OP'
     177 |         case 2: set->sig[1] = op(set->sig[1]);                          \
         |                                  ^        ~
   include/linux/signal.h:186:24: note: expanded from macro '_sig_not'
     186 | #define _sig_not(x)     (~(x))
         |                            ^
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:187:1: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:177:10: note: expanded from macro '_SIG_SET_OP'
     177 |         case 2: set->sig[1] = op(set->sig[1]);                          \
         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:198:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     198 |         case 2: set->sig[1] = 0;
         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:211:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     211 |         case 2: set->sig[1] = -1;
         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:242:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     242 |         case 2: set->sig[1] = 0;
         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:255:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     255 |         case 2: set->sig[1] = -1;
         |                 ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
>> include/linux/mm_types.h:547:6: warning: '_PAGE_SIZE' is not defined, evaluates to 0 [-Wundef]
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |      ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
>> include/linux/mm_types.h:547:18: warning: '_PAGE_MASK' is not defined, evaluates to 0 [-Wundef]
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^
   include/linux/mm_types.h:524:55: note: expanded from macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^
   arch/s390/include/asm/page.h:19:19: note: expanded from macro 'PAGE_MASK'
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
>> include/linux/mm_types.h:547:18: warning: '_PAGE_MASK' is not defined, evaluates to 0 [-Wundef]
   include/linux/mm_types.h:524:55: note: expanded from macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^
   arch/s390/include/asm/page.h:19:19: note: expanded from macro 'PAGE_MASK'
      19 | #define PAGE_MASK       _PAGE_MASK
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:23:
>> include/linux/page-flags.h:214:38: error: use of undeclared identifier '_PAGE_SIZE'
     214 |         if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
         |                                             ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
>> include/linux/mmzone.h:1777:23: warning: '_PAGE_SHIFT' is not defined, evaluates to 0 [-Wundef]
    1777 | #if (MAX_PAGE_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
         |                       ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
>> include/linux/mmzone.h:1783:16: error: use of undeclared identifier '_PAGE_SHIFT'
    1783 |         return pfn >> PFN_SECTION_SHIFT;
         |                       ^
   include/linux/mmzone.h:1767:48: note: expanded from macro 'PFN_SECTION_SHIFT'
    1767 | #define PFN_SECTION_SHIFT       (SECTION_SIZE_BITS - PAGE_SHIFT)
         |                                                      ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   include/linux/mmzone.h:1787:16: error: use of undeclared identifier '_PAGE_SHIFT'
    1787 |         return sec << PFN_SECTION_SHIFT;
         |                       ^
   include/linux/mmzone.h:1767:48: note: expanded from macro 'PFN_SECTION_SHIFT'
    1767 | #define PFN_SECTION_SHIFT       (SECTION_SIZE_BITS - PAGE_SHIFT)
         |                                                      ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
>> include/linux/mmzone.h:1875:23: error: use of undeclared identifier '_PAGE_SIZE'
    1875 |         unsigned long root = SECTION_NR_TO_ROOT(nr);
         |                              ^
   include/linux/mmzone.h:1858:42: note: expanded from macro 'SECTION_NR_TO_ROOT'
    1858 | #define SECTION_NR_TO_ROOT(sec) ((sec) / SECTIONS_PER_ROOT)
         |                                          ^
   include/linux/mmzone.h:1853:34: note: expanded from macro 'SECTIONS_PER_ROOT'
    1853 | #define SECTIONS_PER_ROOT       (PAGE_SIZE / sizeof (struct mem_section))
         |                                  ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   include/linux/mmzone.h:1877:23: error: use of undeclared identifier '_PAGE_SIZE'
    1877 |         if (unlikely(root >= NR_SECTION_ROOTS))
         |                              ^
   include/linux/mmzone.h:1859:56: note: expanded from macro 'NR_SECTION_ROOTS'
    1859 | #define NR_SECTION_ROOTS        DIV_ROUND_UP(NR_MEM_SECTIONS, SECTIONS_PER_ROOT)
         |                                                               ^
   include/linux/mmzone.h:1853:34: note: expanded from macro 'SECTIONS_PER_ROOT'
    1853 | #define SECTIONS_PER_ROOT       (PAGE_SIZE / sizeof (struct mem_section))
         |                                  ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   include/linux/mmzone.h:1877:23: error: use of undeclared identifier '_PAGE_SIZE'
   include/linux/mmzone.h:1859:56: note: expanded from macro 'NR_SECTION_ROOTS'
    1859 | #define NR_SECTION_ROOTS        DIV_ROUND_UP(NR_MEM_SECTIONS, SECTIONS_PER_ROOT)
         |                                                               ^
   include/linux/mmzone.h:1853:34: note: expanded from macro 'SECTIONS_PER_ROOT'
    1853 | #define SECTIONS_PER_ROOT       (PAGE_SIZE / sizeof (struct mem_section))
         |                                  ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   include/linux/mmzone.h:1884:33: error: use of undeclared identifier '_PAGE_SIZE'
    1884 |         return &mem_section[root][nr & SECTION_ROOT_MASK];
         |                                        ^
   include/linux/mmzone.h:1860:28: note: expanded from macro 'SECTION_ROOT_MASK'
    1860 | #define SECTION_ROOT_MASK       (SECTIONS_PER_ROOT - 1)
         |                                  ^
   include/linux/mmzone.h:1853:34: note: expanded from macro 'SECTIONS_PER_ROOT'
    1853 | #define SECTIONS_PER_ROOT       (PAGE_SIZE / sizeof (struct mem_section))
         |                                  ^
   arch/s390/include/asm/page.h:18:19: note: expanded from macro 'PAGE_SIZE'
      18 | #define PAGE_SIZE       _PAGE_SIZE
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   include/linux/mmzone.h:1996:18: error: use of undeclared identifier '_PAGE_SHIFT'
    1996 |         return (pfn & ~(PAGE_SECTION_MASK)) / PAGES_PER_SUBSECTION;
         |                         ^
   include/linux/mmzone.h:1772:30: note: expanded from macro 'PAGE_SECTION_MASK'
    1772 | #define PAGE_SECTION_MASK       (~(PAGES_PER_SECTION-1))
         |                                    ^
   include/linux/mmzone.h:1771:41: note: expanded from macro 'PAGES_PER_SECTION'
    1771 | #define PAGES_PER_SECTION       (1UL << PFN_SECTION_SHIFT)
         |                                         ^
   include/linux/mmzone.h:1767:48: note: expanded from macro 'PFN_SECTION_SHIFT'
    1767 | #define PFN_SECTION_SHIFT       (SECTION_SIZE_BITS - PAGE_SHIFT)
         |                                                      ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   include/linux/mmzone.h:1996:40: error: use of undeclared identifier '_PAGE_SHIFT'
    1996 |         return (pfn & ~(PAGE_SECTION_MASK)) / PAGES_PER_SUBSECTION;
         |                                               ^
   include/linux/mmzone.h:1797:38: note: expanded from macro 'PAGES_PER_SUBSECTION'
    1797 | #define PAGES_PER_SUBSECTION (1UL << PFN_SUBSECTION_SHIFT)
         |                                      ^
   include/linux/mmzone.h:1796:50: note: expanded from macro 'PFN_SUBSECTION_SHIFT'
    1796 | #define PFN_SUBSECTION_SHIFT (SUBSECTION_SHIFT - PAGE_SHIFT)
         |                                                  ^
   arch/s390/include/asm/page.h:17:20: note: expanded from macro 'PAGE_SHIFT'
      17 | #define PAGE_SHIFT      _PAGE_SHIFT
         |                         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   include/linux/mmzone.h:2037:15: error: use of undeclared identifier '_PAGE_SHIFT'
    2037 |         if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
         |                      ^
   include/linux/pfn.h:21:42: note: expanded from macro 'PFN_PHYS'


vim +/_PAGE_SHIFT +253 arch/s390/include/asm/page.h

014b020475d4b9 Alexander Gordeev 2020-02-25  250  
2d1494fb31405d Linus Walleij     2023-08-12  251  static inline void *pfn_to_virt(unsigned long pfn)
2d1494fb31405d Linus Walleij     2023-08-12  252  {
2d1494fb31405d Linus Walleij     2023-08-12 @253  	return __va(pfn_to_phys(pfn));
2d1494fb31405d Linus Walleij     2023-08-12  254  }
2d1494fb31405d Linus Walleij     2023-08-12  255  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

