Return-Path: <linux-arch+bounces-7287-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25704978162
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0222835DD
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB21DB923;
	Fri, 13 Sep 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bagh5QGG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600B1DB53F;
	Fri, 13 Sep 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234922; cv=none; b=is53ILfn+4PYbE2Gcj7rmE5Wj4jrqI7AeUD9jsTJcsDr76WqU+iy/ubMiwlMr/iimNoPlKTTDf8PENfFB3KcGT8+UVawF6WyfMuinkV9ancEkFJMUSkFd+v0MFce1d8xCRKkFW4jb87+6BTdDHKMOYfqRtzeSAwgTUyr6Kb29Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234922; c=relaxed/simple;
	bh=bf8Xv7o4YwxmyAHF0D2eb3sZJQ30HdDrCz7p377435A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkCRDE60i0dhpvYwh1cRTc8SYXyTmwNEJ1iNXQMSFQnCNqIKrIZJth8LKBEfu4fPNH3ztXrmZ5r8zAAeuETOqCY7iU0EzM/dLOhG5iLl24bxroouwsF7RJAuYeMY3QvglRn7d7wV7BH1aIf1M4a1dn2/c0d1FMxhfljAiG3PKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bagh5QGG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726234921; x=1757770921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bf8Xv7o4YwxmyAHF0D2eb3sZJQ30HdDrCz7p377435A=;
  b=bagh5QGGWVQWZrDgCR0CDp/0p2eDTzHrcyvJRqgDAkLMdsRAV7RBeKU4
   hhZ6O2SF/U+4PasUiKQZWUzqoJ0BRCDc9DI+FvUw4CJVsAyOZfUuYv/OJ
   w40N7MwOUl2C+XNRK24zmxFottAgImAdWFuKsvyhDuVi4MQv4/vyZtMYS
   8n6E8yKFTrp86iwcEmKY2uMFz/ucbvmT1rfa5Y1PLCCT5T6+mJVyZ9k5U
   2/Jfohe2oZScluWD1cuQbrNXfnmi9LaSN5fu/JwbyrjCnNkgs5MDeCSCJ
   /6XuX1lx2H6gZOkVSFGzBos8eYO7MkMhmMxXf9YMk8s4Gn9Ga3C/mpV2C
   A==;
X-CSE-ConnectionGUID: mJQozP7UQtivWBuewVcrSw==
X-CSE-MsgGUID: 0f978c5ITDi5PH0XtZXEjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="36269353"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="36269353"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 06:42:01 -0700
X-CSE-ConnectionGUID: kHf73TM5RIylPLXj+wk35Q==
X-CSE-MsgGUID: tskWT6C9TR6TDti5ucK13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98890502"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Sep 2024 06:41:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp6Yc-0006Xq-2m;
	Fri, 13 Sep 2024 13:41:54 +0000
Date: Fri, 13 Sep 2024 21:41:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <202409132145.0UdNx9kr-lkp@intel.com>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on 77f587896757708780a7e8792efe62939f25a5ab]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Lameter-via-B4-Relay/Avoid-memory-barrier-in-read_seqcount-through-load-acquire/20240913-064557
base:   77f587896757708780a7e8792efe62939f25a5ab
patch link:    https://lore.kernel.org/r/20240912-seq_optimize-v3-1-8ee25e04dffa%40gentwo.org
patch subject: [PATCH v3] Avoid memory barrier in read_seqcount() through load acquire
config: i386-buildonly-randconfig-001-20240913 (https://download.01.org/0day-ci/archive/20240913/202409132145.0UdNx9kr-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409132145.0UdNx9kr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409132145.0UdNx9kr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/gem/i915_gem_pages.c:11:
>> drivers/gpu/drm/i915/gt/intel_tlb.h:21:40: error: too few arguments provided to function-like macro invocation
      21 |         return seqprop_sequence(&gt->tlb.seqno);
         |                                               ^
   include/linux/seqlock.h:280:9: note: macro 'seqprop_sequence' defined here
     280 | #define seqprop_sequence(s, a)          __seqprop(s, sequence)(s, a)
         |         ^
   In file included from drivers/gpu/drm/i915/gem/i915_gem_pages.c:11:
>> drivers/gpu/drm/i915/gt/intel_tlb.h:21:9: error: use of undeclared identifier 'seqprop_sequence'; did you mean '__seqprop_sequence'?
      21 |         return seqprop_sequence(&gt->tlb.seqno);
         |                ^~~~~~~~~~~~~~~~
         |                __seqprop_sequence
   include/linux/seqlock.h:228:24: note: '__seqprop_sequence' declared here
     228 | static inline unsigned __seqprop_sequence(const seqcount_t *s, bool acquire)
         |                        ^
   In file included from drivers/gpu/drm/i915/gem/i915_gem_pages.c:11:
>> drivers/gpu/drm/i915/gt/intel_tlb.h:21:9: error: incompatible pointer to integer conversion returning 'unsigned int (const seqcount_t *, bool)' (aka 'unsigned int (const struct seqcount *, _Bool)') from a function with result type 'u32' (aka 'unsigned int') [-Wint-conversion]
      21 |         return seqprop_sequence(&gt->tlb.seqno);
         |                ^~~~~~~~~~~~~~~~
   3 errors generated.


vim +21 drivers/gpu/drm/i915/gt/intel_tlb.h

568a2e6f0b12ee Chris Wilson 2023-08-01  18  
568a2e6f0b12ee Chris Wilson 2023-08-01  19  static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
568a2e6f0b12ee Chris Wilson 2023-08-01  20  {
568a2e6f0b12ee Chris Wilson 2023-08-01 @21  	return seqprop_sequence(&gt->tlb.seqno);
568a2e6f0b12ee Chris Wilson 2023-08-01  22  }
568a2e6f0b12ee Chris Wilson 2023-08-01  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

