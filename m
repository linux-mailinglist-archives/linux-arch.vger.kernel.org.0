Return-Path: <linux-arch+bounces-2071-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F28848679
	for <lists+linux-arch@lfdr.de>; Sat,  3 Feb 2024 14:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7AB285E90
	for <lists+linux-arch@lfdr.de>; Sat,  3 Feb 2024 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939C4F20C;
	Sat,  3 Feb 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9D1rO/x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8F61AACF;
	Sat,  3 Feb 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966212; cv=none; b=tVMrlTBni3xouQhUY5KZzTogp8xllXy4nMySbguU/kS4d5SsMjS5iOE15XBg1jpBtFevzMwzP0dzU148asGc3KCKTkBkpRNjUpMzWc1CbwalTTQ+a47qRhG4tvSafmMn3w1IMdyoxrLw4TxdB20xRY32zgiLD7TUOsAHgrlHgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966212; c=relaxed/simple;
	bh=4+zMKxvYaiaxOW0B3LJoq39gR4Zfnm5GTXLb8V0K1bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3utJP1OgfoUyK2PQugbahhQCMIe8Abw132pGldLqk/xhQEJAnTnJE0ct4BE2DN3cNTiIWON7oV/2YKBC9b5hkrArmX3CI1+77FWePEOqfJec/54FxvaLD5NSq9hjp4rbzNhCJZJUP4rY38neieqXinJ+vk1qts/kFlKEgXTrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9D1rO/x; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706966211; x=1738502211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4+zMKxvYaiaxOW0B3LJoq39gR4Zfnm5GTXLb8V0K1bQ=;
  b=g9D1rO/xS5dUssIG7E6/SnUQACvsY7zOhSOSO4R4VXeyN7qmsuQEJe6L
   Qrungcp8Wf7n4TB4Kp8OrRVCpiH9OQiv47dnxxU0yZtaJPfPCMBfVtr2M
   r3Sch70QD2uKgLSLHA+eD1FOBqSrEMAUFo9Q2TopF74tC6w4GjITyJlEI
   DTniGrnt7KXK8dKvJFpOEI4aiZW0cwucNSjzehTcCJRKT0/oKtPTdLk9J
   F7pzHhEUoWEWHvNXqy0t4fDWygrhfPsL+CywhRfn2yx+46KEyc4Xs0YH0
   lM+cLz7waJafKtZhkFwD1b8dCD9A3rqKv9w1bPRH8nzh8Dcl1vw/qVkc3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17728810"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="17728810"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 05:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="4932024"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Feb 2024 05:16:46 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWFsx-00055a-0l;
	Sat, 03 Feb 2024 13:16:43 +0000
Date: Sat, 3 Feb 2024 21:15:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Oleg Nesterov <oleg@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <bwh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH 3/3] mm/memory: Use exception ip to search exception
 tables
Message-ID: <202402032150.DmM8VjRz-lkp@intel.com>
References: <20240201-exception_ip-v1-3-aa26ab3ee0b5@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-exception_ip-v1-3-aa26ab3ee0b5@flygoat.com>

Hi Jiaxun,

kernel test robot noticed the following build errors:

[auto build test ERROR on 06f658aadff0e483ee4f807b0b46c9e5cba62bfa]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/ptrace-Introduce-exception_ip-arch-hook/20240201-234906
base:   06f658aadff0e483ee4f807b0b46c9e5cba62bfa
patch link:    https://lore.kernel.org/r/20240201-exception_ip-v1-3-aa26ab3ee0b5%40flygoat.com
patch subject: [PATCH 3/3] mm/memory: Use exception ip to search exception tables
config: i386-buildonly-randconfig-002-20240203 (https://download.01.org/0day-ci/archive/20240203/202402032150.DmM8VjRz-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032150.DmM8VjRz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032150.DmM8VjRz-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memory.c: In function 'get_mmap_lock_carefully':
>> mm/memory.c:5484:22: error: implicit declaration of function 'exception_ip' [-Werror=implicit-function-declaration]
      unsigned long ip = exception_ip(regs);
                         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/exception_ip +5484 mm/memory.c

  5477	
  5478	static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
  5479	{
  5480		if (likely(mmap_read_trylock(mm)))
  5481			return true;
  5482	
  5483		if (regs && !user_mode(regs)) {
> 5484			unsigned long ip = exception_ip(regs);
  5485			if (!search_exception_tables(ip))
  5486				return false;
  5487		}
  5488	
  5489		return !mmap_read_lock_killable(mm);
  5490	}
  5491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

