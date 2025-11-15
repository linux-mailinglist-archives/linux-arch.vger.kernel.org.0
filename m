Return-Path: <linux-arch+bounces-14799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55533C5FD13
	for <lists+linux-arch@lfdr.de>; Sat, 15 Nov 2025 02:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 050EA4E3970
	for <lists+linux-arch@lfdr.de>; Sat, 15 Nov 2025 01:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0319F127;
	Sat, 15 Nov 2025 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQ6VT86g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB512A1C7;
	Sat, 15 Nov 2025 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169185; cv=none; b=f1d8tgZA5iDWa6r+IKriUncgfZs1Cpssurn4EIIn6y8vSafmG/eGQDRsVPpEiiAT4IfXjJ1C686pf6VwRFAjJTJQlpkL/r166sFsHJpLtsd/zrickiS4Y33EzVWW9GyIvOnO85uDNloH9SPft7H8+MVzAiPlruKzUKBfU0OgXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169185; c=relaxed/simple;
	bh=ZYpyydEIKJdUZcKYOQA153wYBuCQw3r8OGWjWBD7bf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok3R8BiIvCEcPnjCQZk0YQfsbL0qMW637gAdpXbl/fwDT8ltWXeiW1YPBKF4VgzNl+oXdruWZ2IcuYl29ZCH1dk7RiD6LXLH/o/DrZY1VHT3d5I0hpO5qCM4zgYAuvLizoDjgkc5PwSqz8dAbdYc+cH4vJ6aa/m2RxG48iQfJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQ6VT86g; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763169185; x=1794705185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZYpyydEIKJdUZcKYOQA153wYBuCQw3r8OGWjWBD7bf0=;
  b=GQ6VT86gYd0zdopeUWvYFUKPw/stO6DxY1sbhFnQpqP5x5Ls2nzV5d81
   Co+vW1XzBrID5yjAoKXxuR2sTtppKBrcx8rlcrc7hlqkANE72xRUC5hW7
   zLMrb+LjwNbfeOnQvY08oCtViiKftD4NPtFpiWEoszJcoLAix7t4Txd23
   PkpE2x0EkL3Y48nUpvWvGD8rKUQeMAlqT1dxt0tzA4Um2OcqoRE4qASEH
   Am0cOxl9TIFuMBZO1MUQb90TtkjY+l1yV/qfqGPTqFZ2mk7OvRlC6sRw5
   1ZzIP2RUzfCMqGZtg4ukaDIeFGNysD7Vz1R++7OqNpXLjTI0zBK72GOxw
   Q==;
X-CSE-ConnectionGUID: cPmPaZU1SKaYUB+870+RMQ==
X-CSE-MsgGUID: 6FgbEz60Q8e6X5i7zlgleA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="65152400"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="65152400"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 17:13:04 -0800
X-CSE-ConnectionGUID: OyXkE+18SIC4r9bUHnq2cQ==
X-CSE-MsgGUID: 7wNDei3wRnCT1vSqROvBmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="194228351"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Nov 2025 17:12:59 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vK4qW-0007Zv-1X;
	Sat, 15 Nov 2025 01:12:56 +0000
Date: Sat, 15 Nov 2025 09:12:35 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
	akpm@linux-foundation.org, david@redhat.com, ioworker0@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
Message-ID: <202511150832.iAyO0SAW-lkp@intel.com>
References: <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>

Hi Qi,

kernel test robot noticed the following build errors:

[auto build test ERROR on deller-parisc/for-next]
[also build test ERROR on uml/next tip/x86/core akpm-mm/mm-everything linus/master v6.18-rc5 next-20251114]
[cannot apply to uml/fixes vgupta-arc/for-next vgupta-arc/for-curr]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/alpha-mm-enable-MMU_GATHER_RCU_TABLE_FREE/20251114-191543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
patch link:    https://lore.kernel.org/r/0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch%40bytedance.com
patch subject: [PATCH 7/7] mm: make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE && 64BIT
config: arm64-randconfig-002-20251115 (https://download.01.org/0day-ci/archive/20251115/202511150832.iAyO0SAW-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251115/202511150832.iAyO0SAW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511150832.iAyO0SAW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/pt_reclaim.c:31:2: error: call to undeclared function '__pte_free_tlb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      31 |         pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
         |         ^
   include/asm-generic/tlb.h:731:3: note: expanded from macro 'pte_free_tlb'
     731 |                 __pte_free_tlb(tlb, ptep, address);             \
         |                 ^
   1 error generated.


vim +/__pte_free_tlb +31 mm/pt_reclaim.c

6375e95f381e3d Qi Zheng 2024-12-04  27  
6375e95f381e3d Qi Zheng 2024-12-04  28  void free_pte(struct mm_struct *mm, unsigned long addr, struct mmu_gather *tlb,
6375e95f381e3d Qi Zheng 2024-12-04  29  	      pmd_t pmdval)
6375e95f381e3d Qi Zheng 2024-12-04  30  {
6375e95f381e3d Qi Zheng 2024-12-04 @31  	pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
6375e95f381e3d Qi Zheng 2024-12-04  32  	mm_dec_nr_ptes(mm);
6375e95f381e3d Qi Zheng 2024-12-04  33  }
6375e95f381e3d Qi Zheng 2024-12-04  34  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

