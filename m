Return-Path: <linux-arch+bounces-14836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51699C63CAE
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49649366D39
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F0325705;
	Mon, 17 Nov 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AclkSZCU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559627F727;
	Mon, 17 Nov 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377973; cv=none; b=XajE5f/95B86Ae1O+8i6egSbCPxrILZME6i5e3+oV1MWEap7UBH19aXzlAeXH+bZmDKVJPejz5PsMuO8DQgl6IOQwX4qe75ZK1tRy2y/DQFiMPkvzed4yLRRgkJW8Ov6oS9WkLIEeXrY9KilNABN5xJ8clR+j+7NWW+PlaIwLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377973; c=relaxed/simple;
	bh=uiVn5O+Z2ckh8lfSZDoQxdciZi4Sh+koQbfl/Op6dYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPZaTVRuOkhypHsHxDX6L4WmDg8DQNMk1+n0jzzHnuVdIzryX79Fhq33vF21zZZFQ0Mp0vwvTG6ZfzY8rmzAZ6cbE6KE9zc4SEESmQzA8+bF7+wgaqYtb2ujoqoURbLrfmPXun9W/glvxNYcv+AxYO3X22N6WnLV4PjMjT6Lerw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AclkSZCU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763377971; x=1794913971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uiVn5O+Z2ckh8lfSZDoQxdciZi4Sh+koQbfl/Op6dYw=;
  b=AclkSZCU/rTV7dGTu/uQTpzoQJ2eELTQhAuUy0conpa6ROvghjw8fLpu
   zaqvTCc+64HZU0FVrGx6PZMtjk5QAVHiaRmCTb/LIYnGmGBW7gnxqVHKK
   0YzZWB4FeThBjh9IF5xPCn05wd40ZuCkwTISyM9NlQsQ+p6EkwQvLTWGf
   fuRTVpYaYO2Xv40nXVDAw/Q7jleiY30DEt+QMMnGx6pZt6Z5GL83agsvj
   EJvIZfYJGU/x5GMdodODRzU3tDNLAGnfzt51IZXRNQZbiRcWkCLBqkYHf
   O7oTAB5E2hLX1Y036UUW0rql9MIx5uBOfdctoAMPu7Z/hO3I7TRquJ2Po
   w==;
X-CSE-ConnectionGUID: c5xHgJRGQh+4nk+Nws5ilg==
X-CSE-MsgGUID: U+MuZOxiT1aTJ79u5ePcig==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="90851946"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="90851946"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 03:12:50 -0800
X-CSE-ConnectionGUID: LarFWhw6Q7eLzbFJT0IRVQ==
X-CSE-MsgGUID: Zi9XQFgmQ8u027dmYe6Hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="221317842"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 03:12:47 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKxA5-0000TH-22;
	Mon, 17 Nov 2025 11:12:45 +0000
Date: Mon, 17 Nov 2025 19:12:14 +0800
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
Subject: Re: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
Message-ID: <202511171936.CT5XHXPZ-lkp@intel.com>
References: <20251116182839.939139-3-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116182839.939139-3-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on tip/x86/core tip/master linus/master v6.18-rc6 next-20251114]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/genirq-platform-wide-interrupt-moderation-Documentation-Kconfig-irq_desc/20251117-023148
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20251116182839.939139-3-lrizzo%40google.com
patch subject: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251117/202511171936.CT5XHXPZ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251117/202511171936.CT5XHXPZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511171936.CT5XHXPZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/irq/irq_moderation.c:103: warning: ignoring '#pragma clang diagnostic' [-Wunknown-pragmas]
     103 | #pragma clang diagnostic error "-Wformat"
   In file included from include/linux/uaccess.h:10,
                    from include/linux/sched/task.h:13,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:34,
                    from include/linux/seq_file.h:11,
                    from kernel/irq/irq_moderation.c:8:
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
       inlined from 'moderation_write' at kernel/irq/irq_moderation.c:169:6:
   include/linux/ucopysize.h:54:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
      54 |                         __bad_copy_to();
         |                         ^~~~~~~~~~~~~~~
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
       inlined from 'mode_write' at kernel/irq/irq_moderation.c:223:6:
   include/linux/ucopysize.h:54:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
      54 |                         __bad_copy_to();
         |                         ^~~~~~~~~~~~~~~


vim +103 kernel/irq/irq_moderation.c

   102	
 > 103	#pragma clang diagnostic error "-Wformat"
   104	/* Print statistics */
   105	static int moderation_show(struct seq_file *p, void *v)
   106	{
   107		uint delay_us = irq_mod_info.delay_us;
   108		int j;
   109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

