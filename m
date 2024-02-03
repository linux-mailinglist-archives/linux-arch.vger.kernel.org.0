Return-Path: <linux-arch+bounces-2072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7915848688
	for <lists+linux-arch@lfdr.de>; Sat,  3 Feb 2024 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9308A1F23692
	for <lists+linux-arch@lfdr.de>; Sat,  3 Feb 2024 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016955E70;
	Sat,  3 Feb 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gl3tI9Q8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86355D8FB;
	Sat,  3 Feb 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706967534; cv=none; b=ZXHvD+G9Lnczw7wHW2YfIGsBTxLUvRAnSuSzg+VcfiHjQrpsAV98SgTQGFWo32K35oeO39l/eQdTqTZhaFjkzEuKN2oBSvISRcPFYjGYSDl18wt2iszXALXNvqbnSYjGA96EBh4r7QVLPMdmS7804IRrY/xU1+ossHo1eccYg8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706967534; c=relaxed/simple;
	bh=YjOtAVRDfuPH8lpCCJ1yeiZiENIgmPX6pSBD0VtNlWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8IarNrjaPO+UQqTfsiSEwfLYCO9qh7rTIuEBxVUJhmB5VBx1A8xk92oZPrcsPe8hw/ugBZ+CfvYYymKlzr1WNhsy3eppJ3lyq34uOcccyUI2NDelUmVwz5YDQY+A8iVsePcd+htmzpZep+pGqadSl0lg8MQSgz+1y8kYO67ScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gl3tI9Q8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706967532; x=1738503532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YjOtAVRDfuPH8lpCCJ1yeiZiENIgmPX6pSBD0VtNlWo=;
  b=gl3tI9Q8/q6BNdD2RUrYc6W6Pdo8fAlskcLwIPUxzOwrn4N/647c0W2K
   R3yerKctoM5pZ6ANtJcFHvrg9dqjeSjC325CU7dB5gqIzwQWjT7n31vgg
   uj19tm7F1nVCHf8SqHs5Gss7EOQocoZfDPlzvb2fWACiXDL0HEHR7HUoQ
   kSEbjJACdQeL/BY5FWtMrA0Qv7cKjcU06Yp3X4xi3dNOKGmGY2vS9CjtU
   /Ye8YWvmwtOW/+9EfNk+uzlLhHqgwx0M02Fja+KNDM0DN3Wg3A3in3i+k
   J6Mn3cPyBRAqpPFGNClkERTSQeR+rAeFT6hC25zMCZTAZAUshadD0nDhx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10967211"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="10967211"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 05:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="645392"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Feb 2024 05:38:48 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWGEG-00057C-2l;
	Sat, 03 Feb 2024 13:38:44 +0000
Date: Sat, 3 Feb 2024 21:37:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Oleg Nesterov <oleg@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <bwh@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH 3/3] mm/memory: Use exception ip to search exception
 tables
Message-ID: <202402032112.NBimLx5h-lkp@intel.com>
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
config: arm64-randconfig-001-20240203 (https://download.01.org/0day-ci/archive/20240203/202402032112.NBimLx5h-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032112.NBimLx5h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032112.NBimLx5h-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memory.c:5484:22: error: call to undeclared function 'exception_ip'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   unsigned long ip = exception_ip(regs);
                                      ^
   mm/memory.c:5509:22: error: call to undeclared function 'exception_ip'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   unsigned long ip = exception_ip(regs);
                                      ^
   2 errors generated.


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

