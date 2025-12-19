Return-Path: <linux-arch+bounces-15510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8DCCE795
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 05:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E743013946
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 04:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979428DEE9;
	Fri, 19 Dec 2025 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0QLdmYH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997D20B212;
	Fri, 19 Dec 2025 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766120037; cv=none; b=i1rGBkN0Vo1nkPG9nvtGaI5gVYiz00UkI2aC9Uj7XGkNnSRN6GPUYX4X5VelrPWCqN2oc64n89j423B876hFNDqJdDwsTcb3OtfUszuoDisHDVRnUqftlhOn8EjWlcyTb412P73VtUGZtJ1+CnVJgYOOsR3D0T61PBro4os/SOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766120037; c=relaxed/simple;
	bh=hE9E3Ug+7uhFPPxWAz/WZoEyJgKJTbWKXQ+/RMI7KXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQP7JVM4yoqWv3hSC4xHUdx2vI3IuzaNreu/uVTcSoS+REjoHLifh+vVVIQnS14klHKIL721HYq2rwiASHX6hTmSLUvEvak5CWGLzgdA72VzofIqRRHzVIlDdMizmhQiq91xK0xNSnF9IxWb0G0ieviFagq4S29OTEtLiHxUDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0QLdmYH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766120036; x=1797656036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hE9E3Ug+7uhFPPxWAz/WZoEyJgKJTbWKXQ+/RMI7KXU=;
  b=H0QLdmYHdun3QaFWsCcYcV3NBu7gMJEtpuN/y9nCzRV37kG9EFBHL3mk
   kog2ZSxasRlB3GnGEvvptlGs0o9qFGLAVHi8VQZaUGXJopb+JqIVjehTA
   PWLXZKEagQlsCTQGKpLG14X+iNJyMoKCH/qcd2KZUB1W0dhfdjORopJlF
   p14fASrdT3E5OHBHy3SFC81Em/doiUub68jOqVWq6TB/6gBwXc4VQ4BQh
   RPDOn546JCO2WnyAich8Ngvqn1vJJvnkFqafuHekudaKTeyi8Zf7TyIe3
   E8ecx+QHXMy1OSHsW5eYtkcaO1nNCYO5uZvUD2KYDsvcQO2hsHsHIKm5A
   w==;
X-CSE-ConnectionGUID: BygyA9ULSfiqxoWiZKKTQg==
X-CSE-MsgGUID: TdVBAv69S7iigeJ4mXBPeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="68157667"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="68157667"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 20:53:55 -0800
X-CSE-ConnectionGUID: 8Bsyd2beRLaaC8ATL7Mnmg==
X-CSE-MsgGUID: zYXGz6aXQsKbYaNPzWnQsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="198680831"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 18 Dec 2025 20:53:49 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWSUs-0000000031h-3wlH;
	Fri, 19 Dec 2025 04:53:46 +0000
Date: Fri, 19 Dec 2025 12:52:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH v8 03/12] arm64/delay: move some constants out to a
 separate header
Message-ID: <202512191227.TXFkHrQf-lkp@intel.com>
References: <20251215044919.460086-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215044919.460086-4-ankur.a.arora@oracle.com>

Hi Ankur,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master linus/master arnd-asm-generic/master v6.19-rc1 next-20251218]
[cannot apply to arm64/for-next/core bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/asm-generic-barrier-Add-smp_cond_load_relaxed_timeout/20251215-130116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251215044919.460086-4-ankur.a.arora%40oracle.com
patch subject: [PATCH v8 03/12] arm64/delay: move some constants out to a separate header
config: x86_64-buildonly-randconfig-004-20251215 (https://download.01.org/0day-ci/archive/20251219/202512191227.TXFkHrQf-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251219/202512191227.TXFkHrQf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512191227.TXFkHrQf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/qcom/rpmh-rsc.c:29:10: fatal error: 'asm/delay-const.h' file not found
      29 | #include <asm/delay-const.h>
         |          ^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +29 drivers/soc/qcom/rpmh-rsc.c

     8	
     9	#include <linux/atomic.h>
    10	#include <linux/cpu_pm.h>
    11	#include <linux/delay.h>
    12	#include <linux/interrupt.h>
    13	#include <linux/io.h>
    14	#include <linux/iopoll.h>
    15	#include <linux/kernel.h>
    16	#include <linux/ktime.h>
    17	#include <linux/list.h>
    18	#include <linux/module.h>
    19	#include <linux/notifier.h>
    20	#include <linux/of.h>
    21	#include <linux/of_irq.h>
    22	#include <linux/of_platform.h>
    23	#include <linux/platform_device.h>
    24	#include <linux/pm_domain.h>
    25	#include <linux/pm_runtime.h>
    26	#include <linux/slab.h>
    27	#include <linux/spinlock.h>
    28	#include <linux/wait.h>
  > 29	#include <asm/delay-const.h>
    30	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

