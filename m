Return-Path: <linux-arch+bounces-15444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8132ECBFEBB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1E0930413CE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FAB32D7D3;
	Mon, 15 Dec 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3TgXR4t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78725F99B;
	Mon, 15 Dec 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833904; cv=none; b=EXGEA0u3YShCDjUg0kZ4P2LBchtOnJ2HGlBL3+TzGPCXTICQcXT5MaB9UE456TED03bLdo3EY7JpD41amHmlDQ3MP9yjxcNby5+IKEeHHOVAFy/z2UGbrXr9n0UWDhZEAzy5PZyeLHMXGAnI6LfhAZkdF8K6tTlJHJU1Tg0VRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833904; c=relaxed/simple;
	bh=QnAPE6e7tVNh1L4SSaHUKeQax1Y3ZxVhkUf81AdJuSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8a2U8G4wf+0N2MEhYNSZNnSp2i5IlBkeIB1Ehr9YKKMUWdU13EKFwfVlJjVWCyj8uf4Afju6zOR+XCNpqeDpVw2/w3gkPU2n6DgUEGdFr/uWosMG4ULmyAO39WGA0Xk6sTb9tS5UohNGIkh6jMyiDEA3VRQTcGlPSyY15dI4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3TgXR4t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765833903; x=1797369903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QnAPE6e7tVNh1L4SSaHUKeQax1Y3ZxVhkUf81AdJuSk=;
  b=l3TgXR4tnQ9yWqyoZbWRFvlzzIFPxkGIt1rTUYyILQtXJCYUX5xGJiUz
   mZkCVtiPGGHyMmfO4XsPhIF0fNP5LcTs5xPvqbqF6qemuhyWynZyRaZBV
   SreLmj93bB3RnNntwLpH6/5udQL2SQLHOk75g7ghIS9n0vmHiYbqapsiC
   HhNMDCG6sOaX/Hs3tZ9nCEIlNwTN7a+hk3/EEok4l+Wvwqa9Uqrc31wp9
   hllT1AByp1aI13WseTDenVAEoUIFBQfSXG04QatEldQrfbdYo0vGc4TAH
   FAYGCz3nGMPV4oZVNfdnlyPeDSw08fMtJjUvSVsWuNLfEV/3CAPZQWt2Q
   g==;
X-CSE-ConnectionGUID: qMGyG0wQRoyOihyLqmOAGQ==
X-CSE-MsgGUID: oiCmhAk9QfOVaHO+AQ7eaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78865942"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="78865942"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 13:25:03 -0800
X-CSE-ConnectionGUID: MW024P1lTh2ip6Qrzm/vzw==
X-CSE-MsgGUID: 7U1AeipUR4OQQDD+ercKjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="228486639"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Dec 2025 13:24:57 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVG3U-000000000oT-3Boe;
	Mon, 15 Dec 2025 21:24:39 +0000
Date: Tue, 16 Dec 2025 05:23:42 +0800
From: kernel test robot <lkp@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, arnd@arndb.de, catalin.marinas@arm.com,
	will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH v8 12/12] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Message-ID: <202512160519.pKMkOXsP-lkp@intel.com>
References: <20251215044919.460086-13-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215044919.460086-13-ankur.a.arora@oracle.com>

Hi Ankur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on bpf/master linus/master v6.19-rc1 next-20251215]
[cannot apply to arm64/for-next/core bpf-next/net arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/asm-generic-barrier-Add-smp_cond_load_relaxed_timeout/20251215-130116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251215044919.460086-13-ankur.a.arora%40oracle.com
patch subject: [PATCH v8 12/12] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
config: x86_64-randconfig-005-20251215 (https://download.01.org/0day-ci/archive/20251216/202512160519.pKMkOXsP-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251216/202512160519.pKMkOXsP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512160519.pKMkOXsP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: poll_idle+0x3b: call to tif_need_resched_relaxed_wait() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

