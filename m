Return-Path: <linux-arch+bounces-13562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8AB55E81
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 06:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A317AD2E1
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 04:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0B2E091C;
	Sat, 13 Sep 2025 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bStJjuLz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC32E0417;
	Sat, 13 Sep 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757739272; cv=none; b=ozRnHusAjWQG0S5GrFjAiIoN5crfQQpsLuhTwl1oEAqCBnew2yR0qoz4qrRdq69uE6hYqyaK4eEeZ7pmfAgLdDkzWGYkc8rUgylQodoYS4NOebmAqlWMDwlK2uD0MIfJUK4qixqO1M6ToAyJzvKMdUNQu9nVipoY1/2iLzKTOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757739272; c=relaxed/simple;
	bh=MBM/iaQTTN7Ecb2rHlHyrJfWh+aPzAuwB5BM8/YDByk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP+8gVt0mEpjEwUL0+ovwLqE6oU6VEknPijM4V8NWUCQbEXz00hTn0YgsLJq0ffzR8/Ntnzzkg7YDdBSbNE1k3k4sbzTjVVaVWw/G99hC6IqB+b5KBsFP6DCWMaS/iGJ5+SEVtXpE0KwEYd6/XCn6YLz6c1ynXnd2VR/dQuv+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bStJjuLz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757739271; x=1789275271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MBM/iaQTTN7Ecb2rHlHyrJfWh+aPzAuwB5BM8/YDByk=;
  b=bStJjuLzmYqZSclF6Y0ydXGmKpU1aGbcLdJwFwHnov+n2PuZDvVYAY2s
   ZZqWpCo0HfGSHukcYjO83VdslBUxthaREwGW1HTyNuEsx5Ssy3ItjmStz
   ips5mhZba3jTz77186S4SlfoZPColCIQ5eUjFEfR/ZsRA6l6yoGWXko99
   Q+g+41O+6A2w6hOudmkd3BxmzhFgn+U2RVLd9akZ4klujbiY7Ks7Jyc4R
   P4vpnelXFoDFhGTciPSe2DwIJQU9JReO0oIPtgvoUTMVyt3bdMH9e9Qwx
   y6tVDMrbSBFdRkoblMZGBTyMo2GA5gTNyIbem5LK/f3xBP7+SC/pN3WSQ
   g==;
X-CSE-ConnectionGUID: Objt6M4rQ76qr6gQGr/xig==
X-CSE-MsgGUID: tmFTllNBRwCetXoPTq2jkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="47650688"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="47650688"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 21:54:30 -0700
X-CSE-ConnectionGUID: 9XXEBugOQkGIfN3BuSqC4A==
X-CSE-MsgGUID: 6XYEu5PASW24cEmBbWJRpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="174598591"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2025 21:54:27 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxIHJ-0001Mm-01;
	Sat, 13 Sep 2025 04:54:25 +0000
Date: Sat, 13 Sep 2025 12:53:28 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump
 collection files
Message-ID: <202509131228.naboUNkE-lkp@intel.com>
References: <20250910001009.2651481-7-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910001009.2651481-7-mrathor@linux.microsoft.com>

Hi Mukesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250909]
[also build test WARNING on v6.17-rc5]
[cannot apply to tip/x86/core tip/master linus/master arnd-asm-generic/master tip/auto-latest v6.17-rc5 v6.17-rc4 v6.17-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Rathor/x86-hyperv-Rename-guest-crash-shutdown-function/20250910-081309
base:   next-20250909
patch link:    https://lore.kernel.org/r/20250910001009.2651481-7-mrathor%40linux.microsoft.com
patch subject: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump collection files
config: x86_64-randconfig-073-20250913 (https://download.01.org/0day-ci/archive/20250913/202509131228.naboUNkE-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250913/202509131228.naboUNkE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509131228.naboUNkE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/mshyperv.h:272,
                    from arch/x86/hyperv/hv_apic.c:29:
>> include/asm-generic/mshyperv.h:370:5: warning: "CONFIG_CRASH_DUMP" is not defined, evaluates to 0 [-Wundef]
     370 | #if CONFIG_CRASH_DUMP
         |     ^~~~~~~~~~~~~~~~~


vim +/CONFIG_CRASH_DUMP +370 include/asm-generic/mshyperv.h

   369	
 > 370	#if CONFIG_CRASH_DUMP
   371	void hv_root_crash_init(void);
   372	void hv_crash_asm32(void);
   373	void hv_crash_asm64_lbl(void);
   374	void hv_crash_asm_end(void);
   375	#else   /* CONFIG_CRASH_DUMP */
   376	static inline void hv_root_crash_init(void) {}
   377	#endif  /* CONFIG_CRASH_DUMP */
   378	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

