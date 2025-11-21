Return-Path: <linux-arch+bounces-15015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B51C7B05B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 18:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E473A3093
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96983254B7;
	Fri, 21 Nov 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3G04Trl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADE2EAB83;
	Fri, 21 Nov 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745259; cv=none; b=pot+s0LOnq6U4HhQZz86UPMvgJCMZLwVB5hdUILN0GmPq8jBwdKOvo6SAmLNzPWbwolLa9/JeDOTaH9vzWlfh2qTU9JzwXLXOgRgjXPIWiKiedlEjQEEvOtUMENmm8pdagk2V/5Hse0sxEi74EEAL57+TUU3EC39VhGZNeRnXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745259; c=relaxed/simple;
	bh=150knvdVimP1Sxf+IHS3A/Uh2qRTdjSQ1ygg39BCet0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efk6DbJywK++FS5Sfmw9S8zMogA/19JVMTEk6amjwIK8oq0ieH/sWPZSHyekpF7Ep3BI79JIRF9AboMhDRkvr4Snfbp+ynWh+yvDWnefJ5kaatqrS8c3SJjo3+aDvmgWN+XJ45QrCTUlmx48TszCWHD14ihVHwiHml2ZBpBC5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3G04Trl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763745258; x=1795281258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=150knvdVimP1Sxf+IHS3A/Uh2qRTdjSQ1ygg39BCet0=;
  b=S3G04TrlaEpnEZOpOkHK8L/gtNnmuMLcqKOVFjQ4GVye3IDXASk2uouz
   h13BZ4LpZCVaBwnsLcjtqB9vp4EoNzgky+fzC8JnmLwtytzgylQkd769X
   dAaZf9pSzY+BUcQEz+/aXACMEmLIFLSY427r8Np3jalOGps+TjxfaSFMP
   dsEabCT8eywSDc/2F98iCaScWjosq1ASTCL/AzaQlIkDptIvCpD+hkoYW
   YZf/aX8KKjqrB1WZjvBKlQBlUePgUP3BRCw4uQynhE/FB+sa6PIF/m+s6
   WvCEl33doQ6+wtJ3nkq3TV7DWNUXOnpBvF1FXGKjeU10t5x+OGpiT4wl4
   A==;
X-CSE-ConnectionGUID: tizTzCVEQtODj1hrt8EDTA==
X-CSE-MsgGUID: RVEsv1C6QGm8rTigEuvCOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65792210"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="65792210"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 09:14:18 -0800
X-CSE-ConnectionGUID: qu6B9a0bRZ21y0YvoYxbGg==
X-CSE-MsgGUID: Ssd/qetKQuewq4dpfK3Qcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="196687127"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Nov 2025 09:14:12 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMUi1-0006dT-2W;
	Fri, 21 Nov 2025 17:14:09 +0000
Date: Sat, 22 Nov 2025 01:13:52 +0800
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
Subject: Re: [PATCH 03/26] mm/percpu: Annotate static information into
 meminspect
Message-ID: <202511220009.u6dJXVkB-lkp@intel.com>
References: <20251119154427.1033475-4-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119154427.1033475-4-eugen.hristev@linaro.org>

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
patch link:    https://lore.kernel.org/r/20251119154427.1033475-4-eugen.hristev%40linaro.org
patch subject: [PATCH 03/26] mm/percpu: Annotate static information into meminspect
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20251122/202511220009.u6dJXVkB-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220009.u6dJXVkB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220009.u6dJXVkB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/percpu.c:90:
>> mm/percpu.c:3350:25: error: '__per_cpu_offset' undeclared here (not in a function); did you mean '__per_cpu_start'?
    3350 | MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
         |                         ^~~~~~~~~~~~~~~~
   include/linux/meminspect.h:92:64: note: in definition of macro 'MEMINSPECT_ENTRY'
      92 |                                                .va = (void *)&(sym),            \
         |                                                                ^~~
   mm/percpu.c:3350:1: note: in expansion of macro 'MEMINSPECT_SIMPLE_ENTRY'
    3350 | MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
         | ^~~~~~~~~~~~~~~~~~~~~~~


vim +3350 mm/percpu.c

  3349	
> 3350	MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
  3351	/*
  3352	 * pcpu_nr_pages - calculate total number of populated backing pages
  3353	 *
  3354	 * This reflects the number of pages populated to back chunks.  Metadata is
  3355	 * excluded in the number exposed in meminfo as the number of backing pages
  3356	 * scales with the number of cpus and can quickly outweigh the memory used for
  3357	 * metadata.  It also keeps this calculation nice and simple.
  3358	 *
  3359	 * RETURNS:
  3360	 * Total number of populated backing pages in use by the allocator.
  3361	 */
  3362	unsigned long pcpu_nr_pages(void)
  3363	{
  3364		return data_race(READ_ONCE(pcpu_nr_populated)) * pcpu_nr_units;
  3365	}
  3366	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

