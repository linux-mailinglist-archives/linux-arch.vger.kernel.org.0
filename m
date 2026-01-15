Return-Path: <linux-arch+bounces-15816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CAD29589
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 00:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4859F3009122
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 23:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7B331202;
	Thu, 15 Jan 2026 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJ9zPm6q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAC3242BE;
	Thu, 15 Jan 2026 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521269; cv=none; b=DvylXby/KC7kJvz7AmqhZqZzlYsd9IkDhDI+kjOMSWR0B5f1JI18MmlgkgXaMpddp2mszhEcZ2YKjXFEuUvD043O0KkzwIsrWKST6f1XouUDcSNhc3vOlMaMPwwar/RFjnO0OSSWV06PyHo8UxQlu5y5zSrVSjoEjDVZOM+5oM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521269; c=relaxed/simple;
	bh=TLB0GUviRxxyCEFiz/4tv7JnV3jow9C9gs3jm5o9LWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+8VypTyCVP7SOJfpUkfPc6e6euvek4D67yobX0NrB2WZG95Bs7bynHcSThZXG2XgDwhXZDPCHopV5R8GeZMne0lZmDdnnaAGETO1kmYr+uKGp9Dt/4dT07jWLZ1US1KW2u5xfje5QhCqPaJ54szUpjRgPb4Z7RZ6NlUTDwfpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJ9zPm6q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768521267; x=1800057267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TLB0GUviRxxyCEFiz/4tv7JnV3jow9C9gs3jm5o9LWM=;
  b=kJ9zPm6qitdhkOcsfo18NYGstxkOWwQtg3xz3jOtGwMHcuPLSJVzudMP
   HO7Xfk7KCP5CFYVfBGinpq3RvhfyOMLkyRWBFVZsvUqHBebD/5nIRkOMQ
   lMur7AVfw4qX2VT5SSMggsNX1pz8G13I3GAcrpFfq5zbtk70XnlEfO3xx
   lMLfTI21rECl4wtWgGQqeDplkxnjg/s6bYo7TK+YYRpcmoMBwfTSfcHL4
   KkaiL90Ey29hni3/mYD1WRUXi5kyKgJd2OL9vsxpk5UbxDirCEOr0aKHP
   /IoGZmImSQibksJb+4YJPO1FYa6ukiYqlX8FlZ5mGyI7hPXTta8ZNYm/H
   Q==;
X-CSE-ConnectionGUID: JaL8DyPqT5iDzsL5sWeriA==
X-CSE-MsgGUID: H7S81aBmRmGBx/1tAuwN6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69735409"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69735409"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 15:54:26 -0800
X-CSE-ConnectionGUID: 4gOa7NMDQfem323HlpNySQ==
X-CSE-MsgGUID: iI6604quQG2dHhkVyzFeag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="209953714"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Jan 2026 15:54:22 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgXAS-00000000K7w-2JtM;
	Thu, 15 Jan 2026 23:54:20 +0000
Date: Fri, 16 Jan 2026 07:53:28 +0800
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
Subject: Re: [PATCH v4 2/3] genirq: Fixed-delay Global Software Interrupt
 Moderation (GSIM)
Message-ID: <202601160733.QNd6lcMA-lkp@intel.com>
References: <20260115155942.482137-3-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115155942.482137-3-lrizzo@google.com>

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
patch link:    https://lore.kernel.org/r/20260115155942.482137-3-lrizzo%40google.com
patch subject: [PATCH v4 2/3] genirq: Fixed-delay Global Software Interrupt Moderation (GSIM)
config: arm-randconfig-r123-20260116 (https://download.01.org/0day-ci/archive/20260116/202601160733.QNd6lcMA-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601160733.QNd6lcMA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601160733.QNd6lcMA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/irq/irq_moderation.c:404:23: sparse: sparse: symbol 'mod_nb' was not declared. Should it be static?
   kernel/irq/irq_moderation.c:298:9: sparse: sparse: context imbalance in 'mode_write' - different lock contexts for basic block
   kernel/irq/irq_moderation.c:330:9: sparse: sparse: context imbalance in 'drain_desc_list' - different lock contexts for basic block

vim +/mod_nb +404 kernel/irq/irq_moderation.c

   403	
 > 404	struct notifier_block mod_nb = {
   405		.notifier_call	= mod_pm_notifier_cb,
   406		.priority	= 100,
   407	};
   408	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

