Return-Path: <linux-arch+bounces-15033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D6C7BFD6
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 01:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFF034E11B0
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 00:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B97081A;
	Sat, 22 Nov 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lo+1hFAx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC42AEE1;
	Sat, 22 Nov 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763769907; cv=none; b=qnUjtexUX92S5QI+dPfAOVTOrRQtObOnSizTp0K/Y6HrC5T5k5WWlvhLxLY8dbw7dHFt6T0IwFRzpN74/gtYJnz2raclaZFr5Vgh0z3rQhDvOPjGkaJrYy4wtpjBFFwjoodH1NJsFUDcuCevpVduTDbm5ytiVv8V5WtJtciQA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763769907; c=relaxed/simple;
	bh=lKk63OBIxTgAZL2BQA9bHbccK1TAmQ6Nota8WFvpBkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnVjWz4bd1MD8ryOsqEO6tEbAny7EwmnlAH+Sr/o7amq2456er66QO/D3agsFmhtU1VS6CDAzuGxSeScx5TKcn7lmM6SIUWSHzyokjYbPdwDfOUNR8R4fyt3fPjB+kqUix6n+DFm5ow2TzmhTZvt6sdrD4eyIaS6phK6UaY9/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lo+1hFAx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763769906; x=1795305906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lKk63OBIxTgAZL2BQA9bHbccK1TAmQ6Nota8WFvpBkg=;
  b=lo+1hFAxH06+sytQZxKbwsDz0D4+BSsgFqQn+9GNccChG+4jv4Mn5OHt
   fK/gvRxyVI13LnIYqns1QtNh87sxMgAj3pfoQHY6JMRP8QQVEuiy7hb0P
   05ZCLzPmyYifqbRErYklia0iA4h5QCek86ussYMTzmrKDwBQ4kgBNiyBF
   +ZbUF+0Ldp70eI9mPN57stORcg1exZ+xWSjZnxHPRI9tXkVy3exhF5yJV
   Mp72Yv03CgCCjJWcug/Yi+SJylt1vYGLEoqb7U5tm6T5JIXpDrIGGC2kW
   TRp+QsrlFIk6I3ZS2EzUf1TbAjec22yRtgbtnefe8BNUsnjmWhfFWEUeD
   A==;
X-CSE-ConnectionGUID: eXdvH3xBROqRksv7Ny2OQA==
X-CSE-MsgGUID: IUk3NfPXSqGA+N/kFaThdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="76980187"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="76980187"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 16:05:04 -0800
X-CSE-ConnectionGUID: 0m1MqlNQSeC7xJO5WxDOzw==
X-CSE-MsgGUID: PhKw3WinTWa2mGSgArHQNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; 
   d="scan'208";a="196760418"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Nov 2025 16:04:59 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMb7Y-0006zb-2u;
	Sat, 22 Nov 2025 00:04:56 +0000
Date: Sat, 22 Nov 2025 08:04:02 +0800
From: kernel test robot <lkp@intel.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	tglx@linutronix.de, andersson@kernel.org, pmladek@suse.com,
	rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
	mhocko@suse.com
Cc: oe-kbuild-all@lists.linux.dev, tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH 01/26] kernel: Introduce meminspect
Message-ID: <202511220712.LEcYEMJx-lkp@intel.com>
References: <20251119154427.1033475-2-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-2-eugen.hristev@linaro.org>

Hi Eugen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rppt-memblock/fixes]
[also build test WARNING on linus/master v6.18-rc6]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugen-Hristev/kernel-Introduce-meminspect/20251119-235912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git fixes
patch link:    https://lore.kernel.org/r/20251119154427.1033475-2-eugen.hristev%40linaro.org
patch subject: [PATCH 01/26] kernel: Introduce meminspect
config: nios2-randconfig-r131-20251122 (https://download.01.org/0day-ci/archive/20251122/202511220712.LEcYEMJx-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220712.LEcYEMJx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220712.LEcYEMJx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/meminspect/meminspect.c:15:1: sparse: sparse: symbol 'meminspect_notifier_list' was not declared. Should it be static?

vim +/meminspect_notifier_list +15 kernel/meminspect/meminspect.c

    14	
  > 15	ATOMIC_NOTIFIER_HEAD(meminspect_notifier_list);
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

