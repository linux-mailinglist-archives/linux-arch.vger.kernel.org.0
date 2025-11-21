Return-Path: <linux-arch+bounces-15031-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109CFC7BD35
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 23:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABED3A3033
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01F308F07;
	Fri, 21 Nov 2025 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGOKcdcl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3E2737F4;
	Fri, 21 Nov 2025 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763416; cv=none; b=aZr7qKfyAJzwInliofBkHXNZNESRPfw/SN1S+9yjQqSu8jy+P6ovNezg+WwymgRzwqfGmymNIU4ZNePGzRjoKSiQ62Oexdx1Lf2xYKnKPASq+OMqS708pXU3Dzki14kFIc50korRe+KkYBPw2cz8QrRTl/UMEuB/zkybEW7utc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763416; c=relaxed/simple;
	bh=IZWfBJDaHCe7l541lCMHfRRvdDcJ9cS7vOHixV9h5tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv0c5weW4w/D0iXKMsjbpyMqkpZaMIY7lf1cvUYOt0zYtmd1IfNe3PJtNXqig8c0Bq3FLrymImRxFNPALxCxBbDVVsmAu7P27ITk+XPcZkln5seHzaJ6SfZezPfiljb3WcbDjQfedv9uYOi2VfeMceWlAS7eibuW583Nc5qyeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGOKcdcl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763763416; x=1795299416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IZWfBJDaHCe7l541lCMHfRRvdDcJ9cS7vOHixV9h5tc=;
  b=cGOKcdcl1fINBPXtRNWJgmOgmvIKEzbEJqHFJ7j1wxJdJ5GKS4Nu8w4l
   cXosAIjUkYQKyQy+kiGPFlAxSXW4qCztbqbYHsPgHuwbn326L3RENMDks
   Q8VLWJSy/kyfqXKNqD9eCHg5LSLWOJPy0W4ezN4U/xOxo+15/Us80d+CP
   WCuxG/s25rX2VyZ894/H+2wiJqk8esaHCghfXOsEPt9viiXaztmQ3TpuI
   MxTCv4ONwnG6W+p/NKfgsB8X2nF2NWtLQi65HnYjZtb3UHDm9SqTuOkv0
   XDf7UmhawXIZn0971iVglxGeqzyAwBGaN8UWjwAscVuOezF/X/xJCxYot
   w==;
X-CSE-ConnectionGUID: s3ouSAZnSwq56Od/KUKvyg==
X-CSE-MsgGUID: UeiYcK7cS3azNkFU46pZZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="88515029"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="88515029"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 14:16:55 -0800
X-CSE-ConnectionGUID: TOehty9pSyCfviE3bYiNSw==
X-CSE-MsgGUID: BIxr2Fa8QbCS5hbxVrvkJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="192265938"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2025 14:16:49 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMZQs-0006vH-32;
	Fri, 21 Nov 2025 22:16:46 +0000
Date: Sat, 22 Nov 2025 06:16:25 +0800
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
Subject: Re: [PATCH 12/26] kernel/configs: Register dynamic information into
 meminspect
Message-ID: <202511220511.nMJSuw8H-lkp@intel.com>
References: <20251119154427.1033475-13-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-13-eugen.hristev@linaro.org>

Hi Eugen,

kernel test robot noticed the following build errors:

[auto build test ERROR on rppt-memblock/fixes]
[also build test ERROR on linus/master v6.18-rc6]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugen-Hristev/kernel-Introduce-meminspect/20251119-235912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git fixes
patch link:    https://lore.kernel.org/r/20251119154427.1033475-13-eugen.hristev%40linaro.org
patch subject: [PATCH 12/26] kernel/configs: Register dynamic information into meminspect
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251122/202511220511.nMJSuw8H-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220511.nMJSuw8H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220511.nMJSuw8H-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/configs.c:18:
   kernel/configs.c: In function 'ikconfig_init':
>> include/linux/meminspect.h:144:39: error: implicit declaration of function 'virt_to_phys'; did you mean 'virt_to_page'? [-Wimplicit-function-declaration]
     144 |         meminspect_register_id_pa(id, virt_to_phys(va), size, MEMINSPECT_TYPE_REGULAR)
         |                                       ^~~~~~~~~~~~
   include/linux/meminspect.h:170:17: note: in expansion of macro 'meminspect_register_id_va'
     170 |                 meminspect_register_id_va(__VA_ARGS__); \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/configs.c:69:9: note: in expansion of macro 'meminspect_lock_register_id_va'
      69 |         meminspect_lock_register_id_va(MEMINSPECT_ID_CONFIG,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +144 include/linux/meminspect.h

184ddf27f54a0b Eugen Hristev 2025-11-19  139  
184ddf27f54a0b Eugen Hristev 2025-11-19  140  #define meminspect_register_pa(...) \
184ddf27f54a0b Eugen Hristev 2025-11-19  141  	meminspect_register_id_pa(MEMINSPECT_ID_DYNAMIC, __VA_ARGS__, MEMINSPECT_TYPE_REGULAR)
184ddf27f54a0b Eugen Hristev 2025-11-19  142  
184ddf27f54a0b Eugen Hristev 2025-11-19  143  #define meminspect_register_id_va(id, va, size) \
184ddf27f54a0b Eugen Hristev 2025-11-19 @144  	meminspect_register_id_pa(id, virt_to_phys(va), size, MEMINSPECT_TYPE_REGULAR)
184ddf27f54a0b Eugen Hristev 2025-11-19  145  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

