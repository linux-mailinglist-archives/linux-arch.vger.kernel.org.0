Return-Path: <linux-arch+bounces-14157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14480BE19F9
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 08:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D56864EE875
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 06:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0012D253F13;
	Thu, 16 Oct 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQFz2o3K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A2246769;
	Thu, 16 Oct 2025 06:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594619; cv=none; b=YS/iuD4PvFAa0vHQfYWG3+BbodSddaalYZGs6dwhO+F+1Cjq+r09npRnZfjUWKDyVGQ+ePv0WUPfd7FtAVyBAhq6gI5AOLOdyh1+GnDd28K47+fFsullbl03HHxe8ZuuZVpSB6hzorz9Td0nQDeA3/hpfAkS1Y9D46tqLNyIXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594619; c=relaxed/simple;
	bh=DYGH30jDUAm4j6nu3ucbB5T9mziY602oEn8yT04F0JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbMa4InWY9o55iZwiiUw6P0JvE81X4nIGoXGJRLq3DbHru34Yh3W90RDE+OFRwwysbMKedL24PTFR4cVSeCUJQwhix4fCyS/lBtbb6Rmx6dPZbp5hVEgqQOsfg0J7FgCEUIRRPN7HuZUZYzhGrSadCHuIwt10Bc72+7iyXdFS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQFz2o3K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760594618; x=1792130618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DYGH30jDUAm4j6nu3ucbB5T9mziY602oEn8yT04F0JA=;
  b=ZQFz2o3KYMyLJeRQurDbyy7NcAwbYzHSQwVTRITqLTYimSANUzk+TctU
   RSYnXlqzQifjVTMRA4iUp/ti/9RPzVcKNxf2l0mmmyBSyFeQbR5Eq+Ror
   4RRPCX6pTJ9BW6azMTgRR4x8zh71euJKn57xZYedDNOICQtIw4qZhHhFj
   OD7nMjXbrebICs0R/ZxC7C46SqE+afZzujKd87qlygA5aVulkGCOINpTQ
   r8ynytWz+SdC+8ikrI+iI6SXKVBYr24LHVrO+ijVQ6z+nubpjYFQCk5vc
   pNvYFST+sM972wTdvD5og76BzB0mg7cnfmbzaquqOdeHbP+9/la3PtKnc
   A==;
X-CSE-ConnectionGUID: jErH90DvTvS2RaTTlkUvFA==
X-CSE-MsgGUID: WVJkAc8KSSCPzPnXtino0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80218689"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="80218689"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:03:37 -0700
X-CSE-ConnectionGUID: 4GHeEhqXSz+sg/B4aDp9JA==
X-CSE-MsgGUID: Ej4lsW2CQdOabrhXE7/3gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="182040085"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 15 Oct 2025 23:03:34 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9H5I-0004Vz-0c;
	Thu, 16 Oct 2025 06:03:32 +0000
Date: Thu, 16 Oct 2025 14:03:13 +0800
From: kernel test robot <lkp@intel.com>
To: Yuan Tan <tanyuan@tinylab.org>, arnd@arndb.de, masahiroy@kernel.org,
	nathan@kernel.org, palmer@dabbelt.com, linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, i@maskray.me, tanyuan@tinylab.org,
	falcon@tinylab.org, ronbogo@outlook.com, z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: Re: [PATCH v2 6/8] compiler.h: introduce PUSHSECTION macro to
 establish proper references
Message-ID: <202510161337.2Vym0Pmn-lkp@intel.com>
References: <40854460DE090346+c30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40854460DE090346+c30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan@tinylab.org>

Hi Yuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on arnd-asm-generic/master linus/master v6.18-rc1 next-20251015]
[cannot apply to masahiroy-kbuild/for-next masahiroy-kbuild/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuan-Tan/scripts-syscalltbl-sh-add-optional-used-syscalls-argument-for-syscall-trimming/20251015-181934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/40854460DE090346%2Bc30007da67d26ae0e8651732f32a8ede4926db14.1760463245.git.tanyuan%40tinylab.org
patch subject: [PATCH v2 6/8] compiler.h: introduce PUSHSECTION macro to establish proper references
config: sh-randconfig-002-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161337.2Vym0Pmn-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161337.2Vym0Pmn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161337.2Vym0Pmn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sh4-linux-ld:./arch/sh/kernel/vmlinux.lds:2: syntax error

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

