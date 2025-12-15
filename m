Return-Path: <linux-arch+bounces-15431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED8CBF578
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20662301FC27
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C7325496;
	Mon, 15 Dec 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0HKm0tB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DB31ED72;
	Mon, 15 Dec 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821654; cv=none; b=rl4aMh8ahCFgt7SnCV/mPko71E+LGIKNfi7n76UKo8yPdaEaCpgAQm8u6y9M6VsAGeNxQok4IXYBZNNchj+3XFYGxvtiXvnhCLMZ5AMcEiBeCwsOxNk5RkyYILDn+0lssmdhpFKx6dBmLGqxeCHC7Z+aM0X7RULLcah9E/mCOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821654; c=relaxed/simple;
	bh=xxgOgB20hanHcYFd7t7oP4Q0JQiogpWh4jHFCannRyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA+9dwKSHaBFyYGFsrm9YcQyflkwoqHK3pTzVECycKP/ZlnxFQz6RmwwDqk7q0CTxzSm3RHkFNbu78rNDli7x8/dc5QT1AHAKQFJ3QzXkW8uw0fk/FTKCLRzd+5izw+4jJ/MyzElIF8zazumUi0KQS3munD8weM/+qIecvX/Trg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0HKm0tB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765821653; x=1797357653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xxgOgB20hanHcYFd7t7oP4Q0JQiogpWh4jHFCannRyA=;
  b=U0HKm0tB6KgwH9/uMrCElXbI2REwlcOhWRR/VIPYuLTgCq5GMU8V6rFg
   i9QkLLExUtpU3de5qjcCETVA+Jd0AluNxcQABFEYFUYCa8FNo9i5jCdQ/
   eo2opB3wbDakKvhfIeGg12G9hL3FryL1aDT6zAwBkx7A0vtI/ca83gYfA
   7miuU+aLKIMZxRxqz/fgehUtlu+mj/9GDJ1TfN8nXpP8QbE/UFFq4UjCg
   PxSJIQjErxcWF9tqVJEEt/NX9AQqAFnX89HS7ezhf9q3GcYUaYwmpE336
   MhOYIvcj/4gVrx6lUDxIAqXv8mGspjsOxMTZVR2DBzKwDJ5qTQhVRarYv
   A==;
X-CSE-ConnectionGUID: +O6cIh8VRIuD/zbHh+/hWw==
X-CSE-MsgGUID: e6Hk1cqpSYCK8okdpIvzyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="66915133"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="66915133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 10:00:52 -0800
X-CSE-ConnectionGUID: gyonBzQQS7KxnXu5g8+D5g==
X-CSE-MsgGUID: Xp6e8NnbQCC0lFcwV4kLnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="202199486"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 15 Dec 2025 10:00:46 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVCrv-000000000aD-2VzS;
	Mon, 15 Dec 2025 18:00:30 +0000
Date: Tue, 16 Dec 2025 01:59:37 +0800
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
	Ankur Arora <ankur.a.arora@oracle.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH v8 03/12] arm64/delay: move some constants out to a
 separate header
Message-ID: <202512160125.4rEePFm5-lkp@intel.com>
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
[also build test ERROR on bpf/master linus/master arnd-asm-generic/master v6.19-rc1 next-20251215]
[cannot apply to arm64/for-next/core bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/asm-generic-barrier-Add-smp_cond_load_relaxed_timeout/20251215-130116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251215044919.460086-4-ankur.a.arora%40oracle.com
patch subject: [PATCH v8 03/12] arm64/delay: move some constants out to a separate header
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251216/202512160125.4rEePFm5-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251216/202512160125.4rEePFm5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512160125.4rEePFm5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/qcom/rpmh-rsc.c:29:10: fatal error: asm/delay-const.h: No such file or directory
      29 | #include <asm/delay-const.h>
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


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

