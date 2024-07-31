Return-Path: <linux-arch+bounces-5788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3594358A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 20:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950BE1C218DB
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8648288F;
	Wed, 31 Jul 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHrDunwf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4F145BE3;
	Wed, 31 Jul 2024 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450003; cv=none; b=ds3vq+Ouu2aCLzM8A+zZKppml+XOW9Hobq6MRtj9uGTpxS8CUF41ZjB3rZmrYZ3DYzv/H8mZTQ8Hnt43WG0+CF1wmkLc0Y4cJywtejdBzArGrYhNUhLp6uXY+GNfY/BSI+TtGNPpEkVeFSQoEzrrM8up5jCxZvmVyV+2pIi28KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450003; c=relaxed/simple;
	bh=mhUJZkJDoBn6UrBK6j9k/Zhefn6WhHvCy2ysDMhWtOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjpuWtC1uDS9oJ8OPfJJuumiQiCxfsLpexmJ54cTjhmxmUtRgFK175UXFz6sUgozW4+nQMC9cg3aRKxsXdRyirrIDHLVJTjOoOtoyzUspNFlktjcmXhiqBt4avOGhIClZzH6WN4gMMBfAtHP75YC2sIrMgBM3EuFiVvJsHWylEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHrDunwf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722450001; x=1753986001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mhUJZkJDoBn6UrBK6j9k/Zhefn6WhHvCy2ysDMhWtOg=;
  b=QHrDunwfmTljnjUMhJp4vd5IXXUNGVW/dgSH/T/RyNzOlzNJbKuDoxpt
   wZyHV+t86/OpZ2CoTrVC5r794mqkDPGyh42bsdd1BFl/ph2X1w33RfMb0
   mr8AREaPMDqxH+7ES+IuOn29VRBkgv3131Og+oR2bioLqlQdcfRJM/jod
   FF1L+JOcnRCjuugoQf1VxZ68UUqkPIgmoHQ9WLM3FSyKlTH7grazvfHIm
   nbg4gYyzn5/U+xp8fHUtG69qRccZdnfKyF/swvf3ydSFTgkQzS0PVVFiE
   OQASByNZMbLsmG8N3L9oj1NQJjiOMcstWbNCMsPcn6bTi3DC59uXjb7OY
   Q==;
X-CSE-ConnectionGUID: Un/HTtHSSXaxC+gn2TF7Hg==
X-CSE-MsgGUID: xAQGIqJNSXCILtYcEE9g7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="23268184"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="23268184"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 11:20:00 -0700
X-CSE-ConnectionGUID: g2GxWhHnQRqpX6Q0Gsc6Bw==
X-CSE-MsgGUID: RwGiN8jVSjmeOtf88aroXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55368613"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 11:19:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZDvV-000uhg-0v;
	Wed, 31 Jul 2024 18:19:53 +0000
Date: Thu, 1 Aug 2024 02:19:19 +0800
From: kernel test robot <lkp@intel.com>
To: Zhiguo Jiang <justinjiang@vivo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@kernel.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org,
	cgroups@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
Message-ID: <202408010150.13yZScv6-lkp@intel.com>
References: <20240730114426.511-3-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730114426.511-3-justinjiang@vivo.com>

Hi Zhiguo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhiguo-Jiang/mm-move-task_is_dying-to-h-headfile/20240730-215136
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240730114426.511-3-justinjiang%40vivo.com
patch subject: [PATCH 2/2] mm: tlb: add tlb swap entries batch async release
config: i386-randconfig-061-20240731 (https://download.01.org/0day-ci/archive/20240801/202408010150.13yZScv6-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240801/202408010150.13yZScv6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408010150.13yZScv6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/mmu_gather.c:54:10: sparse: sparse: symbol 'nr_exiting_processes' was not declared. Should it be static?
   mm/mmu_gather.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false

vim +/nr_exiting_processes +54 mm/mmu_gather.c

    53	
  > 54	atomic_t nr_exiting_processes = ATOMIC_INIT(0);
    55	static struct kmem_cache *swap_gather_cachep;
    56	static struct workqueue_struct *swapfree_wq;
    57	static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
    58	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

