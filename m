Return-Path: <linux-arch+bounces-14847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F8C6648F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 22:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA0404E2421
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB3324B23;
	Mon, 17 Nov 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpt0/hIM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DEC2FD699;
	Mon, 17 Nov 2025 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415422; cv=none; b=uJOQLCxrVouEZNwdGLrXPgyXTvkp3H8R2aJ3sLSUsVTHRqzIZvTyISTFimqipxbjMugQ5h7Lg6CvBHxDTsLODH+EGHd1cBCx7dCHNARD3ZKIsq3l6xTTn++EKO/Disn9LMMyfuB+IhiAIhqs5STRjks6AgVXDlr2PbnN+P35nLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415422; c=relaxed/simple;
	bh=bf8UyhqPDQoEyCkoewkf1JAlHPpii8P9/c+ZYX7vczg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg+uZTHwSn1+ThkdqvYX+EDuzzpPVjIUpi8m+OleskRtNWeyx2T7od/a85N3bEpIGupbjVSnkv1wpUk+dooD2FgkJffSxXe3H1B5VrSfwxgy2nAB6+ugD8VNuBrTJO76rr5W44B4LwHW1G+E3/H1Z3+9F1llGhVMg2D3Rpl2/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpt0/hIM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763415421; x=1794951421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bf8UyhqPDQoEyCkoewkf1JAlHPpii8P9/c+ZYX7vczg=;
  b=kpt0/hIM5DZm/C+aMWQNHpWYHlFcH9yekKjXJhepp3lCq729GWuEvyDL
   RAJ3LrsYbiluP8s45WVTYUGvp9Vfxfw1pBzsWuj2Vh97zp2PJut4yYmb5
   iJytVWadIlhrJbad/8pycYW6h1gpiM/70TlkPPYYUoFtjRZqpZYYiMH3A
   eUYiARfM+ZIE5smbb2D/9Lw8YRLzy5SSs6quL7IXmpWjSNnMEXbOXfqR7
   +1uxxDMN12n1kmYPh4G5A6nJOwUZCMLPk2HmrQaY4tnRBaMtumeB/uQhn
   t1QLBkzu9859Rz048dnJkhHQfPSpgbe8nTSP/AuuuIgwbxJV7tqlIMyvd
   w==;
X-CSE-ConnectionGUID: Yr2CK2W9TPOqIIE3lOyHRA==
X-CSE-MsgGUID: y8hnCMeuTyGzP1v5/cqh7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65360963"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65360963"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:36:58 -0800
X-CSE-ConnectionGUID: VIADsAQyS8avbJCvaT6BvA==
X-CSE-MsgGUID: QNzfJMSHQ9qewTBflfn7gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="191006777"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2025 13:36:54 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vL6u3-00015R-2h;
	Mon, 17 Nov 2025 21:36:51 +0000
Date: Tue, 18 Nov 2025 05:36:07 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 5/8] x86/irq: soft_moderation: add support for
 posted_msi (intel)
Message-ID: <202511180439.x4dMf653-lkp@intel.com>
References: <20251116182839.939139-6-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116182839.939139-6-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on tip/x86/core tip/master linus/master v6.18-rc6 next-20251117]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/genirq-platform-wide-interrupt-moderation-Documentation-Kconfig-irq_desc/20251117-023148
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20251116182839.939139-6-lrizzo%40google.com
patch subject: [PATCH v2 5/8] x86/irq: soft_moderation: add support for posted_msi (intel)
config: x86_64-buildonly-randconfig-003-20251118 (https://download.01.org/0day-ci/archive/20251118/202511180439.x4dMf653-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511180439.x4dMf653-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511180439.x4dMf653-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/irq/irq_moderation.c:369:6: error: call to undeclared function 'posted_msi_supported'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     369 |                    posted_msi_supported() ? " (also on posted_msi)" : "",
         |                    ^
   1 error generated.


vim +/posted_msi_supported +369 kernel/irq/irq_moderation.c

   321	
   322		seq_printf(p, HEAD_FMT,
   323			   "# CPU", "irq/s", "my_irq/s", "cpus", "srcs", "delay_ns",
   324			   "irq_hi", "my_irq_hi", "hardirq_hi", "timer_set",
   325			   "disable_irq", "from_msi", "timer_calls", "stray_irq");
   326	
   327		for_each_possible_cpu(j) {
   328			struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
   329			u64 age_ms = min((now - ms->last_ns) / NSEC_PER_MSEC, (u64)999999);
   330	
   331			if (age_ms < 10000) {
   332				/* Average irq_rate over recently active CPUs. */
   333				active_cpus++;
   334				irq_rate += ms->irq_rate;
   335			} else {
   336				ms->irq_rate = 0;
   337				ms->my_irq_rate = 0;
   338				ms->scaled_cpu_count = 64;
   339				ms->scaled_src_count = 64;
   340				ms->mod_ns = 0;
   341			}
   342	
   343			irq_high += ms->irq_high;
   344			my_irq_high += ms->my_irq_high;
   345			hardirq_high += ms->hardirq_high;
   346	
   347			seq_printf(p, BODY_FMT,
   348				   j, ms->irq_rate, ms->my_irq_rate,
   349				   (ms->scaled_cpu_count + 128) / 256,
   350				   (ms->scaled_src_count + 128) / 256,
   351				   ms->mod_ns, ms->irq_high, ms->my_irq_high,
   352				   ms->hardirq_high, ms->timer_set, ms->disable_irq,
   353				   ms->from_posted_msi, ms->timer_calls, ms->stray_irq);
   354		}
   355	
   356		seq_printf(p, "\n"
   357			   "enabled              %s%s\n"
   358			   "delay_us             %u\n"
   359			   "timer_rounds         %u\n"
   360			   "target_irq_rate      %u\n"
   361			   "hardirq_percent      %u\n"
   362			   "update_ms            %u\n"
   363			   "scale_cpus           %u\n"
   364			   "count_timer_calls    %s\n"
   365			   "count_msi_calls      %s\n"
   366			   "decay_factor         %u\n"
   367			   "grow_factor          %u\n",
   368			   str_yes_no(delay_us > 0),
 > 369			   posted_msi_supported() ? " (also on posted_msi)" : "",
   370			   delay_us, irq_mod_info.timer_rounds,
   371			   irq_mod_info.target_irq_rate, irq_mod_info.hardirq_percent,
   372			   irq_mod_info.update_ms, irq_mod_info.scale_cpus,
   373			   str_yes_no(irq_mod_info.count_timer_calls),
   374			   str_yes_no(irq_mod_info.count_msi_calls),
   375			   irq_mod_info.decay_factor, irq_mod_info.grow_factor);
   376	
   377		seq_printf(p,
   378			   "irq_rate             %lu\n"
   379			   "irq_high             %lu\n"
   380			   "my_irq_high          %lu\n"
   381			   "hardirq_percent_high %lu\n"
   382			   "total_interrupts     %lu\n"
   383			   "total_cpus           %lu\n",
   384			   active_cpus ? irq_rate / active_cpus : 0,
   385			   irq_high, my_irq_high, hardirq_high,
   386			   READ_ONCE(*((ulong *)&irq_mod_info.total_intrs)),
   387			   READ_ONCE(*((ulong *)&irq_mod_info.total_cpus)));
   388	
   389		return 0;
   390	}
   391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

