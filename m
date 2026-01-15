Return-Path: <linux-arch+bounces-15811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A7FD28AE8
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9D8D301BCEA
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 21:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859031D8DFB;
	Thu, 15 Jan 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3fypLHz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78940328621;
	Thu, 15 Jan 2026 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511722; cv=none; b=hn/dRFBprjBzMGDFiteObjf+RBuS0FR2n48nsbhKFk+rbDpT/pOyBipNp9Y4dR/ZMZ1xQeDzkvaGIID4zk7NpApdkn9A/EZrWbbdLxPcq15GsMFF2cp1HkVIZLJNeJKD8ZNbSq6tIjR39kPQDgqtGBDan4LV0sKdsI7zbid9HJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511722; c=relaxed/simple;
	bh=1A+T4CJFZG1miay751yy1KYlyXw8N+muZBboZSWUttM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu1W9H8I63bddKm5HBG+x5R1XfJHIvE0CcXrZS83yeYwVf2jNJGxs4WwvoJFWtzZ2Ae2Bxtjrkkl4SOMzNwDVcfBeENP/ET9rgKpsSel9wtuDuhUYggIg6Lv29/PAJrFnMPMysisIyVlHzbugQ3drIVt9r0WNoGNxSSvIWmnsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3fypLHz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768511720; x=1800047720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1A+T4CJFZG1miay751yy1KYlyXw8N+muZBboZSWUttM=;
  b=c3fypLHzPXJXF2CNz0Gg+g8MqwwYO+cuMbhpdcR5RxTP3HSgA5pMlxWP
   gF2mH8rOMKPr8SpeTkccMdKeBhhfisDJPn0BUj2FrOcZcJSPSCAh5u8Dt
   BdzF0TpdbrYuQIyP6dykRytjKu+lJ6n63xp+cwKZHk2Yvdns8aHjL2EAJ
   4byOwlxCbyglBBwQsxWad8noxRbAjBeHzUjVK/pPmJhUNHWaBEvxsdCJJ
   /P5ft7dkcDWLNBAaS3ZKjtJFcGtbbB9IGHF6DG+cv8YCi7yCU5+JF+4/Y
   DFYMIdL2XneyFuEt/37S/FdfPOoWYI7mjR5kkixN6jHgEsk8chcMOTdGn
   g==;
X-CSE-ConnectionGUID: DVDd6mI3T4i+3vcBplmC0w==
X-CSE-MsgGUID: 7jodcQ3WRiuhWhk9HRhPYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80472117"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="80472117"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 13:15:19 -0800
X-CSE-ConnectionGUID: eTlg1CJMQsGmMNMsaXqNIA==
X-CSE-MsgGUID: UV4mjTkQR7uGcxNnXPA2WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="205543257"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jan 2026 13:15:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgUgT-00000000K08-1fPo;
	Thu, 15 Jan 2026 21:15:13 +0000
Date: Fri, 16 Jan 2026 05:14:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v4 3/3] genirq: Adaptive Global Software Interrupt
 Moderation (GSIM).
Message-ID: <202601160433.z2rdE9lE-lkp@intel.com>
References: <20260115155942.482137-4-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115155942.482137-4-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.19-rc5]
[cannot apply to tip/irq/core next-20260115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/genirq-Add-flags-for-software-interrupt-moderation/20260116-000808
base:   linus/master
patch link:    https://lore.kernel.org/r/20260115155942.482137-4-lrizzo%40google.com
patch subject: [PATCH v4 3/3] genirq: Adaptive Global Software Interrupt Moderation (GSIM).
config: mips-randconfig-r051-20260116 (https://download.01.org/0day-ci/archive/20260116/202601160433.z2rdE9lE-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601160433.z2rdE9lE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601160433.z2rdE9lE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/irq/irq_moderation.c:432:40: warning: overflow in expression; result is 1'410'065'408 with type 'long' [-Winteger-overflow]
     432 |                 recent = (now - epoch_start_ns) < 10 * NSEC_PER_SEC;
         |                                                   ~~~^~~~~~~~~~~~~~
   1 warning generated.


vim +432 kernel/irq/irq_moderation.c

   410	
   411	/* Print statistics */
   412	static void rd_stats(struct seq_file *p)
   413	{
   414		ulong global_intr_rate = 0, global_irq_high = 0;
   415		ulong local_irq_high = 0, hardirq_high = 0;
   416		uint delay_us = irq_mod_info.delay_us;
   417		u64 now = ktime_get_ns();
   418		int cpu, active_cpus = 0;
   419	
   420		seq_printf(p, HEAD_FMT,
   421			   "# CPU", "irq/s", "loc_irq/s", "cpus", "delay_ns",
   422			   "irq_hi", "loc_irq_hi", "hardirq_hi", "timer_set",
   423			   "enqueue", "stray_irq");
   424	
   425		for_each_possible_cpu(cpu) {
   426			struct irq_mod_state cur, *m = per_cpu_ptr(&irq_mod_state, cpu);
   427			u64 epoch_start_ns;
   428			bool recent;
   429	
   430			/* Accumulate and print only recent samples */
   431			epoch_start_ns = atomic64_read(&m->epoch_start_ns);
 > 432			recent = (now - epoch_start_ns) < 10 * NSEC_PER_SEC;
   433	
   434			/* Copy statistics, will only use some 32bit values, races ok. */
   435			data_race(cur = *per_cpu_ptr(&irq_mod_state, cpu));
   436			if (recent) {
   437				active_cpus++;
   438				global_intr_rate += cur.global_intr_rate;
   439			}
   440	
   441			global_irq_high += cur.global_irq_high;
   442			local_irq_high += cur.local_irq_high;
   443			hardirq_high += cur.hardirq_high;
   444	
   445			seq_printf(p, BODY_FMT,
   446				   cpu,
   447				   recent * cur.global_intr_rate,
   448				   recent * cur.local_intr_rate,
   449				   recent * (cur.scaled_cpu_count + 128) / 256,
   450				   recent * cur.mod_ns,
   451				   cur.global_irq_high,
   452				   cur.local_irq_high,
   453				   cur.hardirq_high,
   454				   cur.timer_set,
   455				   cur.enqueue,
   456				   cur.stray_irq);
   457		}
   458	
   459		seq_printf(p, "\n"
   460			   "enabled              %s\n"
   461			   "delay_us             %u\n"
   462			   "target_intr_rate     %u\n"
   463			   "hardirq_percent      %u\n"
   464			   "update_ms            %u\n"
   465			   "scale_cpus           %u\n",
   466			   str_yes_no(delay_us > 0),
   467			   delay_us,
   468			   irq_mod_info.target_intr_rate, irq_mod_info.hardirq_percent,
   469			   irq_mod_info.update_ms, irq_mod_info.scale_cpus);
   470	
   471		seq_printf(p,
   472			   "intr_rate            %lu\n"
   473			   "irq_high             %lu\n"
   474			   "my_irq_high          %lu\n"
   475			   "hardirq_percent_high %lu\n"
   476			   "total_interrupts     %u\n"
   477			   "total_cpus           %u\n",
   478			   active_cpus ? global_intr_rate / active_cpus : 0,
   479			   global_irq_high, local_irq_high, hardirq_high,
   480			   READ_ONCE(*((u32 *)&irq_mod_info.total_intrs)),
   481			   READ_ONCE(*((u32 *)&irq_mod_info.total_cpus)));
   482	}
   483	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

