Return-Path: <linux-arch+bounces-8831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B29BAF0E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 10:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D2C1C219AC
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492B1AC426;
	Mon,  4 Nov 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3SuE4ZA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6B1AB507;
	Mon,  4 Nov 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711107; cv=none; b=ZHRPTudCBTXWt3Ysj7hVBCNyOIgX4BUn+/AIRWY3jh9byGdwm+B8+lk8HVlGcbzUzVKPzHieyW7WPtbCcxfvgWewS6gmRkc2MpEdE3ypA5qbkqqnI2+ncXABQj6W3x1LbDudkKEous4oF+goHqjvSIPyyRfrswnp1xzvKEOD1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711107; c=relaxed/simple;
	bh=YxpTatOZCyamBYTrl1KGmff6TcW5/0IaMURbSuA1bRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvi96Wr/FicYIymljc+fUft5OD67Ka+ghQZ7ig2sBloNhSHqL/fioEWlT3QP+P12HKt0CgD4a2Axz3V08mdspiXDSkIqIKZyMZGdUWZcJokASl2F5/lrR/p8Zj9+u4Dht3ZosiK+nKL79kudQOMY88LjOx8G0NwC0vK87vHkAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3SuE4ZA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730711106; x=1762247106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YxpTatOZCyamBYTrl1KGmff6TcW5/0IaMURbSuA1bRs=;
  b=S3SuE4ZAXJ2qiNvAKhcaPzduGajS3Lt+dw4ZMM5IAdM5HYy1ZuquAVjy
   +qkVHSafTPshB3RCO1Q69OTVohAlVfVD49C2aJozQgA4sLkxHSYXJy+94
   4snZqsvida4/vLe0q+1qphgih+bUwVS3szjSiKSm2XfDJsmyx37yxZ+FH
   1rB2o+5SlSCxoJJ65bqzXmWeSkwBbKi8/vTkwGPTPC0sKYVZT9V55fn3W
   /iZMMRctP2Zj0RMizyfgjKNyito2xfz4RT61cIzE7CfRFvAn0ifn/QzyT
   czwNwD1oiPC7AlDaTtqFMZhmEBnw27mIMtVu3y2fat3J7bC3SEcZjlrny
   g==;
X-CSE-ConnectionGUID: TAswzz1BTWWghYgfiIYBig==
X-CSE-MsgGUID: MKgr6ToTT5uIF5dLUrrqPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="55797122"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="55797122"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 01:05:05 -0800
X-CSE-ConnectionGUID: ebv1R6qRT+2i4k8PHCqdPw==
X-CSE-MsgGUID: Mf8Ep902TI2Ai7UY3aK1gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83523755"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Nov 2024 01:04:58 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7t16-000kfn-0q;
	Mon, 04 Nov 2024 09:04:56 +0000
Date: Mon, 4 Nov 2024 17:04:10 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <202411041609.gxjI2dsw-lkp@intel.com>
References: <20241103145153.105097-14-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103145153.105097-14-alexghiti@rivosinc.com>

Hi Alexandre,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on robh/for-next tip/locking/core linus/master v6.12-rc6]
[cannot apply to next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Move-cpufeature-h-macros-into-their-own-header/20241103-230614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20241103145153.105097-14-alexghiti%40rivosinc.com
patch subject: [PATCH v6 13/13] riscv: Add qspinlock support
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411041609.gxjI2dsw-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> arch/riscv/include/asm/spinlock.h: asm/ticket_spinlock.h is included more than once.
>> arch/riscv/include/asm/spinlock.h: asm/qspinlock.h is included more than once.

vim +10 arch/riscv/include/asm/spinlock.h

     8	
     9	#define __no_arch_spinlock_redefine
  > 10	#include <asm/ticket_spinlock.h>
    11	#include <asm/qspinlock.h>
    12	#include <asm/jump_label.h>
    13	
    14	/*
    15	 * TODO: Use an alternative instead of a static key when we are able to parse
    16	 * the extensions string earlier in the boot process.
    17	 */
    18	DECLARE_STATIC_KEY_TRUE(qspinlock_key);
    19	
    20	#define SPINLOCK_BASE_DECLARE(op, type, type_lock)			\
    21	static __always_inline type arch_spin_##op(type_lock lock)		\
    22	{									\
    23		if (static_branch_unlikely(&qspinlock_key))			\
    24			return queued_spin_##op(lock);				\
    25		return ticket_spin_##op(lock);					\
    26	}
    27	
    28	SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
    29	SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
    30	SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
    31	SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
    32	SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
    33	SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
    34	
    35	#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
    36	
    37	#include <asm/qspinlock.h>
    38	
    39	#else
    40	
  > 41	#include <asm/ticket_spinlock.h>
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

