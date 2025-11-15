Return-Path: <linux-arch+bounces-14798-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B8C5FC64
	for <lists+linux-arch@lfdr.de>; Sat, 15 Nov 2025 01:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C07604E7896
	for <lists+linux-arch@lfdr.de>; Sat, 15 Nov 2025 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDE14BF92;
	Sat, 15 Nov 2025 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWyVWeTA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3284A21;
	Sat, 15 Nov 2025 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763167923; cv=none; b=d4WH4lma0OaWqq2Yg/+Fv7CWWlis5As4/kL8Nc54ND/ZJf0H1U/O3g6kMOOF0CJ+oUX1zp6UJxnOle8odYXWOHXp0en0VxpTKNXJ1W0hCooP+8ouixNYfqE1V661sARNd8BytbSAyVc72FzxR+RzJR9uMBYfA8FdGFyWiKGoUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763167923; c=relaxed/simple;
	bh=vczM4EmXtUbCfHooelDeHpgPNn3rTsFNVUclJSubvyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHkH6LAUSfEYZPVNjJkHYkMdP51CYIL9+WJ0JxqZxKLathLP57pPTWBMlG8NTC4b8i6PNmK/jU7LorPaPgSuE2kLNJvuFAZ+23z05FlcuR/betrFYc/pO/X9aF92e5dYfmixChIhBW8CM2NHgHSXQb7g9Sb4TIdPkYCcAe1qLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWyVWeTA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763167922; x=1794703922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vczM4EmXtUbCfHooelDeHpgPNn3rTsFNVUclJSubvyA=;
  b=mWyVWeTAUahsYKNSAoDTZmuyaG01ZS8GM8czgRay2hPSTgGPjnZT27VQ
   3RGWvbqWJSHmQsUdypGTvhtsgZkwb1mFf6TDlfY8+B9P19BIeuAlmvpoF
   rd/gljnZg5cOjRwXvuCKWSQ5tFtaqzCnKhRbEQ/iHcNUxnSU2EKT+wA6y
   p5C0huHoYWHIsO/AnhjaIx6DYGuDd2+HQbNVmo0bSWtAZbZE6IFI2BSLc
   M1tXKtNX93/66+bVb+ow2j9wsWql6cgp9z4yqGIDBWROFPGBhyDC1lcG9
   aYhCCZLWeJ5Yyw9tz5JErMR9V8SNx9cmlO2zCR8SLVFPurbGFHLNvCUPN
   Q==;
X-CSE-ConnectionGUID: s41EVLRlSqCLbfWyOfmkjw==
X-CSE-MsgGUID: Ioro7WMMRGmGexIt/gQ+hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="76730939"
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="76730939"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 16:52:01 -0800
X-CSE-ConnectionGUID: nhmJTMybRgykHV04alN3Xw==
X-CSE-MsgGUID: 35aAR/X3ReWs6zsMfpLkBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,306,1754982000"; 
   d="scan'208";a="227249100"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2025 16:51:56 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vK4WA-0007YJ-0f;
	Sat, 15 Nov 2025 00:51:54 +0000
Date: Sat, 15 Nov 2025 08:51:44 +0800
From: kernel test robot <lkp@intel.com>
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
	akpm@linux-foundation.org, david@redhat.com, ioworker0@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
Message-ID: <202511150845.XqOxPJxe-lkp@intel.com>
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
config: arm64-randconfig-004-20251115 (https://download.01.org/0day-ci/archive/20251115/202511150845.XqOxPJxe-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251115/202511150845.XqOxPJxe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511150845.XqOxPJxe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/pt_reclaim.c:3:
   mm/pt_reclaim.c: In function 'free_pte':
>> include/asm-generic/tlb.h:731:3: error: implicit declaration of function '__pte_free_tlb'; did you mean 'pte_free_tlb'? [-Werror=implicit-function-declaration]
      __pte_free_tlb(tlb, ptep, address);  \
      ^~~~~~~~~~~~~~
   mm/pt_reclaim.c:31:2: note: in expansion of macro 'pte_free_tlb'
     pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +731 include/asm-generic/tlb.h

a00cc7d9dd93d6 Matthew Wilcox         2017-02-24  701  
a00cc7d9dd93d6 Matthew Wilcox         2017-02-24  702  #define tlb_remove_pud_tlb_entry(tlb, pudp, address)			\
a00cc7d9dd93d6 Matthew Wilcox         2017-02-24  703  	do {								\
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  704) 		tlb_flush_pud_range(tlb, address, HPAGE_PUD_SIZE);	\
a00cc7d9dd93d6 Matthew Wilcox         2017-02-24  705  		__tlb_remove_pud_tlb_entry(tlb, pudp, address);		\
a00cc7d9dd93d6 Matthew Wilcox         2017-02-24  706  	} while (0)
a00cc7d9dd93d6 Matthew Wilcox         2017-02-24  707  
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  708  /*
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  709   * For things like page tables caches (ie caching addresses "inside" the
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  710   * page tables, like x86 does), for legacy reasons, flushing an
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  711   * individual page had better flush the page table caches behind it. This
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  712   * is definitely how x86 works, for example. And if you have an
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  713   * architected non-legacy page table cache (which I'm not aware of
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  714   * anybody actually doing), you're going to have some architecturally
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  715   * explicit flushing for that, likely *separate* from a regular TLB entry
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  716   * flush, and thus you'd need more than just some range expansion..
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  717   *
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  718   * So if we ever find an architecture
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  719   * that would want something that odd, I think it is up to that
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  720   * architecture to do its own odd thing, not cause pain for others
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  721   * http://lkml.kernel.org/r/CA+55aFzBggoXtNXQeng5d_mRoDnaMBE5Y+URs+PHR67nUpMtaw@mail.gmail.com
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  722   *
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  723   * For now w.r.t page table cache, mark the range_size as PAGE_SIZE
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  724   */
b5bc66b7131087 Aneesh Kumar K.V       2016-12-12  725  
a90744bac57c3c Nicholas Piggin        2018-07-13  726  #ifndef pte_free_tlb
9e1b32caa525cb Benjamin Herrenschmidt 2009-07-22  727  #define pte_free_tlb(tlb, ptep, address)			\
^1da177e4c3f41 Linus Torvalds         2005-04-16  728  	do {							\
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  729) 		tlb_flush_pmd_range(tlb, address, PAGE_SIZE);	\
22a61c3c4f1379 Peter Zijlstra         2018-08-23  730  		tlb->freed_tables = 1;				\
9e1b32caa525cb Benjamin Herrenschmidt 2009-07-22 @731  		__pte_free_tlb(tlb, ptep, address);		\
^1da177e4c3f41 Linus Torvalds         2005-04-16  732  	} while (0)
a90744bac57c3c Nicholas Piggin        2018-07-13  733  #endif
^1da177e4c3f41 Linus Torvalds         2005-04-16  734  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

